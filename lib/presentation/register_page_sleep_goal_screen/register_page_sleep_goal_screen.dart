import 'package:aman_s_application9/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'controller/register_page_sleep_goal_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RegisterPageSleepGoalScreen
    extends GetWidget<RegisterPageSleepGoalController> {
  const RegisterPageSleepGoalScreen({Key? key}) : super(key: key);

// Function to save data to local storage
  Future<void> saveDataToLocal({
    required String sleep_time
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve existing data or initialize an empty map
    Map<String, dynamic> data = prefs.getString('wakeGoal') != null
        ? json.decode(prefs.getString('wakeGoal')!) // Use json.decode
        : {};

    data['wakeGoal'] = {'hour' : controller.selectedopenTimePickerDialogTime.hour, 'minute' : controller.selectedopenTimePickerDialogTime.minute};

    print('Data to be saved: {\'wakeGoal\':${controller.bedtime.value}}');
    print(data);

    // Save updated data to local storage
    await prefs.setString('wakeGoal', json.encode(data));
  }

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
                      width: 250.h,
                      child: Text("Select your wakeup time to help us provide you with a personalized sleep schedule",
                          maxLines: 2,
                          //overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall!
                              .copyWith(height: 1.50))),
                  SizedBox(height: 28.v),
                  _buildTwentyTwo(),
                  SizedBox(height: 5.v)
                ])),
            bottomNavigationBar: _buildConfirm()));
  }

  Widget _buildTwentyTwo() {
    return Obx(() => InkWell(
      onTap: () {
        openTimePickerDialog(); // Call your function to open the time picker dialog
      },
      child: Container(
        margin: EdgeInsets.only(left: 2.h),
        padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 9.h),
        decoration: AppDecoration.fillGray.copyWith(borderRadius: BorderRadiusStyle.roundedBorder14),
        child: Row(
          children: [
            Text(
              controller.bedtime.value, // Display selected time
              style: CustomTextStyles.bodySmallGray500_1,
            ),
            SizedBox(width: 8), // Add some spacing between time text and icon
            CustomImageView(
              imagePath: ImageConstant.imgArrowdown,
              height: 18.adaptSize,
              width: 18.adaptSize,
            ),
          ],
        ),
      ),
    ));
  }

  /// Section Widget
  Widget _buildConfirm() {
    return CustomElevatedButton(
        text: "lbl_confirm".tr,
        margin: EdgeInsets.only(left: 30.h, right: 30.h, bottom: 40.v),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles.gradientPrimaryToBlueDecoration,
        onPressed: () {
          saveDataToLocal(sleep_time: controller.bedtime.value);
          navigateToSuccess();
        });
  }

  /// Displays a time picker dialog to update the selected time
  ///
  /// This function returns a `Future` that comple tes with `void`.
  Future<void> openTimePickerDialog() async {
    TimeOfDay? time = await showTimePicker(
      context: Get.context!,
      initialTime: controller.selectedopenTimePickerDialogTime,
    );
    if (time != null) {
      // Format the selected time to standard time format
      String period = time.hour >= 12 ? 'PM' : 'AM';
      int hour = time.hour > 12 ? time.hour - 12 : time.hour;
      hour = hour == 0 ? 12 : hour; // Handle midnight (12 AM)

      // Format the selected time
      String formattedTime = '$hour:${time.minute.toString().padLeft(2, '0')} $period';

      // Update the Rx variable with the formatted time
      controller.bedtime.value = formattedTime;
      controller.selectedopenTimePickerDialogTime = time;
      // Update the state to trigger a rebuild of the widget tree
      controller.update();
    }
  }

  /// Navigates to the successRegistrationScreen when the action is triggered.
  navigateToSuccess() {
    Get.toNamed(
      AppRoutes.successRegistrationScreen,
    );
  }
}