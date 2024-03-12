import 'package:aman_s_application9/widgets/custom_bottom_bar.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:flutter/material.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'controller/home_controller.dart';

// ignore_for_file: must_be_immutable
class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 28.h,
              vertical: 40.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Text(
                    "lbl_welcome_back".tr,
                    style: CustomTextStyles.bodySmallGray500_1,
                  ),
                ),
                SizedBox(height: 6.v),
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Text(
                    "lbl_stefani_wong".tr,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 29.v),
                _buildSeventyTwo(),
                SizedBox(height: 50.v),
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Text(
                    "lbl_recommendation".tr,
                    style: CustomTextStyles.titleMediumGray90001,
                  ),
                ),
                SizedBox(height: 8.v),
                _buildActivityStatusCard(),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  /// Section Widget
  Widget _buildSeventyTwo() {
    return Container(
      width: 315.h,
      margin: EdgeInsets.only(left: 2.h),
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 26.v,
      ),
      decoration: AppDecoration.outlineOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder22,
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgGroup72,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 49.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_lifestyle_score".tr,
                  style: CustomTextStyles.titleSmallSecondaryContainer,
                ),
                SizedBox(height: 3.v),
                Text(
                  "msg_you_have_a_normal".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 2.v,
              right: 9.h,
              bottom: 2.v,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 31.h,
              vertical: 34.v,
            ),
            decoration:
                AppDecoration.gradientSecondaryContainerToPrimary.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder44,
            ),
            child: Text(
              "lbl_420".tr,
              style: CustomTextStyles.labelLargeSemiBold,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildActivityStatusCard() {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 19.v,
            ),
            decoration: AppDecoration.outlineGrayC.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder22,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: AppDecoration.fillGray.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 124.v),
                      Container(
                        height: 151.v,
                        width: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10.h),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment(0.5, -0.83),
                            end: Alignment(0.5, 0.61),
                            colors: [
                              theme.colorScheme.secondaryContainer,
                              appTheme.indigo100,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.h,
                    bottom: 232.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lbl_meditation".tr,
                        style: CustomTextStyles.labelLargeGray900,
                      ),
                      SizedBox(height: 4.v),
                      Text(
                        "lbl_1_hour".tr,
                        style: CustomTextStyles.titleSmallPrimary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 19.h,
              vertical: 6.v,
            ),
            decoration: AppDecoration.outlineOnPrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder22,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36.v),
                Text(
                  "lbl_sleep".tr,
                  style: CustomTextStyles.labelLargeGray90001,
                ),
                SizedBox(height: 30.v),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "lbl_8".tr,
                        style: theme.textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: "lbl_h".tr,
                        style: theme.textTheme.labelMedium,
                      ),
                      TextSpan(
                        text: " ",
                      ),
                      TextSpan(
                        text: "lbl_20".tr,
                        style: theme.textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: "lbl_m".tr,
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 36.v),
                CustomImageView(
                  imagePath: ImageConstant.imgSleepGraph,
                  height: 163.v,
                  width: 109.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
 Widget _buildBottomBar() {
  return CustomBottomBar(
    onChanged: (BottomBarEnum type) {
      switch (type) {
        case BottomBarEnum.Upload:
          Get.toNamed(AppRoutes.addHydrationScreen);
          break;
        case BottomBarEnum.Frame3:
          Get.toNamed(AppRoutes.addSleepScreen);
          break;
        default:
          break;
      }
    },
  );
}
}