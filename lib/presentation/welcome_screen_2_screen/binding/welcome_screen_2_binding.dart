import 'package:aman_s_application9/presentation/welcome_screen_2_screen/controller/welcome_screen_2_controller.dart';
import 'package:get/get.dart';

/// A binding class for the WelcomeScreen2Screen.
///
/// This class ensures that the WelcomeScreen2Controller is created when the
/// WelcomeScreen2Screen is first loaded.
class WelcomeScreen2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeScreen2Controller());
  }
}
