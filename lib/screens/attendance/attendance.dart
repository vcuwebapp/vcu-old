import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcu/constants.dart';
import 'package:vcu/models/userdata.dart';
import 'package:vcu/screens/attendance/days_absentcard.dart';
import 'package:vcu/screens/attendance/showpercentindicator.dart';
import 'package:vcu/widgets/cta_appbar.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key, required this.userData}) : super(key: key);
  final UserData userData;

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

final docdata = [];
final presdata = [];

class _AttendanceScreenState extends State<AttendanceScreen> {
  int? totalatt;
  int? totalpres;
  double? percent;
  late final attendanceRef = FirebaseFirestore.instance
      .collection("attendance")
      .doc(widget.userData.std.toLowerCase())
      .collection(widget.userData.batch.toLowerCase());

  Future getTotal() async {
    // Get docs from collection reference
    final QuerySnapshot qSnap = await attendanceRef.get();
    final QuerySnapshot querySnapshot =
        await attendanceRef.where(widget.userData.name, isEqualTo: true).get();
    totalatt = qSnap.docs.length;
    totalpres = querySnapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CtaAppbar(screenname: 'Attendance'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   decoration: kTypicalCardDecor,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(20.0),
                //         child: CircularPercentIndicator(
                //           radius: 50,
                //           lineWidth: 15,
                //           percent: 0,
                //           animation: true,
                //           animationDuration: 30,
                //           progressColor: kOrangeColor,
                //           center: Text(
                //             '30/60', style: kContentHeadingStyle,
                //           ),
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // ),
                FutureBuilder(
                    future: getTotal(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CustomPercentCard(
                          total: totalatt!,
                          pres: totalpres!,
                        );
                      } else {
                        return Center(child: const CircularProgressIndicator());
                      }
                    }),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    ' Days Absent',
                    style: kContentHeadingStyle,
                  ),
                ),
                // AbsentCard(absentDate: '31 March 2022')
                StreamBuilder(
                    stream: attendanceRef
                        .where(widget.userData.name, isEqualTo: false)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map((document) {
                          print(document);
                          return AbsentCard(
                            absentDate: document['date'],
                          );
                        }).toList(),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
