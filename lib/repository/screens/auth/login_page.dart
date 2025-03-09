import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/data/bloc/chat/register_bloc.dart';

import '../../widgets/page_routes/routes.dart';
import '../../widgets/text_feild/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  static const String loginPrefsKey = "isLogin";

  final mFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LoginPage")),
      body: Form(
        key: mFormKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login Your Account!",

                  style: TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 19),
                myTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter a email";
                    }
                    return null;
                  },
                  mcrontroller: emailController,
                  hinttxt: "Enter Your email",
                  labelTxt: "Email",
                  preIcon: const Icon(Icons.email),
                ),
                const SizedBox(height: 12),
                myTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter a password";
                    }
                    return null;
                  },
                  mcrontroller: passController,
                  hinttxt: "Enter Your password",
                  labelTxt: "password",
                  preIcon: const Icon(Icons.remove_red_eye),
                ),
                const SizedBox(height: 12),
                BlocConsumer<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state is ChatErrorState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
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
                            SizedBox(width: 11),
                            Text("Loading....."),
                          ],
                        ),
                      );
                    }

                    return ElevatedButton(
                      onPressed: () {
                        if (mFormKey.currentState!.validate()) {
                          String email = emailController.text.toString();
                          String password = passController.text.toString();

                          if (email.isNotEmpty && password.isNotEmpty) {
                            BlocProvider.of<ChatBloc>(context).add(
                              LoginUserEvent(
                                ctx: context,
                                loginEmail: email,
                                loginPassword: password,
                              ),
                            );
                          }
                        }
                      },
                      child: const Text("login"),
                    );
                  },
                ),
                const SizedBox(height: 25),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signUpScreen);
                  },
                  child: const Text("Create An Account"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// abhhhi

// (
//                   onPressed: () async {
//                     // BlocProvider.of<RegisterBloc>(context).add(LoginUserEvent(
//                     //   loginEmail: emailController.text.toString(), loginPassword: passController.text.toString()));

//                     /// firebase login

//                     String email = emailController.text;
//                     String password = passController.text;

//                     if (emailController.text.isNotEmpty &&
//                         passController.text.isNotEmpty) {
//                       try {
//                         UserCredential credential = await FirebaseAuth.instance
//                             .signInWithEmailAndPassword(
//                                 email: email, password: password);

//                         var prefs = await SharedPreferences.getInstance();
//                         prefs.setString(
//                             LoginPageState.loginPrefsKey, credential.user!.uid);

//                         log("login page firebase prefs uid ${credential.user!.uid}");

//                         /// const remove

//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const BottomNavBarHome(),
//                             ));

//                         ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text("SuccessFully Account Login")));
//                       } on FirebaseException catch (myErrors) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(myErrors.code)));
//                       }
//                     }

//                     /// if
//                     emailController.clear();
//                     passController.clear();
//                   },
//                   child: const Text("Login Now!"))
