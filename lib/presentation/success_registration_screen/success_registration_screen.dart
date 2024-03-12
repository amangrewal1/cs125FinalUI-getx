import 'package:aman_s_application9/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'controller/success_registration_controller.dart';

class SuccessRegistrationScreen
    extends GetWidget<SuccessRegistrationController> {
  const SuccessRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 48.h, top: 102.v, right: 48.h),
                child: Column(children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgGroupBlue200,
                      height: 304.v,
                      width: 277.h),
                  SizedBox(height: 44.v),
                  Text("msg_welcome_stefani".tr,
                      style: theme.textTheme.titleLarge),
                  SizedBox(height: 5.v),
                  Container(
                      width: 210.h,
                      margin: EdgeInsets.only(left: 33.h, right: 34.h),
                      child: Text("msg_you_are_all_set".tr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall!
                              .copyWith(height: 1.50))),
                  SizedBox(height: 5.v)
                ])),
            bottomNavigationBar: _buildGoToHome()));
  }

  /// Section Widget
  Widget _buildGoToHome() {
    return CustomElevatedButton(
        text: "lbl_go_to_home".tr,
        margin: EdgeInsets.only(left: 30.h, right: 30.h, bottom: 40.v),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles.gradientPrimaryToBlueDecoration,
        onPressed: () {
          navigateToHome();
        });
  }

  /// Navigates to the homeScreen when the action is triggered.
  navigateToHome() {
    Get.offNamed(
      AppRoutes.homeScreen,
    );
  }
}
