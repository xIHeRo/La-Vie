import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:la_vie/presentation/resources/style_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import '../../../app/app_prefrences.dart';
import '../../../app/dependecy_injection.dart';
import '../../common/common_widgets.dart';
import '../../common/state_renderer/state_renderer_implementer.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../view_model.dart/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //------------------Dependecy Injection --------------------------------
  final AppPrefrences _appPrefrences = instance<AppPrefrences>();
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  //----------------------------------------------------------------
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //----------------------------------------------------------------
  // Switching between pages
  bool isLogin = true;
  final PageController _pageController = PageController();
  //----------------------------------------------------------------
  _bind() {
    _viewModel.start();
    _usernameController.addListener(() => _viewModel.setUsername(
        _usernameController.text)); // Listener on UserName to be send as stream
    _passwordController.addListener(() => _viewModel.setPassword(
        _passwordController.text)); // Listener on Password to be send as stream

    _viewModel.isUserLogedInSuccefullyStreamController.stream.listen(
      (isLoggedIn) {
        if (isLoggedIn) {
          // Exute the functions the next 2 functions after the all the screen widgets have been built
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              _appPrefrences
                  .setUserLoggedIn(); // set in sharedPrefrences that user has logginn in
              Navigator.of(context)
                  .pushReplacementNamed(Routes.mainRoute); // Apear home screen
            },
          );
        }
      },
    );
  }

  //----------------------------------------------------------------
  @override
  void initState() {
    _bind();
    super.initState();
  }

//----------------------------------------------------------------
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

