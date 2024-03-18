import '../../../core/app_export.dart';
import '../models/register_page_sleep_goal_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A controller class for the RegisterPageSleepGoalScreen.
///
/// This class manages the state of the RegisterPageSleepGoalScreen, including the
/// current registerPageSleepGoalModelObj
class RegisterPageSleepGoalController extends GetxController {
  Rx<RegisterPageSleepGoalModel> registerPageSleepGoalModelObj =
      RegisterPageSleepGoalModel().obs;
      var bedtime = 'Select a time'.obs;

  TimeOfDay selectedopenTimePickerDialogTime = TimeOfDay.now();
}
String _generateDateString(DateTime date) {
  // Format the date string in a consistent format
  return DateFormat('yyyy-MM-dd').format(date);
}