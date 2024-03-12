import 'package:aman_s_application9/presentation/add_hydration_screen/controller/add_hydration_controller.dart';
import 'package:get/get.dart';

/// A binding class for the AddHydrationScreen.
///
/// This class ensures that the AddHydrationController is created when the
/// AddHydrationScreen is first loaded.
class AddHydrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddHydrationController());
  }
}
