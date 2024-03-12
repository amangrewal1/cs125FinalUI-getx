import 'package:aman_s_application9/presentation/splash_page_screen/controller/splash_page_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SplashPageScreen.
///
/// This class ensures that the SplashPageController is created when the
/// SplashPageScreen is first loaded.
class SplashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashPageController());
  }
}
