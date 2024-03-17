import 'package:aman_s_application9/widgets/custom_bottom_bar.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:flutter/material.dart';
import 'package:aman_s_application9/core/app_export.dart';
import 'controller/home_controller.dart';
//data retrieval
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// ML model
import 'package:tflite_flutter/tflite_flutter.dart';
//DateTime calculations
import 'package:time_machine/time_machine.dart';
import 'package:intl/intl.dart';

// ignore_for_file: must_be_immutable
class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({Key? key})
      : super(
          key: key,
        );

  Future<int> currStress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> sleepData = {};
    String? sleepDataString = prefs.getString('sleepData');
    if (sleepDataString != null) {
      sleepData = json.decode(sleepDataString);
    }
    // Get the current date and the date of the previous day
    DateTime currentDate = DateTime.now();
    DateTime previousDay = currentDate.subtract(Duration(days: 1));
    String currentDateString = DateFormat('yyyy-MM-dd').format(currentDate);
    String previousDayString = DateFormat('yyyy-MM-dd').format(previousDay);
    int totalStress = 0;

    if (!sleepData.containsKey(currentDateString) && !sleepData.containsKey(previousDayString)) {
      return 0;
    }

    // Check if current date exists as a key in sleepData and add its stress level to totalStress if it does
    if (sleepData.containsKey(currentDateString)) {
      totalStress += int.parse(sleepData[currentDateString]['stressLevel']);
    }
    // Check if previous day exists as a key in sleepData and add its stress level to totalStress if it does
    if (sleepData.containsKey(previousDayString)) {
      totalStress += int.parse(sleepData[previousDayString]['stressLevel']);
    }
    
    return totalStress;
  }

  Future<int> meditateRec() async {
    print("whoop");
    printSharedPreferencesContents();
    int stress = await currStress();
    if (stress <= 0) {
      return 0;
    }
    else if (stress >= 1 && stress < 3) {
      return 5;
    }
    else if (stress >= 3 && stress < 5) {
      return 7;
    }
    else if (stress >= 5 && stress < 8) {
      return 10;
    }
    else if (stress >= 8 && stress < 10) {
      return 15;
    }
    return 20;
  }
      
  Future<double> sleepRec() async {
    // Load the TensorFlow Lite model
    final interpreter = await Interpreter.fromAsset('assets/keras_sleep_model.tflite');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    Map<String, dynamic> userData = {};
    if (userDataString != null) {
      userData = json.decode(userDataString);
    }

    // Prepare input data for prediction
    int gender = (userData['gender'] == 'Male') ? 0 : 1;
    int age = LocalDateTime.dateTime(DateTime.parse(userData['dob'])).periodSince(LocalDateTime.now()).years;
    final inputData = [gender, age, 8, 50, 3, 70, 7000, 1, 0, 0, 1, 0];
    //activity level varies - get from datastream of android Health app?
    //stress level takes average of past 1, 2, or 3 days? if null, default val is 3
    //take into account sleep defecits from previous days

    // Allocate memory for input and output tensors
    final input = inputData.map((i) => i.toDouble()).toList();

    final output = [List<double>.filled(1, 0)];

    // Run inference
    interpreter.run(input, output);
    interpreter.close();
    print("ML Output: " + (16 - output[0][0]).toString());
    if (prefs.getDouble('baseRec') == null) {
      print("yahoo");
      prefs.setDouble('baseRec', (16 - output[0][0]));
    }
    double debt = await calcSleepDebt();
    if (16 - output[0][0] + debt > 10.5) {
      return 10.5;
    }
    else if (debt < 0) {
      return 16 - output[0][0];
    }
    return 16 - output[0][0] + debt;
  }
  
  Future<double> calcSleepDebt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> sleepData = {};
    String? sleepDataString = prefs.getString('sleepData');
    Map<String, dynamic> recs = {};
    String? recsString = prefs.getString('recs');
    if (sleepDataString != null) {
      sleepData = json.decode(sleepDataString);
    }
    else {
      return 0;
    }
    if (recsString != null) {
      recs = json.decode(recsString);
    }
    
    DateTime currentDate = DateTime.now();
    double sleepDebt = 0;
    double? baseRec = prefs.getDouble('baseRec');
    
    // Iterate over the past 14 dates (including today)
    for (int i = 0; i < 14; i++) {
      DateTime date = currentDate.subtract(Duration(days: i));
      String dateString = DateFormat('yyyy-MM-dd').format(date);
      double expected = (recsString != null && recs.containsKey(dateString)) ? recs[dateString] : baseRec;

      // Check if the date exists as a key in sleepData
      if (sleepData.containsKey(dateString)) {
        // Add the duration to totalSleep 
        if (i == 0) {
          sleepDebt += expected - double.parse(sleepData[dateString]['hoursOfSleep']);
        }
        else {
          sleepDebt += (expected - double.parse(sleepData[dateString]['hoursOfSleep'])) / 2.3;
        }
      }
    }
    if (sleepDebt < 0) {
      return 0;
    }
    return sleepDebt;
  }

  Future<double> calcSleepScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> sleepData = {};
    String? sleepDataString = prefs.getString('sleepData');
    Map<String, dynamic> recs = {};
    String? recsString = prefs.getString('recs');
    if (sleepDataString != null) {
      sleepData = json.decode(sleepDataString);
    }
    else {
      return 500;
    }
    if (recsString != null) {
      recs = json.decode(recsString);
    }
    DateTime currentDate = DateTime.now();
    double score = 0;
    double? baseRec = prefs.getDouble('baseRec');
    List<int> weights = [125, 100, 75, 50, 50, 25, 25];
    List<int> used = [];
    
    // Iterate over the past 7 dates (including today)
    for (int i = 0; i < 7; i++) {
      DateTime date = currentDate.subtract(Duration(days: i));
      String dateString = DateFormat('yyyy-MM-dd').format(date);
      double expected = (recsString != null && recs.containsKey(dateString)) ? recs[dateString] : baseRec;

      // Check if the date exists as a key in sleepData
      if (sleepData.containsKey(dateString)) {
        if (double.parse(sleepData[dateString]['hoursOfSleep']) < expected) {
          if (double.parse(sleepData[dateString]['hoursOfSleep']) > 4) {
            score += ((double.parse(sleepData[dateString]['hoursOfSleep']) - 4) / (expected - 4)) * weights[i];
          }
        }
        else {
          score += weights[i];
        }
        used.add(i);
      }
    }
    int total = 0;
    for (int i = 0; i < used.length; i++) {
      total += weights[used[i]];
    }

    return score * 500 / total;
  }

  Future<double> calcStressScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> sleepData = {};
    String? sleepDataString = prefs.getString('sleepData');
    if (sleepDataString != null) {
      sleepData = json.decode(sleepDataString);
    }
    else {
      return 250;
    }
    DateTime currentDate = DateTime.now();
    double score = 0;
    List<double> weights = [100, 75, 25, 25, 25];
    
    // Iterate over the past 5 dates (including today)
    for (int i = 0; i < 5; i++) {
      DateTime date = currentDate.subtract(Duration(days: i));
      String dateString = DateFormat('yyyy-MM-dd').format(date);

      // Check if the date exists as a key in sleepData
      if (sleepData.containsKey(dateString)) {
        score += (10 - (double.parse(sleepData[dateString]['stressLevel']))) * weights[i] / 10;
      }
      else {
        score += weights[i];
      }
    }
    return score;
  }

  Future<int> calcLifeScore() async {
    double sleep = await calcSleepScore();
    double stress = await calcStressScore();
    double hydration = 250; //replace with calcHydrationScore(); later
    print("bro " + sleep.toString() + " eek " + stress.toString());
    return (sleep + stress + hydration).round();
  }

  Future<void> printSharedPreferencesContents() async { //debugging
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    // Iterate through all keys and print their corresponding values
    keys.forEach((key) {
      dynamic value = prefs.get(key);
      print('Key: $key, Value: $value');
    });
  }

  Future<String> scoreMsg() async {
    int score = await calcLifeScore();
    String msg = "";
    if (score > 900) {
      msg = "You have a great score!";
    }
    else if (score > 800) {
      msg = "You have a decent score";
    }
    else if (score > 700) {
      msg = "You have a normal score";
    }
    else if (score > 500) {
      msg = "You have a subpar score";
    }
    else {
      msg = "You have a very low score";
    }
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 28.h,
              vertical: 40.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Text(
                    "lbl_welcome_back".tr,
                    style: CustomTextStyles.bodySmallGray500_1,
                  ),
                ),
                SizedBox(height: 6.v),
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: FutureBuilder<String?>(
                    future: _getUserData(), // Call the function to get user data
                    builder: (context, snapshot) {
                      sleepRec();  //added to test
                      if (snapshot.hasData) {
                        return Text(
                          "${snapshot.data}!", // Use the retrieved name
                          style: theme.textTheme.titleLarge,
                        );
                      } else {
                        return Text(
                          "lbl_stefani_wong".tr, // Default text if name not available
                          style: theme.textTheme.titleLarge,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 29.v),
                _buildSeventyTwo(context),
                SizedBox(height: 30.v),
                FutureBuilder<double>(
                  future: calcSleepDebt(), // Call calcSleepDebt()
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      // Convert sleep debt to hours and minutes
                      int hours = snapshot.data!.floor();
                      int minutes = ((snapshot.data! % 1) * 60).floor();
                      return Text(
                        "Sleep debt: ${hours}h ${minutes}m",
                        style: CustomTextStyles.titleMediumGray90001,
                      );
                    }
                  },
                ),
                SizedBox(height: 20.v),
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Text(
                    "Today's Recommendation",
                    style: CustomTextStyles.titleMediumGray90001,
                  ),
                ),
                SizedBox(height: 8.v),
                _buildActivityStatusCard(),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  // Function to retrieve user data from SharedPreferences
  Future<String?> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      print("wow " + userDataString);
      Map<String, dynamic> userData = json.decode(userDataString);
      return userData['name']; // Retrieve the value associated with the 'name' key
    } else {
      return null; // Return null if 'userData' is not found in SharedPreferences
    }
  }

  /// Section Widget
  /// Section Widget
