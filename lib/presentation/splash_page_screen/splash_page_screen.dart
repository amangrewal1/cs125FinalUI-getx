import 'package:flutter/material.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPageScreen extends StatefulWidget {
  const SplashPageScreen({Key? key}) : super(key: key);

  @override
  _SplashPageScreenState createState() => _SplashPageScreenState();
}

class _SplashPageScreenState extends State<SplashPageScreen> {
  @override
  void initState() {
    //clearSharedPreferences();     // UNCOMMENT TO CLEAR LOCAL DATA
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      navigateToNextScreen();
    });
  }

  Future<void> clearSharedPreferences() async { //debugging
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userDataExists = prefs.containsKey('userData');

    if (userDataExists) {
      // Navigate to home screen if userData exists
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
    } else {
      // Navigate to welcome screen if userData does not exist
      Navigator.of(context).pushReplacementNamed(AppRoutes.welcomeScreenOneScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 55.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 4.v),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "lbl_antsleeper".tr,
                        style: theme.textTheme.displaySmall,
                      ),
                      TextSpan(
                        text: "lbl_x".tr,
                        style: theme.textTheme.displayMedium,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 2.v),
              Text(
                "msg_everybody_can_sleep".tr,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}