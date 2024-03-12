import 'package:aman_s_application9/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'controller/welcome_screen_one_controller.dart';

class WelcomeScreenOneScreen extends GetWidget<WelcomeScreenOneController> {
  const WelcomeScreenOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding:
                    EdgeInsets.symmetric(horizontal: 55.h, vertical: 261.v),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Align(
                          alignment: Alignment.centerRight,
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "lbl_antsleeper".tr,
                                    style: theme.textTheme.displaySmall),
                                TextSpan(
                                    text: "lbl_x".tr,
                                    style: theme.textTheme.displayMedium)
                              ]),
                              textAlign: TextAlign.left)),
                      SizedBox(height: 2.v),
                      Text("msg_everybody_can_sleep".tr,
                          style: theme.textTheme.bodyLarge)
                    ])),
            bottomNavigationBar: _buildGetStarted()));
  }

  /// Section Widget
  Widget _buildGetStarted() {
    return CustomElevatedButton(
        text: "lbl_get_started".tr,
        margin: EdgeInsets.only(left: 30.h, right: 30.h, bottom: 40.v),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles.gradientPrimaryToBlueDecoration,
        onPressed: () {
          navitowelcome();
        });
  }

  /// Navigates to the welcomeScreen2Screen when the action is triggered.
  navitowelcome() {
    Get.toNamed(
      AppRoutes.welcomeScreen2Screen,
    );
  }
}
