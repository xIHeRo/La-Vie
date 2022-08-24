import 'dart:async';

import 'package:flutter/material.dart';
import 'package:la_vie/presentation/common/common_widgets.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/constants_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';

import '../../app/app_prefrences.dart';
import '../../app/dependecy_injection.dart';
import '../resources/values_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  //Generating Timer for 5 seconds in splash screen
  Timer? _timer;
  final AppPrefrences _appPrefrences = instance<AppPrefrences>();
  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstantsManager.splashDelay),
        _navigateAfterDelay);
  }

  _navigateAfterDelay() {
    _appPrefrences.isUserLoggedIn().then(
      (isLoggedIn) {
        if (isLoggedIn) {
          // UserLoggedInBefore --> Go TO Main Page
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
        } else {
          _appPrefrences.isOnBoardingScreenViewed().then(
            (isOnBoardingviewed) {
              if (isOnBoardingviewed) {
                // User has seen the onBoarding --> Go TO Login Page
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              } else {
                // User has not seen the onBoarding --> Go TO Main Page
                Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
              }
            },
          );
        }
      },
    );
  }

//Widget navigationAfterSplash
  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   FrameSize.init(context);
  //   return AnimatedSplashScreen(
  //     splash: Center(
  //         child: CommonWidgets.getBrandName(fontSize: FontSizeManager.s36)),
  //     nextScreen: _navigateAfterDelay(),
  //     animationDuration:
  //         const Duration(seconds: AppConstantsManager.splashDelay),
  //     backgroundColor: ColorManager.white,
  //     duration: AppConstantsManager.splashDelay,
  //     //  screenFunction: _navigateAfterDelay(),
  //     splashTransition: SplashTransition.scaleTransition,
  //     function: _navigateAfterDelay(),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    FrameSize.init(context);
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
          child: CommonWidgets.getBrandName(fontSize: FontSizeManager.s36)),
    );
  }
}
