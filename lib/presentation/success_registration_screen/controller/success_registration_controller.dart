import '../../../core/app_export.dart';
import '../models/success_registration_model.dart';

/// A controller class for the SuccessRegistrationScreen.
///
/// This class manages the state of the SuccessRegistrationScreen, including the
/// current successRegistrationModelObj
class SuccessRegistrationController extends GetxController {
  Rx<SuccessRegistrationModel> successRegistrationModelObj =
      SuccessRegistrationModel().obs;
}
