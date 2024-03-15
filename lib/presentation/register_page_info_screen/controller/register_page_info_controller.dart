import '../../../core/app_export.dart';
import '../models/register_page_info_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the RegisterPageInfoScreen.
///
/// This class manages the state of the RegisterPageInfoScreen, including the
/// current registerPageInfoModelObj
class RegisterPageInfoController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController yourWeightController = TextEditingController();
  TextEditingController shareController = TextEditingController();

  Rx<RegisterPageInfoModel> registerPageInfoModelObj =
      RegisterPageInfoModel().obs;

  SelectionPopupModel? selectedDropDownValue;

  var name = ''.obs;
  var gender = ''.obs;
  var dateOfBirth = ''.obs;
  var weight = ''.obs;
  var height = ''.obs;

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    yourWeightController.dispose();
    shareController.dispose();
  }

  void setName(String value) {
    name.value = value;
  }

  void setGender(String value) {
    gender.value = value;
  }

  void setDateOfBirth(String value) {
    dateOfBirth.value = value;
  }

  void setWeight(String value) {
    weight.value = value;
  }

  void setHeight(SelectionPopupModel value) {
    height.value = value.title;
  }

  onSelected(dynamic value) {
    for (var element in registerPageInfoModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    registerPageInfoModelObj.value.dropdownItemList.refresh();
  }
}
