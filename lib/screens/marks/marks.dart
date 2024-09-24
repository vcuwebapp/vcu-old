import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcu/constants.dart';
import 'package:vcu/models/userdata.dart';
import 'package:vcu/screens/marks/marks_card.dart';
import 'package:vcu/widgets/cta_appbar.dart';

class MarksScreen extends StatefulWidget {
  MarksScreen({Key? key, required this.userData}) : super(key: key);

  final UserData userData;

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  final docdata = [];

  late final marksRef = FirebaseFirestore.instance
      .collection("marks")
      .doc('${widget.userData.std}${widget.userData.batch}'.toLowerCase());

  String dropdownvalue = 'Physics';
  var items = [
    'Physics',
    'Chemistry',
    'Mathematics',
    'Biology',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CtaAppbar(screenname: "Marks"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 30,
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                  StreamBuilder(
                      stream: marksRef
                          .collection(dropdownvalue.toLowerCase())
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return Center(
                              child: Text(
                            'No Data Is Available',
                            style: kContentHeadingStyle,
                          ));
                        }
                        return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: snapshot.data!.docs.map((document) {
                            return MarksCard(
                                subject: document['subject'],
                                date: document['date'],
                                marksobt: document[widget.userData.name],
                                outof: document['totalmarks']);
                          }).toList(),
                        );
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
