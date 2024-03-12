import 'package:aman_s_application9/presentation/register_page_sleep_goal_screen/controller/register_page_sleep_goal_controller.dart';
import 'package:get/get.dart';

/// A binding class for the RegisterPageSleepGoalScreen.
///
/// This class ensures that the RegisterPageSleepGoalController is created when the
/// RegisterPageSleepGoalScreen is first loaded.
class RegisterPageSleepGoalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterPageSleepGoalController());
  }
}
