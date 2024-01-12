import 'package:cookinapp_01/utils/utils.dart';
import 'package:cookinapp_01/view/login/otp_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common_widget/round_button.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading = false;

  final PhoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: PhoneNumberController,
              decoration: InputDecoration(hintText: '+019283983'),
            ),
            const SizedBox(
              height: 80,
            ),
            RoundButton(
              title: 'Login',
              onPressed: () {
                auth.verifyPhoneNumber(
                    phoneNumber: PhoneNumberController.text,
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      utils().toastMessage(e.toString());
                    },
                    codeSent: (String verificationId, int? token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OtpView(verificationId: verificationId)));
                    },
                    codeAutoRetrievalTimeout: (e) {
                      utils().toastMessage(e.toString());
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