Widget _buildSeventyTwo(BuildContext context) {
  return GestureDetector(
    onTap: () {
      _showPopup(context);
    },
    child: Container(
      width: 315.h,
      margin: EdgeInsets.only(left: 2.h),
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 26.v,
      ),
      decoration: AppDecoration.outlineOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder22,
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgGroup72,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 49.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_lifestyle_score".tr,
                  style: CustomTextStyles.titleSmallSecondaryContainer,
                ),
                SizedBox(height: 3.v),
                FutureBuilder<String>(
                future: scoreMsg(), 
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print("whoa $snapshot.error");
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Text(
                      "${snapshot.data}",
                      style: theme.textTheme.bodySmall,
                    );
                  }
                },
              ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 2.v,
              right: 9.h,
              bottom: 2.v,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 31.h,
              vertical: 34.v,
            ),
            decoration:
                AppDecoration.gradientSecondaryContainerToPrimary.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder44,
            ),
            child: FutureBuilder<int>(
                future: calcLifeScore(), // Call calcSleepDebt()
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print("whoa $snapshot.error");
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Text(
                      "${snapshot.data} / 1000",
                      style: CustomTextStyles.labelLargeSemiBold,
                    );
                  }
                },
              ),
          ),
        ],
      ),
    ),
  );
}

