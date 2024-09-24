import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcu/constants.dart';
import 'package:vcu/models/userdata.dart';
import 'package:vcu/screens/assignment/api.dart';
import 'package:vcu/screens/assignment/subject_card.dart';
import 'package:vcu/screens/assignment/viewpdf.dart';
import 'package:vcu/screens/home_screen/home_screen.dart';
import 'package:vcu/widgets/cta_appbar.dart';

class ShowAssignment extends StatefulWidget {
  const ShowAssignment({Key? key, required this.userData}) : super(key: key);

  final UserData userData;

  @override
  State<ShowAssignment> createState() => _ShowAssignmentState();
}

@override
class _ShowAssignmentState extends State<ShowAssignment> {
  void openPdf(BuildContext context, File file, String docName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewPdf(
                  file: file,
                  docname: docName,
                )));
  }

  final assRef = FirebaseFirestore.instance
      .collection("assignment")
      .doc('${userData!.std}${userData!.batch}'.toLowerCase());
  String dropdownvalue = 'Physics';
  var items = [
    'Physics',
    'Chemistry',
    'Mathematics',
    'Biology',
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CtaAppbar(screenname: 'Assignment'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: assRef
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
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        print(document);
                        return SubjectCard(
                            subjectTitle: document['topicname'],
                            onTap: () async {
                              final url = document['url'];
                              final file = await PDFApi.loadNetwork(url);
                              openPdf(context, file, document['topicname']);
                            });
                      }).toList(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
