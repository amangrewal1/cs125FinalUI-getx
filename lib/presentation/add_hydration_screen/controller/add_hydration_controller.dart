import '../../../core/app_export.dart';
import '../models/add_hydration_model.dart';

/// A controller class for the AddHydrationScreen.
///
/// This class manages the state of the AddHydrationScreen, including the
/// current addHydrationModelObj
class AddHydrationController extends GetxController {
  Rx<AddHydrationModel> addHydrationModelObj = AddHydrationModel().obs;
}
