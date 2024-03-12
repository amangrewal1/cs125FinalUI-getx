import 'package:aman_s_application9/widgets/app_bar/custom_app_bar.dart';
import 'package:aman_s_application9/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:aman_s_application9/widgets/app_bar/appbar_title.dart';
import 'package:aman_s_application9/widgets/app_bar/appbar_trailing_iconbutton.dart';
import 'package:aman_s_application9/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'controller/add_sleep_controller.dart';

class AddSleepScreen extends GetWidget<AddSleepController> {
  const AddSleepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 28.h, vertical: 18.v),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: _buildHoursOfSleepCard(
                          clock: ImageConstant.imgIconBed,
                          hoursOfSleep: "lbl_bedtime".tr,
                          duration: "lbl_09_00_pm".tr,
                          onTapHoursOfSleepCard: () {
                            openTimePickerDialog();
                          })),
                  SizedBox(height: 14.v),
                  Padding(
                      padding: EdgeInsets.only(left: 2.h, right: 1.h),
                      child: _buildHoursOfSleepCard(
                          clock: ImageConstant.imgClock,
                          hoursOfSleep: "lbl_hours_of_sleep".tr,
                          duration: "msg_8hours_30minutes".tr)),
                  SizedBox(height: 12.v),
                  _buildText(),
                  SizedBox(height: 5.v)
                ])),
            bottomNavigationBar: _buildAdd()));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
        leadingWidth: 62.h,
        leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 30.h, top: 12.v, bottom: 12.v),
            onTap: () {
              onTapArrowLeft();
            }),
        centerTitle: true,
        title: AppbarTitle(text: "lbl_add_sleep".tr),
        actions: [
          AppbarTrailingIconbutton(
              imagePath: ImageConstant.imgDetailNavs,
              margin: EdgeInsets.symmetric(horizontal: 30.h, vertical: 12.v))
        ]);
  }

  /// Section Widget
  Widget _buildText() {
    return Container(
        margin: EdgeInsets.only(right: 2.h),
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 13.v),
        decoration: AppDecoration.fillGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder14),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 3.h, bottom: 2.v),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      CustomImageView(
                          imagePath: ImageConstant.imgLine60,
                          height: 5.adaptSize,
                          width: 5.adaptSize,
                          margin: EdgeInsets.only(top: 1.v)),
                      CustomImageView(
                          imagePath: ImageConstant.imgLine61,
                          height: 6.v,
                          width: 1.h),
                      CustomImageView(
                          imagePath: ImageConstant.imgLine60Gray600,
                          height: 4.adaptSize,
                          width: 4.adaptSize,
                          margin: EdgeInsets.only(top: 1.v))
                    ]),
                    CustomImageView(
                        imagePath: ImageConstant.imgLockOnprimarycontainer,
                        height: 14.v,
                        width: 11.h)
                  ])),
              Padding(
                  padding: EdgeInsets.only(left: 14.h, top: 2.v, bottom: 3.v),
                  child: Text("lbl_stress_level".tr,
                      style: theme.textTheme.bodySmall)),
              Spacer(),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.v),
                  child: Text("lbl_3".tr,
                      style: CustomTextStyles.bodySmallGray500)),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowRightGray500,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  margin: EdgeInsets.only(left: 5.h))
            ]));
  }

  /// Section Widget
  Widget _buildAdd() {
    return CustomElevatedButton(
        text: "lbl_add".tr,
        margin: EdgeInsets.only(left: 31.h, right: 29.h, bottom: 40.v),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles.gradientPrimaryToBlueDecoration,
        onPressed: () {
          naviToHome();
        });
  }

  /// Common widget
  Widget _buildHoursOfSleepCard({
    required String clock,
    required String hoursOfSleep,
    required String duration,
    Function? onTapHoursOfSleepCard,
  }) {
    return GestureDetector(
        onTap: () {
          onTapHoursOfSleepCard!.call();
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 15.v),
            decoration: AppDecoration.fillGray
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder14),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomImageView(
                  imagePath: clock, height: 20.adaptSize, width: 20.adaptSize),
              Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Text(hoursOfSleep,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: appTheme.gray600))),
              Spacer(),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.v),
                  child: Text(duration,
                      style: CustomTextStyles.bodySmallGray500
                          .copyWith(color: appTheme.gray500))),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowRightGray500,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  margin: EdgeInsets.only(left: 5.h, right: 2.h))
            ])));
  }

  /// Navigates to the previous screen.
  onTapArrowLeft() {
    Get.back();
  }

  /// Displays a time picker dialog to update the selected time
  ///
  /// This function returns a `Future` that completes with `void`.
  Future<void> openTimePickerDialog() async {
    TimeOfDay? time = await showTimePicker(
        context: Get.context!,
        initialTime: controller.selectedopenTimePickerDialogTime);
    if (time != null) {
      controller.selectedopenTimePickerDialogTime = time;
    }
  }

  /// Navigates to the homeScreen when the action is triggered.
  naviToHome() {
    Get.offAllNamed(
      AppRoutes.homeScreen,
    );
  }
}
