import 'package:aman_s_application9/presentation/register_page_activity_screen/controller/register_page_activity_controller.dart';
import 'package:get/get.dart';

/// A binding class for the RegisterPageActivityScreen.
///
/// This class ensures that the RegisterPageActivityController is created when the
/// RegisterPageActivityScreen is first loaded.
class RegisterPageActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterPageActivityController());
  }
}
