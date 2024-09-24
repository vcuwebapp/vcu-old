import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcu/constants.dart';
import 'package:vcu/models/userdata.dart';
import 'package:vcu/widgets/cta_appbar.dart';
import 'package:vcu/widgets/singout_button.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserData user;

  final docRef = FirebaseFirestore.instance.collection("feesdate");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CtaAppbar(screenname: "Account"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: kHeadingStyle,
            ),
            Text(
              user.name,
              style: kContentHeadingStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('Batch', style: kHeadingStyle),
            ),
            Text(
              '${user.std} ${user.batch}'.toUpperCase(),
              style: kContentHeadingStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('Fees Pending', style: kHeadingStyle),
            ),
            Text(
              user.feespaid,
              style: kContentHeadingStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('To be paid by', style: kHeadingStyle),
            ),
            StreamBuilder(
                stream: docRef
                    .where('dname',
                        isEqualTo:
                            '${user.std.toLowerCase()}${user.batch.toLowerCase()}')
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
                      return Text(
                        document['date'],
                        style: kContentHeadingStyle,
                      );
                    }).toList(),
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: CustomSignOutButton(),
            )
          ],
        ),
      ),
    );
  }
}
