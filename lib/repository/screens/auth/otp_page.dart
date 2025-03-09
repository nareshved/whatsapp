import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/data/firebase/firebase_provider.dart';
import 'package:whatsapp/domain/constants/text_contents/texts.dart';
import 'otp_verification.dart';

class OtpLoginPage extends StatelessWidget {
  OtpLoginPage({super.key});

  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    controller: mobileController,
                    maxLength: 10,
                    autofocus: true,
                    decoration: InputDecoration(hintText: "Phone number"),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 0.7.sw,
                  child: ElevatedButton(
                    onPressed: () {
                      if (mobileController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Enter mobile number")),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: Text(
                                  "is this the correct number",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                content: Text(
                                  mobileController.text.trim().toString(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Edit",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      try {
                                        await FirebaseProvider.firebaseAuth
                                            .verifyPhoneNumber(
                                              phoneNumber:
                                                  "+91${mobileController.text}",
                                              verificationCompleted: (
                                                phoneAuthCredential,
                                              ) {
                                                log("verificationCompleted");
                                              },
                                              verificationFailed: (error) {
                                                log("verificationFailed");
                                              },
                                              codeSent: (
                                                verificationId,
                                                forceResendingToken,
                                              ) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            OtpVerificationPage(
                                                              mVerificationId:
                                                                  verificationId,
                                                            ),
                                                  ),
                                                );
                                              },
                                              codeAutoRetrievalTimeout: (
                                                verificationId,
                                              ) {
                                                log("verificationId");
                                              },
                                            );
                                      } catch (e) {
                                        log(
                                          "new error found in otp firebase ${e.toString()}",
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Yes",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                        );
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
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:one_chat_app/domain/constants/text_contents/texts.dart';

// class OtpPage extends StatelessWidget {
//   const OtpPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(ContentTxt.enterNo),
//             Text(ContentTxt.enterNoDesc),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(width: 40, child: TextFormField()),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 SizedBox(width: 300, child: TextFormField()),
//               ],
//             ),
//             ElevatedButton(onPressed: () {}, child: Text("hdsfgg"))
//           ],
//         ),
//       ),
//     );
//   }
// }
