import 'package:aman_s_application9/presentation/welcome_screen_one_screen/controller/welcome_screen_one_controller.dart';
import 'package:get/get.dart';

/// A binding class for the WelcomeScreenOneScreen.
///
/// This class ensures that the WelcomeScreenOneController is created when the
/// WelcomeScreenOneScreen is first loaded.
class WelcomeScreenOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeScreenOneController());
  }
}
