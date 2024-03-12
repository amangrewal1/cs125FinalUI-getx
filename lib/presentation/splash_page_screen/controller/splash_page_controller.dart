import '../../../core/app_export.dart';
import '../models/splash_page_model.dart';

/// A controller class for the SplashPageScreen.
///
/// This class manages the state of the SplashPageScreen, including the
/// current splashPageModelObj
class SplashPageController extends GetxController {
  Rx<SplashPageModel> splashPageModelObj = SplashPageModel().obs;

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offNamed(
        AppRoutes.welcomeScreenOneScreen,
      );
    });
  }
}