//----------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            // data returns the state of the screen

            return snapshot.data?.getScreenWidget(
                    context, () => _viewModel.login(), _getContentWidget()) ??
                _getContentWidget();
          },
        ));
  }

  //-------------------Registeration Screen -------------------------------
  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: PaddingManager.p10),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //------------------- Leaves on top right ------------------
              SizedBox(
                height: FrameSize.screenHeight * 0.2,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(ImageAssetsManager.loginTopRightLeaves),
                ),
              ),
              //------------------- La Vie Text  ------------------
              Padding(
                padding: const EdgeInsets.only(
                    bottom: FrameSize.figmaFrameHeight * 0.001,
                    top: FrameSize.figmaFrameHeight * 0.001),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CommonWidgets.getBrandName()],
                ),
              ),

              //-------------------- ROW of login And SignUp------------
              Padding(
                padding: EdgeInsets.only(
                    top: FrameSize.screenHeight * 0.015,
                    bottom: FrameSize.screenHeight * 0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //--------------- Sign Up Switch button------------------
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: PaddingManager.p5), // spacing under text
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color:
                            isLogin ? ColorManager.white : ColorManager.primary,
                        width: SizeManager.s3, // Underline thickness
                      ))),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = false;
                          });
                        },
                        child: Text(
                          StringsManager.signUp,
                          style: getBoldFont(
                              fontSize: SizeManager.s18,
                              color: isLogin
                                  ? ColorManager.grey
                                  : ColorManager.primary),
                        ),
                      ),
                    ),
                    //--------------- login Switch button ------------------
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: PaddingManager
                            .p3, // Space between underline and text
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isLogin
                                ? ColorManager.primary
                                : ColorManager.white,
                            width: SizeManager.s3, // Underline thickness
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = true;
                          });
                        },
                        child: Text(
                          StringsManager.login,
                          style: getBoldFont(
                              fontSize: SizeManager.s18,
                              color: isLogin
                                  ? ColorManager.primary
                                  : ColorManager.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //------------------------ Login Implementation -----------------
              if (isLogin) _getLoginScreen() else _getSignUpScreen(),
              //----------------------------------------------------------------

              //-----------------------Bottom Row (or contiue with)--------------------------------
              Padding(
                padding: EdgeInsets.only(
                  top: FrameSize.screenHeight * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: ColorManager.lightGrey,
                      height: SizeManager.s2,
                      width: FrameSize.screenWidth * 0.25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PaddingManager.p5),
                      child: Text(
                        StringsManager.loginViaOtherPlatforms,
                        style: getRegularFont(color: ColorManager.lightGrey),
                      ),
                    ),
                    Container(
                      color: ColorManager.lightGrey,
                      height: SizeManager.s2,
                      width: FrameSize.screenWidth * 0.25,
                    )
                  ],
                ),
              ),
              //------------------------Bottom Leaves + GOOGLE + FACEBOOK ----------------------------
              SizedBox(
                height: FrameSize.screenHeight * 0.2,
                width: double.infinity,
                child: Stack(
                  children: [
                    //--------------------------- Bottom Left Leaves -------------------
                    Positioned(
                      left: SizeManager.s0,
                      bottom: SizeManager.s0,
                      child:
                          Image.asset(ImageAssetsManager.loginBottomLeftLeaves),
                    ),
                    Positioned(
                      right: FrameSize.screenWidth * 0.35,
                      top: SizeManager.s0,
                      child: Center(
                        //------------------------ Rows for Google & Facebook --------------------
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // -------------- Google Button ----------------------
                            SizedBox(
                              width: SizeManager.s50,
                              height: SizeManager.s50,
                              child: IconButton(
                                onPressed: () {},
                                icon:
                                    Image.asset(ImageAssetsManager.googleLogo),
                                iconSize: SizeManager.s50,
                                splashRadius: SizeManager.s20,
                              ),
                            ),
                            const SizedBox(
                              width: SizeManager.s16,
                            ),
                            // -------------- FaceBook Button ----------------------
                            SizedBox(
                              width: SizeManager.s50,
                              height: SizeManager.s50,
                              child: IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                    ImageAssetsManager.facebookLogo),
                                iconSize: SizeManager.s50,
                                splashRadius: SizeManager.s20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //---------------------Login Implmentation---------------------------
  Widget _getLoginScreen() {
    return Column(
      children: [
        //----------------------------Email Text ----------------------------
        Row(
          children: [
            const SizedBox(
              width: FrameSize.figmaFrameWidth * 0.08,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  StringsManager.email,
                  style: getRegularFont(
                      fontSize: SizeManager.s14, color: ColorManager.grey),
                )),
          ],
        ),
        //----------------------------Email Field----------------------------
        Padding(
          padding: EdgeInsets.only(
              left: FrameSize.screenWidth * 0.085,
              right: FrameSize.screenWidth * 0.085,
              bottom: FrameSize.screenHeight * 0.04),
          child: StreamBuilder<bool>(
            stream: _viewModel.outIsUsernameValid,
            builder: (context, snapshot) {
              return TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _usernameController,
                decoration: InputDecoration(
                  //hintText: StringsManager.username,
                  // labelText: StringsManager.username,
                  // when first open screen : bool= null --> return true --> disappear the red message
                  // check on the bool --> true --> username valid --> pass null --> to disappear the red message
                  // check on the bool --> false --> username notValid --> pass Error red message

                  errorText: (snapshot.data ?? true)
                      ? null
                      : StringsManager.usernameError,
                ),
              );
            },
          ),
        ),

        //----------------------------Password Text ----------------------------
        Row(
          children: [
            const SizedBox(
              width: FrameSize.figmaFrameWidth * 0.08,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  StringsManager.password,
                  style: getRegularFont(
                      fontSize: SizeManager.s14, color: ColorManager.grey),
                )),
          ],
        ),
        //--------------------------Password Field------------------------------
        Padding(
          padding: EdgeInsets.only(
              left: FrameSize.screenWidth * 0.085,
              right: FrameSize.screenWidth * 0.085),
          child: StreamBuilder<bool>(
            stream: _viewModel.outIsPasswordValid,
            builder: (context, snapshot) {
              return TextFormField(
                keyboardType: TextInputType.text,
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: (snapshot.data ?? true)
                      ? null
                      : StringsManager.passwordError,
                ),
              );
            },
          ),
        ),
        //------------------------Login Button-------------------------------

        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
                left: FrameSize.screenWidth * 0.085,
                right: FrameSize.screenWidth * 0.085,
                top: FrameSize.screenHeight * 0.04),
            child: StreamBuilder<bool>(
              stream: _viewModel.outputAreAllDataValid,
              builder: (context, snapshot) {
                return ElevatedButton(
                  onPressed: (snapshot.data ?? false)
                      ? () {
                          _viewModel.login();
                        }
                      : null,
                  child: const Text(StringsManager.login),
                );
              },
            ),
          ),
        ),

        ///------------------------------------------------------------------
      ],
    );
  }

  //----------------------Sign Up Implementation---------------------------

  Widget _getSignUpScreen() {
    return Column(
      children: [
        //----------------------------First Name Text ----------------------------
        Row(
          children: [
            const SizedBox(
              width: FrameSize.figmaFrameWidth * 0.08,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  StringsManager.firstName,
                  style: getRegularFont(
                      fontSize: SizeManager.s14, color: ColorManager.grey),
                )),
          ],
        ),
        //----------------------------Firs Name Field----------------------------
        Padding(
          padding: EdgeInsets.only(
              left: FrameSize.screenWidth * 0.085,
              right: FrameSize.screenWidth * 0.085,
              bottom: FrameSize.screenHeight * 0.04),
          child: StreamBuilder<bool>(
            stream: _viewModel.outIsUsernameValid,
            builder: (context, snapshot) {
              return TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _usernameController,
                decoration: InputDecoration(
                  //hintText: StringsManager.username,
                  // labelText: StringsManager.username,
                  // when first open screen : bool= null --> return true --> disappear the red message
                  // check on the bool --> true --> username valid --> pass null --> to disappear the red message
                  // check on the bool --> false --> username notValid --> pass Error red message

                  errorText: (snapshot.data ?? true)
                      ? null
                      : StringsManager.usernameError,
                ),
              );
            },
          ),
        ),
        //----------------------------Last Name Text ----------------------------
        Row(
          children: [
            const SizedBox(
              width: FrameSize.figmaFrameWidth * 0.08,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  StringsManager.lastName,
                  style: getRegularFont(
                      fontSize: SizeManager.s14, color: ColorManager.grey),
                )),
          ],
        ),
        //----------------------------Last Name Field----------------------------
        Padding(
          padding: EdgeInsets.only(
              left: FrameSize.screenWidth * 0.085,
              right: FrameSize.screenWidth * 0.085,
              bottom: FrameSize.screenHeight * 0.04),
          child: StreamBuilder<bool>(
            stream: _viewModel.outIsUsernameValid,
            builder: (context, snapshot) {
              return TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _usernameController,
                decoration: InputDecoration(
                  //hintText: StringsManager.username,
                  // labelText: StringsManager.username,
                  // when first open screen : bool= null --> return true --> disappear the red message
                  // check on the bool --> true --> username valid --> pass null --> to disappear the red message
                  // check on the bool --> false --> username notValid --> pass Error red message

                  errorText: (snapshot.data ?? true)
                      ? null
                      : StringsManager.usernameError,
                ),
              );
            },
          ),
        ),

        //----------------------------Email Text ----------------------------
        Row(
          children: [
            const SizedBox(
              width: FrameSize.figmaFrameWidth * 0.08,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  StringsManager.email,
                  style: getRegularFont(
                      fontSize: SizeManager.s14, color: ColorManager.grey),
                )),
          ],
        ),
        //----------------------------Email Field----------------------------
        Padding(
          padding: EdgeInsets.only(
              left: FrameSize.screenWidth * 0.085,
              right: FrameSize.screenWidth * 0.085,
              bottom: FrameSize.screenHeight * 0.04),
          child: StreamBuilder<bool>(
            stream: _viewModel.outIsUsernameValid,
            builder: (context, snapshot) {
              return TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _usernameController,
                decoration: InputDecoration(
                  //hintText: StringsManager.username,
                  // labelText: StringsManager.username,
                  // when first open screen : bool= null --> return true --> disappear the red message
                  // check on the bool --> true --> username valid --> pass null --> to disappear the red message
                  // check on the bool --> false --> username notValid --> pass Error red message

                  errorText: (snapshot.data ?? true)
                      ? null
                      : StringsManager.usernameError,
                ),
              );
            },
          ),
        ),

        //----------------------------Password Text ----------------------------
        Row(
          children: [
            const SizedBox(
              width: FrameSize.figmaFrameWidth * 0.08,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  StringsManager.password,
                  style: getRegularFont(
                      fontSize: SizeManager.s14, color: ColorManager.grey),
                )),
          ],
        ),
        //--------------------------Password Field------------------------------
        Padding(
          padding: EdgeInsets.only(
              left: FrameSize.screenWidth * 0.085,
              right: FrameSize.screenWidth * 0.085),
          child: StreamBuilder<bool>(
            stream: _viewModel.outIsPasswordValid,
            builder: (context, snapshot) {
              return TextFormField(
                keyboardType: TextInputType.text,
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: (snapshot.data ?? true)
                      ? null
                      : StringsManager.passwordError,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: FrameSize.screenHeight * 0.03,
        ),
//----------------------------Confirm Password Text ----------------------------
        Row(
          children: [
            const SizedBox(
              width: FrameSize.figmaFrameWidth * 0.08,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  StringsManager.confirmPassword,
                  style: getRegularFont(
                      fontSize: SizeManager.s14, color: ColorManager.grey),
                )),
          ],
        ),
        //--------------------------Confirm Password Field------------------------------
        Padding(
          padding: EdgeInsets.only(
              left: FrameSize.screenWidth * 0.085,
              right: FrameSize.screenWidth * 0.085),
          child: StreamBuilder<bool>(
            stream: _viewModel.outIsPasswordValid,
            builder: (context, snapshot) {
              return TextFormField(
                keyboardType: TextInputType.text,
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: (snapshot.data ?? true)
                      ? null
                      : StringsManager.passwordError,
                ),
              );
            },
          ),
        ),

        //------------------------Login Button-------------------------------
        //------------------------Login Button-------------------------------

        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
                left: FrameSize.screenWidth * 0.085,
                right: FrameSize.screenWidth * 0.085,
                top: FrameSize.screenHeight * 0.04),
            child: StreamBuilder<bool>(
              stream: _viewModel.outputAreAllDataValid,
              builder: (context, snapshot) {
                return ElevatedButton(
                  onPressed: (snapshot.data ?? false)
                      ? () {
                          _viewModel.login();
                        }
                      : null,
                  child: const Text(StringsManager.login),
                );
              },
            ),
          ),
        ),

        ///------------------------------------------------------------------
      ],
    );
  }
}
// Padding(
//                 padding: const EdgeInsets.only(
//                     top: PaddingManager.p10,
//                     left: PaddingManager.p10,
//                     right: PaddingManager.p10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // -------------------Forget Password----------------------------------
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushReplacementNamed(
//                             context, Routes.forgetPasswordRoute);
//                       },
//                       child: Text(
//                         StringsManager.forgetPassword,
//                         style: Theme.of(context).textTheme.bodyLarge,
//                       ),
//                     ),
//                     // -----------------------SignUp------------------------------
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushReplacementNamed(
//                             context, Routes.registerRoute);
//                       },
//                       child: Text(
//                         StringsManager.registerText,
//                         style: Theme.of(context).textTheme.bodyLarge,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
