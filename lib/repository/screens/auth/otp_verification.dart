import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/data/firebase/firebase_provider.dart';

import '../../../domain/constants/text_contents/texts.dart';
import '../../widgets/home_page/bottom_nav_bar.dart';

class OtpVerificationPage extends StatelessWidget {
  OtpVerificationPage({super.key, required this.mVerificationId});

  final String mVerificationId;

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("otp OtpVerificationPage")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ContentTxt.enterNo,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 22.h),
              Text(ContentTxt.enterNoDesc),
              SizedBox(height: 15.h),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: otpController,
                  maxLength: 6,
                  autofocus: true,
                  decoration: InputDecoration(hintText: "Phone number"),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 0.7.sw,
                child: ElevatedButton(
                  onPressed: () async {
                    if (otpController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("enter valid otp to verify")),
                      );
                    } else {
                      final String otp = otpController.text.trim();

                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                            verificationId: mVerificationId,
                            smsCode: otp,
                          );

                      try {
                        UserCredential userCredential = await FirebaseProvider
                            .firebaseAuth
                            .signInWithCredential(credential);

                        if (userCredential.user != null) {
                          log("yaha collection create karo");

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavBarHome(),
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        log(e.code);
                      } catch (e) {
                        log(
                          "catch error in otp verification page ${e.toString()}",
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text("next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
