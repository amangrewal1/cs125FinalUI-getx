import '../../../core/app_export.dart';
import '../models/add_sleep_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the AddSleepScreen.
///
/// This class manages the state of the AddSleepScreen, including the
/// current addSleepModelObj
class AddSleepController extends GetxController {
  Rx<AddSleepModel> addSleepModelObj = AddSleepModel().obs;

  TimeOfDay selectedopenTimePickerDialogTime = TimeOfDay.now();
}
