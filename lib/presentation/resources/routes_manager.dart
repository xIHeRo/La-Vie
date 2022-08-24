import 'package:flutter/material.dart';
import 'package:la_vie/app/dependecy_injection.dart';
import 'package:la_vie/presentation/forget_password/forget_password_view.dart';
import 'package:la_vie/presentation/login/view/login_view.dart';
import 'package:la_vie/presentation/main/main_view.dart';

import 'package:la_vie/presentation/register/register_view.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/splash/splash_view.dart';
import 'package:la_vie/presentation/store_details/store_details_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case Routes.loginRoute:
        // Initiallize UseCase Before moving to the login
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(StringsManager.noRouteFound),
        ),
        body: const Center(
          child: Text(StringsManager.noRouteFound),
        ),
      ),
    );
  }
}
