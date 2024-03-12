import 'package:flutter/material.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'controller/splash_page_controller.dart';

class SplashPageScreen extends GetWidget<SplashPageController> {
  const SplashPageScreen({Key? key}) : super(key: key);

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
                    ]))));
  }
}
