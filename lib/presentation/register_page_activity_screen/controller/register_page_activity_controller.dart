import '../../../core/app_export.dart';
import '../models/register_page_activity_model.dart';

/// A controller class for the RegisterPageActivityScreen.
///
/// This class manages the state of the RegisterPageActivityScreen, including the
/// current registerPageActivityModelObj
class RegisterPageActivityController extends GetxController {
  Rx<RegisterPageActivityModel> registerPageActivityModelObj =
      RegisterPageActivityModel().obs;

  SelectionPopupModel? selectedDropDownValue;

  onSelected(dynamic value) {
    for (var element
        in registerPageActivityModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    registerPageActivityModelObj.value.dropdownItemList.refresh();
  }
}
