import 'package:get/get.dart';
import '../presentation/welcome_screen_one_screen/welcome_screen_one_screen.dart';
import '../presentation/welcome_screen_one_screen/binding/welcome_screen_one_binding.dart';
import '../presentation/welcome_screen_2_screen/welcome_screen_2_screen.dart';
import '../presentation/welcome_screen_2_screen/binding/welcome_screen_2_binding.dart';
import '../presentation/splash_page_screen/splash_page_screen.dart';
import '../presentation/splash_page_screen/binding/splash_page_binding.dart';
import '../presentation/register_page_info_screen/register_page_info_screen.dart';
import '../presentation/register_page_info_screen/binding/register_page_info_binding.dart';
import '../presentation/register_page_activity_screen/register_page_activity_screen.dart';
import '../presentation/register_page_activity_screen/binding/register_page_activity_binding.dart';
import '../presentation/success_registration_screen/success_registration_screen.dart';
import '../presentation/success_registration_screen/binding/success_registration_binding.dart';
import '../presentation/register_page_sleep_goal_screen/register_page_sleep_goal_screen.dart';
import '../presentation/register_page_sleep_goal_screen/binding/register_page_sleep_goal_binding.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/home_screen/binding/home_binding.dart';
import '../presentation/add_sleep_screen/add_sleep_screen.dart';
import '../presentation/add_sleep_screen/binding/add_sleep_binding.dart';
import '../presentation/add_hydration_screen/add_hydration_screen.dart';
import '../presentation/add_hydration_screen/binding/add_hydration_binding.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';

class AppRoutes {
  static const String welcomeScreenOneScreen = '/welcome_screen_one_screen';

  static const String welcomeScreen2Screen = '/welcome_screen_2_screen';

  static const String splashPageScreen = '/splash_page_screen';

  static const String registerPageInfoScreen = '/register_page_info_screen';

  static const String registerPageActivityScreen =
      '/register_page_activity_screen';

  static const String successRegistrationScreen =
      '/success_registration_screen';

  static const String registerPageSleepGoalScreen =
      '/register_page_sleep_goal_screen';

  static const String homeScreen = '/home_screen';

  static const String addSleepScreen = '/add_sleep_screen';

  static const String addHydrationScreen = '/add_hydration_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: welcomeScreenOneScreen,
      page: () => WelcomeScreenOneScreen(),
      bindings: [
        WelcomeScreenOneBinding(),
      ],
    ),
    GetPage(
      name: welcomeScreen2Screen,
      page: () => WelcomeScreen2Screen(),
      bindings: [
        WelcomeScreen2Binding(),
      ],
    ),
    GetPage(
      name: splashPageScreen,
      page: () => SplashPageScreen(),
      bindings: [
        SplashPageBinding(),
      ],
    ),
    GetPage(
      name: registerPageInfoScreen,
      page: () => RegisterPageInfoScreen(),
      bindings: [
        RegisterPageInfoBinding(),
      ],
    ),
    GetPage(
      name: registerPageActivityScreen,
      page: () => RegisterPageActivityScreen(),
      bindings: [
        RegisterPageActivityBinding(),
      ],
    ),
    GetPage(
      name: successRegistrationScreen,
      page: () => SuccessRegistrationScreen(),
      bindings: [
        SuccessRegistrationBinding(),
      ],
    ),
    GetPage(
      name: registerPageSleepGoalScreen,
      page: () => RegisterPageSleepGoalScreen(),
      bindings: [
        RegisterPageSleepGoalBinding(),
      ],
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: addSleepScreen,
      page: () => AddSleepScreen(),
      bindings: [
        AddSleepBinding(),
      ],
    ),
    GetPage(
      name: addHydrationScreen,
      page: () => AddHydrationScreen(),
      bindings: [
        AddHydrationBinding(),
      ],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashPageScreen(),
      bindings: [
        SplashPageBinding(),
      ],
    )
  ];
}