/// Function to show the pop-up
void _showPopup(BuildContext context) async {
  int lifeScore = await calcLifeScore();
  double sleepScore = await calcSleepScore();
  double stressScore = await calcStressScore();
  String scoreText = "Your lifestyle score is $lifeScore out of 1000 points.\n";
  String sleepText = "";
  String stressText = "";

  if (sleepScore >= 450) {
    sleepText = "Your sleep the past week has been phenomenal, and your body is extremely well-rested. Keep up the consistency!\n";
  }
  else if (sleepScore >= 350) {
    sleepText = "Overall, you've been getting decent amounts of sleep this week, and at respectable times. Great job!\n";
  }
  else if (sleepScore >= 250) {
    sleepText = "You could do better with your sleep this week. Try to have consistent sleep times for each day, and limit your screen time before bed!\n";
  }
  else {
    sleepText = "Prioritize getting good amounts of sleep as soon as you can. Your body is in a massive sleep deficit!\n";
  }

  if (stressScore >= 200) {
    stressText = "As for your mental health, great job keeping stress to a minimum!";
  }
  else if (stressScore >= 100) {
    stressText = "As for your mental health, this week wasn't exactly the best for you. Remember to follow the meditation recommendations before going to bed!";
  }
  else {
    stressText = "Unfortunately, this has not been your week. Still, your mental health is important! Focus on employing the meditation recommendations every evening.";
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        //contentPadding: EdgeInsets.zero, // Set contentPadding to zero
        title: Text("Lifestyle Analysis"),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: 3, // Number of Text widgets
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Text(
                  scoreText,
                  textAlign: TextAlign.center,
                );
              } 
              else if (index == 1) {
                return Text(
                  sleepText,
                  textAlign: TextAlign.center,
                );
              }
              else {
                return Text(
                  stressText,
                  textAlign: TextAlign.center,
                );
              }
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



  /// Section Widget
  Widget _buildActivityStatusCard() {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 19.v,
            ),
            decoration: AppDecoration.outlineGrayC.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder22,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: AppDecoration.fillGray.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 124.v),
                      Container(
                        height: 151.v,
                        width: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10.h),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment(0.5, -0.83),
                            end: Alignment(0.5, 0.61),
                            colors: [
                              theme.colorScheme.secondaryContainer,
                              appTheme.indigo100,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.h,
                    bottom: 232.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lbl_meditation".tr,
                        style: CustomTextStyles.labelLargeGray900,
                      ),
                      SizedBox(height: 4.v),
                      FutureBuilder<int>(
                        future: meditateRec(), // Call meditateRec()
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // While waiting for the result, return a placeholder or loading indicator
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            // If an error occurs, display an error message
                            return Text("Error: ${snapshot.error}");
                          } else {
                            // When the result is available, use it to dynamically display meditation hours
                            return Text(
                              "${snapshot.data!.toStringAsFixed(1)} min", // Display hours
                              style: CustomTextStyles.titleSmallPrimary,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 19.h,
              vertical: 6.v,
            ),
            decoration: AppDecoration.outlineOnPrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder22,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36.v),
                Text(
                  "lbl_sleep".tr,
                  style: CustomTextStyles.labelLargeGray90001,
                ),
                SizedBox(height: 30.v),
                FutureBuilder<double>(
                  future: sleepRec(), // Call sleepRec()
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While waiting for the result, return a placeholder or loading indicator
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // If an error occurs, display an error message
                      return Text("Error: ${snapshot.error}");
                    } else {
                      // When the result is available, use it to dynamically display sleep hours and minutes
                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${snapshot.data!.floor()}", // Display hours
                              style: theme.textTheme.titleSmall,
                            ),
                            TextSpan(
                              text: "lbl_h".tr,
                              style: theme.textTheme.labelMedium,
                            ),
                            TextSpan(
                              text: " ",
                            ),
                            TextSpan(
                              text: "${((snapshot.data! % 1) * 60).floor()}", // Display minutes
                              style: theme.textTheme.titleSmall,
                            ),
                            TextSpan(
                              text: "lbl_m".tr,
                              style: theme.textTheme.labelMedium,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      );
                    }
                  },
                ),
                SizedBox(height: 36.v),
                CustomImageView(
                  imagePath: ImageConstant.imgSleepGraph,
                  height: 163.v,
                  width: 109.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
 Widget _buildBottomBar() {
  return CustomBottomBar(
    onChanged: (BottomBarEnum type) {
      switch (type) {
        case BottomBarEnum.Upload:
          Get.toNamed(AppRoutes.addHydrationScreen);
          break;
        case BottomBarEnum.Frame3:
          Get.toNamed(AppRoutes.addSleepScreen);
          break;
        default:
          break;
      }
    },
  );
}
}