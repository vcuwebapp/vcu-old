import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomSignOutButton extends StatelessWidget {
  const CustomSignOutButton({Key? key}) : super(key: key);
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _signOut();
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff404040),
          borderRadius: BorderRadius.circular(6),
        ),
        height: 50,
        child: const Center(
          child: Text(
            'Sign out',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
