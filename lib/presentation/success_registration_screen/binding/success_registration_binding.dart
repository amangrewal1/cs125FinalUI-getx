import 'package:aman_s_application9/presentation/success_registration_screen/controller/success_registration_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SuccessRegistrationScreen.
///
/// This class ensures that the SuccessRegistrationController is created when the
/// SuccessRegistrationScreen is first loaded.
class SuccessRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuccessRegistrationController());
  }
}
