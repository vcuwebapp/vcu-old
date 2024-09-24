import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vcu/constants.dart';
import 'package:vcu/screens/home_screen/home_screen.dart';
import 'package:vcu/widgets/submit_button.dart';

class HandleSignIn extends StatefulWidget {
  const HandleSignIn({Key? key}) : super(key: key);

  @override
  State<HandleSignIn> createState() => _HandleSignInState();
}

TextEditingController nameController = TextEditingController();
TextEditingController feesController = TextEditingController();
String std = 'xi';
String dropdownvalue = 'Regular';
int fees = 0;
final db = FirebaseFirestore.instance;
final uid = FirebaseAuth.instance.currentUser?.uid;

// List of items in our dropdown menu
var items = [
  'Regular',
  'Engineering',
  'Medical',
];

class _HandleSignInState extends State<HandleSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: kTypicalCardDecor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text(
                'Enter Details',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kHeadingColor),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    focusColor: kOrangeColor,
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(
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
                        "XI",
                        style: kContentHeadingStyle,
                      ),
                      value: "xi",
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
                        "XII",
                        style: kContentHeadingStyle,
                      ),
                      value: "xii",
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
                  controller: feesController,
                  decoration: const InputDecoration(
                    focusColor: kOrangeColor,
                    hintText: 'Enter fees paid Eg "30000"',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xff9C9C9C),
                    ),
                  ),
                ),
              ),
              CustomSubmitButton(
                ontapFunction: () {
                  if (nameController.text.isEmpty) {
                    final snackBar = SnackBar(
                      content: Text('Please enter name'),
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
                    FirebaseAuth.instance.currentUser
                        ?.updateDisplayName(nameController.text);

                    final userdata = <String, String>{
                      'uid': uid!,
                      'name': nameController.text,
                      'std': std.toLowerCase(),
                      'batch': dropdownvalue.toLowerCase(),
                      'feespaid': feesController.text,
                      'batchname': '${std}${dropdownvalue}'.toLowerCase()
                    };

                    db.collection('students').doc(uid).set(userdata).onError(
                        (error, stackTrace) =>
                            print("Error writing document: $error"));

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    )));
  }
}
