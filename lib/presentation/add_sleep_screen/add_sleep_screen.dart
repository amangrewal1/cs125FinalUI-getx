import 'package:aman_s_application9/widgets/app_bar/custom_app_bar.dart';
import 'package:aman_s_application9/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:aman_s_application9/widgets/app_bar/appbar_title.dart';
import 'package:aman_s_application9/widgets/app_bar/appbar_trailing_iconbutton.dart';
import 'package:aman_s_application9/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'controller/add_sleep_controller.dart';
//for saving to local
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class AddSleepScreen extends GetWidget<AddSleepController> {
  const AddSleepScreen({Key? key}) : super(key: key);

  String _generateDateString(DateTime date) {
    // Format the date string in a consistent format
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Function to save data to local storage
  Future<void> saveDataToLocal({
    required DateTime date,
    required String bedtime,
    required String hoursOfSleep,
    required String stressLevel,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dateString = _generateDateString(date);
    // Print out the data just before saving
    print('Data to be saved: {date: $dateString, bedtime: $bedtime, hoursOfSleep: $hoursOfSleep, stressLevel: $stressLevel}');
    // Retrieve existing sleep data or initialize an empty map
    Map<String, dynamic> sleepData = prefs.getString('sleepData') != null
        ? json.decode(prefs.getString('sleepData')!)
        : {};

    // Update data with new values for the current date
    sleepData[dateString] = {
      'bedtime': bedtime,
      'hoursOfSleep': hoursOfSleep,
      'stressLevel': stressLevel,
    };
    // Save updated data to local storage
    await prefs.setString('sleepData', json.encode(sleepData));
  }

  // Call this function whenever we want to save data
  // For example, after setting bedtime, hours of sleep, or stress level
  void saveData() {
    // Assuming we have access to these values
    DateTime now = DateTime.now();
    String bedtime = controller.bedtime.value;
    String hoursOfSleep = controller.hoursOfSleep.value;
    String stressLevel = controller.stressLevel.value;

    print('Data to be saved: {date: $now, bedtime: $bedtime, hoursOfSleep: $hoursOfSleep, stressLevel: $stressLevel}');

    // Save data to local storage
    saveDataToLocal(
      date: now,
      bedtime: bedtime,
      hoursOfSleep: hoursOfSleep,
      stressLevel: stressLevel,
    );
  }

  Future<Map<String, dynamic>?> getDataFromLocal(DateTime date) async {  //debugging
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dateString = _generateDateString(date);
    // Retrieve sleep data
    Map<String, dynamic>? sleepData =
        prefs.getString('sleepData') != null ? json.decode(prefs.getString('sleepData')!) : null;
    // Return data for the specified date
    return sleepData != null ? sleepData[dateString] : null;
  }

  Future<void> printSharedPreferencesContents() async { //debugging
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    // Iterate through all keys and print their corresponding values
    keys.forEach((key) {
      dynamic value = prefs.get(key);
      print('Key: $key, Value: $value');
    });
  }

  @override
Widget build(BuildContext context) {
  TextEditingController hoursSleepController = TextEditingController();
  return SafeArea(
    child: Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 28.h, vertical: 18.v),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: _buildHoursOfSleepCard(
                context: context,
                clock: ImageConstant.imgIconBed,
                hoursOfSleep: "lbl_bedtime".tr,
                duration: "lbl_09_00_pm".tr,
                onTapHoursOfSleepCard: (hoursOfSleep) {
                  openTimePickerDialog();
                },
              ),
            ),
            SizedBox(height: 14.v),
            Padding(
              padding: EdgeInsets.only(left: 2.h, right: 1.h),
              child: _buildHoursOfSleepCard(
                context: context,
                clock: ImageConstant.imgClock,
                hoursOfSleep: "lbl_hours_of_sleep".tr,
                duration: "msg_8hours_30minutes".tr,
                onTapHoursOfSleepCard: (String hoursOfSleep) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (hoursOfSleep == "lbl_bedtime".tr) {
                    openTimePickerDialog();
                  } else {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextField(
                            controller: hoursSleepController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Enter hours of sleep',
                            ),
                            onSubmitted: (String value) {
                              // Assign the entered value to a local variable
                              controller.setHoursOfSleep(value);
                              // Update the Rx variable with the entered value
                              controller.hoursOfSleep.value = value;
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 12.v),
            _buildText(context), // Pass the context here
            SizedBox(height: 5.v),
          ],
        ),
      ),
      bottomNavigationBar: _buildAdd(),
    ),
  );
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
  Widget _buildText(BuildContext context) {
  TextEditingController stressLevelController = TextEditingController();
  

  return GestureDetector(
    onTap: () {
      // Show the keyboard and allow user to input numerical value
      FocusScope.of(context).requestFocus(FocusNode());
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: stressLevelController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter stress level (1-5)',
              ),
              onSubmitted: (String value) {
                // Assign the entered value to a local variable
                controller.setStressLevel(value);
                Navigator.pop(context);
              },
            ),
          );
        },
      );
    },
    child: Container(
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLine60,
                      height: 5.adaptSize,
                      width: 5.adaptSize,
                      margin: EdgeInsets.only(top: 1.v),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgLine61,
                      height: 6.v,
                      width: 1.h,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgLine60Gray600,
                      height: 4.adaptSize,
                      width: 4.adaptSize,
                      margin: EdgeInsets.only(top: 1.v),
                    ),
                  ],
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgLockOnprimarycontainer,
                  height: 14.v,
                  width: 11.h,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 14.h, top: 2.v, bottom: 3.v),
            child: Text(
              "lbl_stress_level".tr,
              style: theme.textTheme.bodySmall,
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.v),
            child: Text(
              controller.stressLevel.value, // Display current value
              style: CustomTextStyles.bodySmallGray500,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRightGray500,
            height: 20.adaptSize,
            width: 20.adaptSize,
            margin: EdgeInsets.only(left: 5.h),
          ),
        ],
      ),
    ),
  );
}

  /// Section Widget
  Widget _buildAdd() {
  return CustomElevatedButton(
    text: "lbl_add".tr,
    margin: EdgeInsets.only(left: 31.h, right: 29.h, bottom: 40.v),
    buttonStyle: CustomButtonStyles.none,
    decoration: CustomButtonStyles.gradientPrimaryToBlueDecoration,
    onPressed: () async {
      // Call the saveData() function to save data to local storage
      saveData();
      // Print the contents of SharedPreferences
      await printSharedPreferencesContents();
      naviToHome();
    },
  );
}

  /// Common widget
 Widget _buildHoursOfSleepCard({
  required BuildContext context,
  required String clock,
  required String hoursOfSleep,
  required String duration,
  required Function(String) onTapHoursOfSleepCard,
}) {
  String displayValue;
  if (hoursOfSleep == "lbl_bedtime".tr) {
    displayValue = controller.bedtime.value;
  } else {
    displayValue = controller.hoursOfSleep.value;
  }

  return GestureDetector(
    onTap: () {
      onTapHoursOfSleepCard(hoursOfSleep);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 15.v),
      decoration: AppDecoration.fillGray
          .copyWith(borderRadius: BorderRadiusStyle.roundedBorder14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: clock, 
            height: 20.adaptSize, 
            width: 20.adaptSize
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text(hoursOfSleep,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: appTheme.gray600)
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.v),
            child: Text(
              displayValue,
              style: CustomTextStyles.bodySmallGray500
                  .copyWith(color: appTheme.gray500),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRightGray500,
            height: 20.adaptSize,
            width: 20.adaptSize,
            margin: EdgeInsets.only(left: 5.h, right: 2.h)
          ),
        ]
      )
    )
  );
}


  /// Navigates to the previous screen.
  onTapArrowLeft() {
    Get.back();
  }

  /// Displays a time picker dialog to update the selected time
  ///
  /// This function returns a `Future` that comple  tes with `void`.
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
    
    // Update the state to trigger a rebuild of the widget tree
    controller.update();
  }
}

  /// Navigates to the homeScreen when the action is triggered.
  naviToHome() {
    Get.offAllNamed(
      AppRoutes.homeScreen,
    );
  }
}
