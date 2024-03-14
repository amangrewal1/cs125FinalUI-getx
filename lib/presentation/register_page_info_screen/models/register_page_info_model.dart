import 'package:aman_s_application9/core/app_export.dart';
import '../../../core/app_export.dart';

/// This class defines the variables used in the [register_page_info_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class RegisterPageInfoModel {
  Rx<List<SelectionPopupModel>> dropdownItemList = Rx([
    SelectionPopupModel(
      id: 1,
      title: "Male",
      isSelected: true,
    ),
    SelectionPopupModel(
      id: 2,
      title: "Female",
    )
  ]);

  Rx<DateTime>? selectedDateOfBirth = Rx(DateTime.now());

  Rx<String> dateOfBirth = Rx("Date of Birth");
  
  Rx<List<SelectionPopupModel>> heightOptions = Rx(List.generate(37, (index) {
        final feet = 4 + (index / 12).floor();
        final inch = index % 12;
        return SelectionPopupModel(id: index, title: "$feet'$inch\"", isSelected: index == 0);
      })); 
}

