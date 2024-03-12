import 'package:aman_s_application9/presentation/add_sleep_screen/controller/add_sleep_controller.dart';
import 'package:get/get.dart';

/// A binding class for the AddSleepScreen.
///
/// This class ensures that the AddSleepController is created when the
/// AddSleepScreen is first loaded.
class AddSleepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddSleepController());
  }
}
