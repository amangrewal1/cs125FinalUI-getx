import '../../../core/app_export.dart';
//import '../models/add_sleep_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the AddSleepScreen.
///
/// This class manages the state of the AddSleepScreen, including the
/// current addSleepModelObj
class AddSleepController extends GetxController {
  //Rx<AddSleepModel> addSleepModelObj = AddSleepModel().obs;
  late RxString bedtime;
  late RxString hoursOfSleep;
  late RxString stressLevel;

  @override
  void onInit() {
    bedtime = ''.obs;
    hoursOfSleep = ''.obs;
    stressLevel = ''.obs;
    super.onInit();
  }

  void setHoursOfSleep(String value) {
    hoursOfSleep.value = value;
  }

  void setStressLevel(String value) {
    stressLevel.value = value;
  }

  TimeOfDay selectedopenTimePickerDialogTime = TimeOfDay.now();
}
