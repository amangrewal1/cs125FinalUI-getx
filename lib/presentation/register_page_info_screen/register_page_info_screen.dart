import 'package:aman_s_application9/core/utils/validation_functions.dart';
import 'package:aman_s_application9/widgets/custom_text_form_field.dart';
import 'package:aman_s_application9/widgets/custom_drop_down.dart';
import 'package:aman_s_application9/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'controller/register_page_info_controller.dart';

// ignore_for_file: must_be_immutable
class RegisterPageInfoScreen extends GetWidget<RegisterPageInfoController> {
  RegisterPageInfoScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Container(
                        margin: EdgeInsets.only(bottom: 5.v),
                        padding: EdgeInsets.symmetric(horizontal: 10.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImageView(
                                  imagePath: ImageConstant.imgVectorSection,
                                  height: 296.v,
                                  width: 375.h),
                              SizedBox(height: 1.v),
                              Padding(
                                  padding: EdgeInsets.only(left: 39.h),
                                  child: Text("msg_let_s_complete_your".tr,
                                      style: theme.textTheme.titleLarge)),
                              SizedBox(height: 4.v),
                              Padding(
                                  padding: EdgeInsets.only(left: 60.h),
                                  child: Text("msg_it_will_help_us".tr,
                                      style: theme.textTheme.bodySmall)),
                              SizedBox(height: 19.v),
                              _buildName(),
                              SizedBox(height: 20.v),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.h, right: 40.h),
                                  child: CustomDropDown(
                                      icon: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              30.h, 15.v, 15.h, 15.v),
                                          child: CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgArrowdown,
                                              height: 18.adaptSize,
                                              width: 18.adaptSize)),
                                      hintText: "lbl_choose_gender".tr,
                                      items: controller.registerPageInfoModelObj
                                          .value.dropdownItemList!.value,
                                      prefix: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              15.h, 15.v, 10.h, 15.v),
                                          child: CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgSettings,
                                              height: 18.adaptSize,
                                              width: 18.adaptSize)),
                                      prefixConstraints:
                                          BoxConstraints(maxHeight: 48.v),
                                      onChanged: (value) {
                                        controller.onSelected(value);
                                      })),
                              SizedBox(height: 15.v),
                              GestureDetector(
                                  onTap: () {
                                    onTapLabel();
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.h, right: 40.h),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.h, vertical: 14.v),
                                      decoration: AppDecoration.fillGray
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder14),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            CustomImageView(
                                                imagePath:
                                                    ImageConstant.imgCalendar,
                                                height: 18.adaptSize,
                                                width: 18.adaptSize),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.h),
                                                child: Obx(() => Text(
                                                    controller
                                                        .registerPageInfoModelObj
                                                        .value
                                                        .dateOfBirth
                                                        .value,
                                                    style: CustomTextStyles
                                                        .bodySmallGray500_1)))
                                          ]))),
                              SizedBox(height: 15.v),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.h, right: 40.h),
                                  child: Row(children: [
                                    _buildYourWeight(),
                                    _buildLB()
                                  ])),
                              SizedBox(height: 15.v),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.h, right: 40.h),
                                  child: Row(
                                      children: [_buildShare(), _buildFT()]))
                            ])))),
            bottomNavigationBar: _buildNext()));
  }

  /// Section Widget
  Widget _buildName() {
    return Padding(
        padding: EdgeInsets.only(left: 20.h, right: 40.h),
        child: CustomTextFormField(
            controller: controller.nameController,
            hintText: "lbl_name".tr,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(15.h, 15.v, 10.h, 15.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgLock,
                    height: 18.adaptSize,
                    width: 18.adaptSize)),
            prefixConstraints: BoxConstraints(maxHeight: 48.v),
            validator: (value) {
              if (!isText(value)) {
                return "err_msg_please_enter_valid_text".tr;
              }
              return null;
            }));
  }

  /// Section Widget
  Widget _buildYourWeight() {
    return Expanded(
        child: CustomTextFormField(
            controller: controller.yourWeightController,
            hintText: "lbl_your_weight".tr,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 30.h, vertical: 15.v)));
  }

  /// Section Widget
  Widget _buildLB() {
    return CustomElevatedButton(
        height: 48.v,
        width: 48.h,
        text: "lbl_lb".tr,
        margin: EdgeInsets.only(left: 15.h),
        buttonStyle: CustomButtonStyles.none,
        decoration:
            CustomButtonStyles.gradientSecondaryContainerToPinkDecoration,
        buttonTextStyle: theme.textTheme.labelLarge!);
  }

  /// Section Widget
  Widget _buildShare() {
    return Expanded(
        child: CustomTextFormField(
            controller: controller.shareController,
            hintText: "lbl_your_height".tr,
            textInputAction: TextInputAction.done,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(15.h, 15.v, 10.h, 15.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgShare,
                    height: 18.adaptSize,
                    width: 18.adaptSize)),
            prefixConstraints: BoxConstraints(maxHeight: 48.v)));
  }

  /// Section Widget
  Widget _buildFT() {
    return CustomElevatedButton(
        height: 48.v,
        width: 48.h,
        text: "lbl_ft".tr,
        margin: EdgeInsets.only(left: 15.h),
        buttonStyle: CustomButtonStyles.none,
        decoration:
            CustomButtonStyles.gradientSecondaryContainerToPinkDecoration,
        buttonTextStyle: theme.textTheme.labelLarge!);
  }

  /// Section Widget
  Widget _buildNext() {
    return CustomElevatedButton(
        text: "lbl_next".tr,
        margin: EdgeInsets.only(left: 40.h, right: 40.h, bottom: 40.v),
        rightIcon: Container(
            margin: EdgeInsets.only(left: 3.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgArrowRight,
                height: 20.adaptSize,
                width: 20.adaptSize)),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles.gradientPrimaryToBlueDecoration,
        onPressed: () {
          navigateToActivity();
        });
  }

  /// Displays a date picker dialog and updates the selected date in the
  /// [registerPageInfoModelObj] object of the current [dateOfBirth] if the user
  /// selects a valid date.
  ///
  /// This function returns a `Future` that completes with `void`.
  Future<void> onTapLabel() async {
    DateTime? dateTime = await showDatePicker(
        context: Get.context!,
        initialDate: controller
            .registerPageInfoModelObj.value.selectedDateOfBirth!.value,
        firstDate: DateTime(1970),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));
    if (dateTime != null) {
      controller.registerPageInfoModelObj.value.selectedDateOfBirth!.value =
          dateTime;
      controller.registerPageInfoModelObj.value.dateOfBirth.value =
          dateTime.format(pattern: dateTimeFormatPattern);
    }
  }

  /// Navigates to the registerPageActivityScreen when the action is triggered.
  navigateToActivity() {
    Get.offNamed(
      AppRoutes.registerPageActivityScreen,
    );
  }
}
