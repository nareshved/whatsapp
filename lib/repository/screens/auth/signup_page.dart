import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bloc/chat/register_bloc.dart';
import '../../../data/firebase/firebase_provider.dart';
import '../../../domain/models/user_model.dart';
import '../../widgets/text_feild/text_field.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  ///my app pe bloc provider
  ///
  ///
  @override
  State<SignUpPage> createState() => _SignUpPageState();

  static Widget builder() {
    return RepositoryProvider(
      create: (context) => FirebaseProvider(),
      child: BlocProvider(
        create: (context) => ChatBloc(
          firebaseProvider: RepositoryProvider.of<FirebaseProvider>(context),
        ),
        child: const SignUpPage(),
      ),
    );
  }
}

//
//
//   static Widget builder() {
//     return const SignUpPage();
//   }
// }

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final mFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUpPage"),
      ),
      body: Form(
        key: mFormKey,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "SignUp To Create Account!",
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 19,
              ),
              myTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "enter name please";
                  }  return null;
                },
                mcrontroller: nameController,
                hinttxt: "Enter Your password",
                labelTxt: "password",
                preIcon: const Icon(Icons.usb_rounded),
              ),
              myTextField(
                validator: (value) {
                  const pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                  final regExp = RegExp(pattern);

                  if (value!.isEmpty) {
                    return "Email can't be empty!";
                  } else if (!regExp.hasMatch(value)) {
                    return "Please enter a valid email!";
                  }  return null;
                },
                mcrontroller: emailController,
                hinttxt: "Enter Your email",
                labelTxt: "Email",
                preIcon: const Icon(Icons.email),
              ),
              const SizedBox(
                height: 12,
              ),
              myTextField(
                validator: (value) {
                  if (value!.length <= 7) {
                    return "Length should be greater than 7";
                  }  return null;
                },
                mcrontroller: passController,
                hinttxt: "Enter Your password",
                labelTxt: "password",
                preIcon: const Icon(Icons.remove_red_eye),
              ),
              const SizedBox(
                height: 12,
              ),
              BlocConsumer<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state is ChatLoadedState) {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  } else if (state is ChatErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  }
                },
                builder: (context, state) {
                  if (state is ChatLoadingState) {
                    return ElevatedButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              width: 11,
                            ),
                            Text('Loading')
                          ],
                        ));
                  }
                  return ElevatedButton(
                      onPressed: () async {
                        /// firebase sign Up

                        if (mFormKey.currentState!.validate()) {
                          String email = emailController.text;
                          String password = passController.text;
                          String name = nameController.text;

                          if (emailController.text.isNotEmpty &&
                              passController.text.isNotEmpty) {
                            var newUser = UserModel(
                                name: name,
                                email: email,
                                mobNo: "9876543321",
                                gender: "Male",
                                isOnline: false,
                                status: 1,
                                profilePic: "wait",
                                profileStatus: 1);

                            BlocProvider.of<ChatBloc>(context).add(
                                CreateUserEvent(
                                    newUser: newUser, pass: password));
                          }

                          /// if
                        }
                      },
                      child: const Text("SignUp Now!"));
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  },
                  child: const Text("Go Login Page")),
            ],
          ),
        )),
      ),
    );
  }
}
