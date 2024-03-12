import 'package:aman_s_application9/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'controller/register_page_sleep_goal_controller.dart';

class RegisterPageSleepGoalScreen
    extends GetWidget<RegisterPageSleepGoalController> {
  const RegisterPageSleepGoalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 29.h, vertical: 46.v),
                child: Column(children: [
                  Text("msg_what_is_your_sleep".tr,
                      style: theme.textTheme.titleLarge),
                  SizedBox(
                      width: 179.h,
                      child: Text("msg_it_will_help_us2".tr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall!
                              .copyWith(height: 1.50))),
                  SizedBox(height: 28.v),
                  _buildTwentyTwo(),
                  SizedBox(height: 5.v)
                ])),
            bottomNavigationBar: _buildConfirm()));
  }

  /// Section Widget
  Widget _buildTwentyTwo() {
    return Container(
        margin: EdgeInsets.only(left: 2.h),
        padding: EdgeInsets.all(9.h),
        decoration: AppDecoration.fillGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder14),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Padding(
              padding: EdgeInsets.only(top: 1.v),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("lbl_z".tr, style: theme.textTheme.bodySmall),
                    Align(
                        alignment: Alignment.centerRight,
                        child:
                            Text("lbl_z".tr, style: theme.textTheme.bodySmall))
                  ])),
          Padding(
              padding: EdgeInsets.only(left: 21.h, top: 6.v, bottom: 4.v),
              child: Text("lbl_sleep_goal".tr,
                  style: CustomTextStyles.bodySmallGray500_1)),
          Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowdown,
              height: 18.adaptSize,
              width: 18.adaptSize,
              margin: EdgeInsets.only(top: 5.v, right: 6.h, bottom: 5.v))
        ]));
  }

  /// Section Widget
  Widget _buildConfirm() {
    return CustomElevatedButton(
        text: "lbl_confirm".tr,
        margin: EdgeInsets.only(left: 30.h, right: 30.h, bottom: 40.v),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles.gradientPrimaryToBlueDecoration,
        onPressed: () {
          navigateToSuccess();
        });
  }

  /// Navigates to the successRegistrationScreen when the action is triggered.
  navigateToSuccess() {
    Get.toNamed(
      AppRoutes.successRegistrationScreen,
    );
  }
}
