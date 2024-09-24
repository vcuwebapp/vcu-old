import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vcu/constants.dart';
import 'package:vcu/models/userdata.dart';
import 'package:vcu/screens/doubts/viewdoubts.dart';
import 'package:vcu/screens/handlesignin.dart';
import 'package:vcu/widgets/submit_button.dart';

import '../../widgets/cta_appbar.dart';

class DoubtScreen extends StatefulWidget {
  DoubtScreen({Key? key, required this.userData}) : super(key: key);

  final UserData userData;

  @override
  State<DoubtScreen> createState() => _DoubtScreenState();
}

class _DoubtScreenState extends State<DoubtScreen> {
  final TextEditingController topicController = TextEditingController();
  final TextEditingController doubtController = TextEditingController();

  String dropdownvalue = 'Physics';
  final ent = 'yes';
  var items = ['Physics', 'Chemistry', 'Mathematics', 'Biology'];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CtaAppbar(screenname: 'Ask Doubt'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChatDoubt(userData: widget.userData)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff404040),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 50,
                    child: const Center(
                      child: Text(
                        'View Doubts',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: BoxDecoration(
                      color: kLightGreyColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: Column(
                    children: [
                      DropdownButton(
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
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: topicController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: kOrangeColor,
                            hintText: 'Enter topic name',
                            errorText: topicController.text.isEmpty
                                ? 'Enter Topic'
                                : null,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xff9C9C9C),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextField(
                          maxLines: 7,
                          controller: doubtController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter Doubt',
                            errorText: doubtController.text.isEmpty
                                ? 'Enter Doubt'
                                : null,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xff9C9C9C),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: RadioListTile(
                              title: Text(
                                "Non-Entrance",
                                style: kContentHeadingStyle,
                              ),
                              value: "no",
                              groupValue: std,
                              onChanged: (value) {
                                setState(() {
                                  std = value.toString();
                                  print(std);
                                });
                              },
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: RadioListTile(
                              title: Text(
                                "Entrance",
                                style: kContentHeadingStyle,
                              ),
                              value: "yes",
                              groupValue: std,
                              onChanged: (value) {
                                setState(() {
                                  std = value.toString();
                                  print(std);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CustomSubmitButton(ontapFunction: () {
                    if (doubtController.text.isEmpty &
                        topicController.text.isEmpty) {
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 5),
                        content: Text('Please enter valid doubt'),
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
                        final doubtData = <String, String>{
                          'ent': std,
                          'uid': widget.userData.uid,
                          'name': widget.userData.name,
                          'batch': '${widget.userData.batchname}'.toLowerCase(),
                          'topicname': topicController.text,
                          'doubt': doubtController.text,
                          'subject': dropdownvalue.toLowerCase(),
                          'clearst': 'false'
                        };
                        print(doubtData);

                        final addr = std == 'yes'
                            ? 'ent${dropdownvalue}doubts'
                            : '${dropdownvalue}doubts';

                        db
                            .collection(addr.toLowerCase())
                            .doc(topicController.text)
                            .set(doubtData)
                            .whenComplete(() {
                          setState(() {
                            doubtController.text = '';
                            topicController.text = '';
                            final snackBar = SnackBar(
                              content: Text('Doubt has been submitted!'),
                              action: SnackBarAction(
                                label: 'Cancel',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );

                            // Find the ScaffoldMessenger in the widget tree
                            // and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        }).onError((error, stackTrace) =>
                                print("Error writing document: $error"));
                      } on FirebaseException catch (e) {
                        print(e);
                        final snackBar = SnackBar(
                          duration: Duration(seconds: 5),
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
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
