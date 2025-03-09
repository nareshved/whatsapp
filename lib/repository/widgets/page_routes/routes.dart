import 'package:flutter/material.dart';
import 'package:whatsapp/repository/screens/auth/otp_page.dart';
import 'package:whatsapp/repository/widgets/home_page/bottom_nav_bar.dart'
    show BottomNavBarHome;
import '../../screens/auth/login_page.dart';
import '../../screens/auth/signup_page.dart';
import '../../screens/auth/splash_page.dart';
import '../../screens/home/chats/chats_page.dart';
import '../../screens/pages/contact_page.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String loginScreen = '/login_screen';

  static const String signUpScreen = '/sign_up_screen';

  // static const String homeScreen = '/home_screen';

  static const String contactScreen = '/contact_screen';

  static const String chatScreen = '/chat_screen';

  static const String homeNavBarScreen = '/homeNavBar_screen';
  static const String otpLoginPage = '/otp_screen';
  // static const String otpVerificationPage = '/otp_verify_screen';

  static Map<String, WidgetBuilder> get routes => {
    splashScreen: (context) => const SplashPage(),
    loginScreen: (context) => const LoginPage(),
    signUpScreen: (context) => SignUpPage.builder(),
    // homeScreen: (context) => const HomeScreen(),
    contactScreen: (context) => ContactPage(),
    chatScreen: (context) => const HomeChatsPage(),
    homeNavBarScreen: (context) => const BottomNavBarHome(),
    otpLoginPage: (context) => OtpLoginPage(),
    // otpVerificationPage: (context) => OtpVerificationPage(mVerificationId: ,),
  };
}
