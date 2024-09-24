import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vcu/constants.dart';
import 'package:vcu/models/userdata.dart';
import 'package:vcu/screens/handlesignin.dart';
import 'package:vcu/widgets/submit_button.dart';

import '../../widgets/cta_appbar.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key, required this.userData}) : super(key: key);
  final UserData userData;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourPhy = TextEditingController();
  final TextEditingController hourChe = TextEditingController();
  final TextEditingController hourMat = TextEditingController();
  final TextEditingController hourBio = TextEditingController();
  final TextEditingController hourExt = TextEditingController();
  final TextEditingController topicPhy = TextEditingController();
  final TextEditingController topicChe = TextEditingController();
  final TextEditingController topicMat = TextEditingController();
  final TextEditingController topicBio = TextEditingController();
  final TextEditingController topicExt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CtaAppbar(screenname: "Report"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.75,
                    decoration: BoxDecoration(
                        color: kLightGreyColor,
                        borderRadius: BorderRadius.circular(6)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            child: TextField(
                                controller:
                                    dateController, //editing controller of this TextField
                                decoration: const InputDecoration(
                                    icon: Icon(Icons
                                        .calendar_today), //icon of text field
                                    labelText: "Enter Date",
                                    labelStyle:
                                        kContentHeadingStyle //label text of field
                                    ),
                                readOnly:
                                    true, // when true user cannot edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          DateTime.now(), //get today's date
                                      firstDate: DateTime(
                                          2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                    String formattedDate = DateFormat('dd-MM-y')
                                        .format(
                                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2022-07-04
                                    //You can format date as per your need

                                    setState(() {
                                      dateController.text =
                                          formattedDate; //set foratted date to TextField value.
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Time',
                                        style: kContentHeadingStyle,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: 60,
                                        height: 30,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: hourPhy,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 5.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusColor: kOrangeColor,
                                            hintText: 'Hours',
                                            hintStyle: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xff9C9C9C),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 60,
                                        height: 30,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: hourChe,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 5.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusColor: kOrangeColor,
                                            hintText: 'Hours',
                                            hintStyle: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xff9C9C9C),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 60,
                                        height: 30,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: hourMat,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 5.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusColor: kOrangeColor,
                                            hintText: 'Hours',
                                            hintStyle: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xff9C9C9C),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 60,
                                        height: 30,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: hourBio,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 5.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusColor: kOrangeColor,
                                            hintText: 'Hours',
                                            hintStyle: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xff9C9C9C),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 60,
                                        height: 30,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: hourExt,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 5.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusColor: kOrangeColor,
                                            hintText: 'Hours',
                                            hintStyle: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xff9C9C9C),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Subject',
                                          style: kContentHeadingStyle,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 30,
                                          child: TextField(
                                            controller: topicPhy,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      5.0, 5.0, 5.0, 5.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              focusColor: kOrangeColor,
                                              hintText: 'Enter Phy Details',
                                              hintStyle: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xff9C9C9C),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 30,
                                          child: TextField(
                                            controller: topicChe,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      5.0, 5.0, 5.0, 5.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              focusColor: kOrangeColor,
                                              hintText: 'Enter Che Details',
                                              hintStyle: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xff9C9C9C),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 30,
                                          child: TextField(
                                            controller: topicMat,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      5.0, 5.0, 5.0, 5.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              focusColor: kOrangeColor,
                                              hintText: 'Enter Math Details',
                                              hintStyle: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xff9C9C9C),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 30,
                                          child: TextField(
                                            controller: topicBio,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      5.0, 5.0, 5.0, 5.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              focusColor: kOrangeColor,
                                              hintText: 'Enter Bio Details',
                                              hintStyle: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xff9C9C9C),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 30,
                                          child: TextField(
                                            controller: topicExt,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      5.0, 5.0, 5.0, 5.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'Extra Details',
                                              hintStyle: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xff9C9C9C),
                                              ),
                                            ),
                                          ),
                                        ),
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
              SizedBox(
                height: 20,
              ),
              CustomSubmitButton(ontapFunction: () {
                if (dateController.text.isEmpty) {
                  final snackBar = SnackBar(
                    content: Text('Please enter date'),
                    action: SnackBarAction(
                      label: 'Cancel',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  try {
                    final reportData = <String, String>{
                      'uid': widget.userData.uid,
                      'name': widget.userData.name,
                      'std': widget.userData.batch,
                      'batch': widget.userData.batch,
                      'date': dateController.text,
                      'hourPhy': hourPhy.text,
                      'hourChe': hourChe.text,
                      'hourMat': hourMat.text,
                      'hourBio': hourBio.text,
                      'hourExt': hourExt.text,
                      'topicPhy': topicPhy.text,
                      'topicChe': topicChe.text,
                      'topicMat': topicMat.text,
                      'topicBio': topicBio.text,
                      'topicExt': topicExt.text,
                    };
                    db
                        .collection('report')
                        .doc(dateController.text)
                        .collection(
                            '${widget.userData.std}${widget.userData.batch}'
                                .toLowerCase())
                        .doc(widget.userData.name)
                        .set(reportData)
                        .whenComplete(() {
                      setState(() {
                        dateController.text = '';
                        hourPhy.text = '';
                        hourChe.text = '';
                        hourMat.text = '';
                        hourBio.text = '';
                        hourExt.text = '';
                        topicPhy.text = '';
                        topicChe.text = '';
                        topicMat.text = '';
                        topicBio.text = '';
                        topicExt.text = '';

                        final snackBar = SnackBar(
                          content: Text('Report has been submitted!'),
                          action: SnackBarAction(
                            label: 'Cancel',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }).onError((error, stackTrace) =>
                            print("Error writing document: $error"));
                  } on FirebaseException catch (e) {
                    print(e);
                    final snackBar = SnackBar(
                      content: Text(e.message!),
                      action: SnackBarAction(
                        label: 'Cancel',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
