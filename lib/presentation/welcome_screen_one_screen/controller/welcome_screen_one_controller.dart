import '../../../core/app_export.dart';
import '../models/welcome_screen_one_model.dart';

/// A controller class for the WelcomeScreenOneScreen.
///
/// This class manages the state of the WelcomeScreenOneScreen, including the
/// current welcomeScreenOneModelObj
class WelcomeScreenOneController extends GetxController {
  Rx<WelcomeScreenOneModel> welcomeScreenOneModelObj =
      WelcomeScreenOneModel().obs;
}
