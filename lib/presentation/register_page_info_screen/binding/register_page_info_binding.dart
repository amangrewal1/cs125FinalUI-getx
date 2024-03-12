import 'package:aman_s_application9/presentation/register_page_info_screen/controller/register_page_info_controller.dart';
import 'package:get/get.dart';

/// A binding class for the RegisterPageInfoScreen.
///
/// This class ensures that the RegisterPageInfoController is created when the
/// RegisterPageInfoScreen is first loaded.
class RegisterPageInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterPageInfoController());
  }
}
