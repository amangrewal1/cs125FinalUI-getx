import '../../../core/app_export.dart';
import '../models/welcome_screen_2_model.dart';

/// A controller class for the WelcomeScreen2Screen.
///
/// This class manages the state of the WelcomeScreen2Screen, including the
/// current welcomeScreen2ModelObj
class WelcomeScreen2Controller extends GetxController {
  Rx<WelcomeScreen2Model> welcomeScreen2ModelObj = WelcomeScreen2Model().obs;
}
