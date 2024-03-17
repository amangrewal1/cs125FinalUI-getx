import '../../../core/app_export.dart';
import '../models/add_hydration_model.dart';

/// A controller class for the AddHydrationScreen.
///
/// This class manages the state of the AddHydrationScreen, including the
/// current addHydrationModelObj
class AddHydrationController extends GetxController {
  Rx<AddHydrationModel> addHydrationModelObj = AddHydrationModel().obs;
  // Inside AddHydrationController class
  @override
  void onClose() {
    addHydrationModelObj.value.waterIntakeController.dispose();
    super.onClose();
  }

  var waterIntake = ''.obs;

  void addHydration(value) {
    waterIntake.value = value;
  }

}
