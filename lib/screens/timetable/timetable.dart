import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcu/constants.dart';
import 'package:vcu/models/userdata.dart';
import 'package:vcu/screens/home_screen/home_screen.dart';
import 'package:vcu/screens/timetable/time.dart';

import '../../widgets/cta_appbar.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({Key? key, required this.userData}) : super(key: key);
  final UserData userData;

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

late final timetableRef = FirebaseFirestore.instance
    .collection("timetable")
    .doc(userData!.std.toLowerCase())
    .collection(userData!.batch.toLowerCase());

class _TimetableScreenState extends State<TimetableScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CtaAppbar(screenname: 'Timetable'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: StreamBuilder(
                    stream: timetableRef
                        .orderBy('date', descending: true)
                        .limitToLast(7)
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
                          return Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  decoration: BoxDecoration(
                                      color: kLightGreyColor,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(20),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Center(
                                                child: Text(
                                              document['date'],
                                              style: kContentHeadingStyle,
                                            )),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    const Text(
                                                      'Time',
                                                      style:
                                                          kContentHeadingStyle,
                                                    ),
                                                    Time(
                                                        text:
                                                            document['subj1t'],
                                                        isTime: true),
                                                    Time(
                                                        text:
                                                            document['subj2t'],
                                                        isTime: true),
                                                    Time(
                                                        text:
                                                            document['subj3t'],
                                                        isTime: true),
                                                    Time(
                                                        text:
                                                            document['subj4t'],
                                                        isTime: true),
                                                    Time(
                                                        text:
                                                            document['subj5t'],
                                                        isTime: true),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Subject',
                                                        style:
                                                            kContentHeadingStyle,
                                                      ),
                                                      Time(
                                                          text:
                                                              document['subj1'],
                                                          isTime: false),
                                                      Time(
                                                          text:
                                                              document['subj2'],
                                                          isTime: false),
                                                      Time(
                                                          text:
                                                              document['subj3'],
                                                          isTime: false),
                                                      Time(
                                                          text:
                                                              document['subj4'],
                                                          isTime: false),
                                                      Time(
                                                          text:
                                                              document['subj5'],
                                                          isTime: false),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
