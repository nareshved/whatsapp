import 'dart:async';
import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/domain/constants/assets_path/assets_path.dart';
import 'package:whatsapp/repository/screens/auth/login_page.dart';
import '../../widgets/page_routes/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      var prefs = await SharedPreferences.getInstance();
      String? myKey = prefs.getString(LoginPageState.loginPrefsKey);

      log("splash page firebase uid : $myKey");

      String navigateTo = AppRoutes.loginScreen;

      if (myKey != null && myKey != "") {
        navigateTo = AppRoutes.homeNavBarScreen;
      }

      Navigator.pushReplacementNamed(context, navigateTo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Color(0xffDC1200),
      // backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeIn(
              animate: true,
              duration: Duration(seconds: 3),
              child: Image.asset(
                ImagesPathProvider.appLogoWhite,
                //   width: 250,
                height: 100,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(height: 40.h),
            FadeIn(
              animate: true,
              duration: Duration(seconds: 2),
              child: Text(
                "One chat",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            FadeIn(
              animate: true,
              duration: Duration(seconds: 2),
              child: Text(
                "Connecting Conversations… Anytime, Anywhere!",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
