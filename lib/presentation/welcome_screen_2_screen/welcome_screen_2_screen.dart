import 'package:aman_s_application9/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'controller/welcome_screen_2_controller.dart';

class WelcomeScreen2Screen extends GetWidget<WelcomeScreen2Controller> {
  const WelcomeScreen2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                          imagePath: ImageConstant.imgGroup,
                          height: 422.v,
                          width: 375.h),
                      SizedBox(height: 49.v),
                      Container(
                          width: 177.h,
                          margin: EdgeInsets.only(left: 30.h),
                          child: Text("msg_improve_sleep_quality".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.headlineSmall!
                                  .copyWith(height: 1.50))),
                      SizedBox(height: 11.v),
                      Container(
                          width: 299.h,
                          margin: EdgeInsets.only(left: 30.h, right: 45.h),
                          child: Text("msg_improve_the_quality".tr,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(height: 1.50))),
                      SizedBox(height: 90.v),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              margin: EdgeInsets.only(right: 30.h),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: appTheme.gray50, width: 1.h),
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder30),
                              child: Container(
                                  height: 60.adaptSize,
                                  width: 60.adaptSize,
                                  decoration: AppDecoration.outlineGray
                                      .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.circleBorder30),
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: SizedBox(
                                                height: 30.adaptSize,
                                                width: 30.adaptSize,
                                                child:
                                                    CircularProgressIndicator(
                                                        value: 0.5))),
                                        CustomIconButton(
                                            height: 50.adaptSize,
                                            width: 50.adaptSize,
                                            padding: EdgeInsets.all(16.h),
                                            decoration: IconButtonStyleHelper
                                                .gradientPrimaryToBlue,
                                            alignment: Alignment.center,
                                            onTap: () {
                                              register();
                                            },
                                            child: CustomImageView(
                                                imagePath: ImageConstant
                                                    .imgArrowRight))
                                      ])))),
                      SizedBox(height: 5.v)
                    ]))));
  }

  /// Navigates to the registerPageInfoScreen when the action is triggered.
  register() {
    Get.offNamed(
      AppRoutes.registerPageInfoScreen,
    );
  }
}
