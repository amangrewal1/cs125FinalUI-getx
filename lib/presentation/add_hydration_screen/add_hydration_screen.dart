import 'package:aman_s_application9/widgets/app_bar/custom_app_bar.dart';
import 'package:aman_s_application9/widgets/app_bar/appbar_leading_iconbutton_one.dart';
import 'package:aman_s_application9/widgets/app_bar/appbar_title.dart';
import 'package:aman_s_application9/widgets/app_bar/appbar_trailing_iconbutton_one.dart';
import 'package:aman_s_application9/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'controller/add_hydration_controller.dart';

class AddHydrationScreen extends GetWidget<AddHydrationController> {
  const AddHydrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 28.v),
                child: Column(children: [
                  SizedBox(height: 18.v),
                  _buildMonthCard(),
                  Spacer()
                ])),
            bottomNavigationBar: _buildAdd()));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
        leadingWidth: 62.h,
        leading: AppbarLeadingIconbuttonOne(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 30.h, top: 12.v, bottom: 12.v),
            onTap: () {
              onTapArrowLeft();
            }),
        title: AppbarTitle(
            text: "lbl_hydration".tr, margin: EdgeInsets.only(left: 74.h)),
        actions: [
          AppbarTrailingIconbuttonOne(
              imagePath: ImageConstant.imgDetailNavs,
              margin: EdgeInsets.symmetric(horizontal: 30.h, vertical: 12.v))
        ]);
  }

  /// Section Widget
  Widget _buildMonthCard() {
    return Padding(
      padding: EdgeInsets.only(left: 37.h, right: 23.h),
      child: TextFormField(
        controller: controller.addHydrationModelObj.value.waterIntakeController, // Define this TextEditingController in your model
        keyboardType: TextInputType.number, // Ensures only numbers can be entered
        decoration: InputDecoration(
          labelText: 'Enter water intake in oz', // Replace with your field hint/label
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 2.v), // Adjust padding as needed
            child: CustomImageView(
              imagePath: ImageConstant.imgCalendarBlueGray100,
              height: 17.v,
              width: 13.h,
            ),
          ),
          suffixText: 'oz', // If you want to show a suffix for the unit
          contentPadding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 14.v),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17.h), // Adjust for your desired border radius
          ),
          // Add any other styling to match your design
        ),
        style: theme.textTheme.bodySmall, // Style the text field text
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Allows only digits to be entered
        ],
        // Add any other text field properties you need
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
        onPressed: () {
          naviToHome();
        });
  }

  /// Navigates to the previous screen.
  onTapArrowLeft() {
    Get.back();
  }

  /// Navigates to the homeScreen when the action is triggered.
  naviToHome() {
    Get.offAllNamed(
      AppRoutes.homeScreen,
    );
  }
}
