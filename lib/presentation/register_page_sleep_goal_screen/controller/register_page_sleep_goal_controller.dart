import '../../../core/app_export.dart';
import '../models/register_page_sleep_goal_model.dart';

/// A controller class for the RegisterPageSleepGoalScreen.
///
/// This class manages the state of the RegisterPageSleepGoalScreen, including the
/// current registerPageSleepGoalModelObj
class RegisterPageSleepGoalController extends GetxController {
  Rx<RegisterPageSleepGoalModel> registerPageSleepGoalModelObj =
      RegisterPageSleepGoalModel().obs;
      var sleepGoalOptions = <String>["10 Hours", "9 Hours", "8 Hours", "7 Hours", "6 Hours"].obs; 
      var selectedSleepGoal = "8 Hours".obs; // Default value
}
