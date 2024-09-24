import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vcu/constants.dart';
import 'package:vcu/models/userdata.dart';
import 'package:vcu/screens/account/account.dart';
import 'package:vcu/screens/home_screen/carousel.dart';

import 'cta/ctas.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



final docRef = FirebaseFirestore.instance
    .collection("students")
    .doc(FirebaseAuth.instance.currentUser?.uid);

final imgRef = FirebaseFirestore.instance.collection("carousel").doc('images');

UserData? userData;

class _HomePageState extends State<HomePage> {

  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();
    final token  = await fcm.getToken();
    final userTokdata = <String, String>{

      'token': token!
    };
    docRef.update(userTokdata).onError(
            (error, stackTrace) =>
            print("Error writing document: $error"));
    fcm.subscribeToTopic(userData!.batchname);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: GoogleFonts.poppins(
                      color: kHeadingColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w700),
                ),
              ],
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: docRef.get().then((DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          userData = UserData(
              uid: data['uid'],
              std: data['std'],
              batch: data['batch'],
              feespaid: data['feespaid'],
              name: data['name'],
              batchname: data['batchname']);
        }, onError: (e) => print(e)),
        builder: (_, snapshot) {
          if (userData != null) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.width / 2,
                        child: Carousel()),
                    CTAS(
                      userData: userData!,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          // FirebaseAuth.instance.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccountScreen(
                                        user: userData!,
                                      )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff404040),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 50,
                          child: const Center(
                            child: Text(
                              'My Account',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         Container(
      //             height: MediaQuery.of(context).size.width / 2,
      //             child: Carousel()),
      //         CTAS(
      //           userData: userData,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 20),
      //           child: GestureDetector(
      //             onTap: () {
      //               // FirebaseAuth.instance.signOut();
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => AccountScreen(
      //                             user: userData,
      //                           )));
      //             },
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 color: Color(0xff404040),
      //                 borderRadius: BorderRadius.circular(6),
      //               ),
      //               height: 50,
      //               child: const Center(
      //                 child: Text(
      //                   'My Account',
      //                   style: TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 24,
      //                       fontWeight: FontWeight.w900),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
