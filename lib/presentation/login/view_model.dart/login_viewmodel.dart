import 'dart:async';

import 'package:la_vie/presentation/common/state_renderer/state_renderer.dart';

import '../../../domain/usecase.dart/login_usecase.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer_implementer.dart';
import '../../resources/base/base_viewModel.dart';
import '../../resources/strings_manager.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  //----------------------------------------------------------------
  //-------------------Stream Controllers ---------------------------------
  // .broadcast in oreder to  make more than one listener to be listen to the stream
  final StreamController _controlLoginOrSignUpStreamController =
      StreamController<bool>.broadcast();
  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserLogedInSuccefullyStreamController =
      StreamController<bool>();

  //----------------------------------------------------------------
  // Class wil hold & save the username and password before they are send to the api
  // generated using a freeze package
  LoginObject loginObject = LoginObject("", "");

  // LoginUseCase : fire username& Password from viewmodel to domain layer
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  ///LoginViewModel();
  //-------------------Intiallization & Termination-------------------

  @override
  void start() {
    // View model should tell the view to show the content state before any action from the user is performed
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _usernameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLogedInSuccefullyStreamController.close();
  }

  //---------------- Input -----------------
  @override
  setUsername(String username) {
    inputUserName
        .add(username); // Send the username throught the sink of the stream
    loginObject = loginObject.copyWith(
        username: username); // assign the username in the saving object
    inputAreAllDataValid.add(
        null); // to keep listening on the change in both username and password
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllDataValid.add(null);
  }

//-------------------------------------------------------------------
  @override
  Sink get inputIsLogin => _controlLoginOrSignUpStreamController.sink;
  @override
  Sink get inputUserName => _usernameStreamController.sink;
  @override
  Sink get inputPassword => _passwordStreamController.sink;
  @override
  Sink get inputAreAllDataValid => _areAllInputsValidStreamController.sink;
  @override

  //--------------------Output---------------------
  // Bool in order to make the user input both the user name and password to make the user
  // Login button appear and capable to be pressed
  @override
  Stream<bool> get outIsUsernameValid => _usernameStreamController.stream
      .map((username) => _isUsernameValid(username));
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));
  @override
  Stream<bool> get outputAreAllDataValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());
  @override
  Stream<bool> get outputIsLogin =>
      _controlLoginOrSignUpStreamController.stream.map((isLogin) => isLogin);

//------------------------Functions-----------------------------
  bool _isUsernameValid(String username) {
    return (username.isNotEmpty);
  }

  bool _isPasswordValid(String password) {
    return (password.isNotEmpty);
  }

  bool _areAllInputsValid() {
    return (_isUsernameValid(loginObject.username) &&
        _isPasswordValid(loginObject.password));
  }

//------------------------------------------------------------------
  // fold function is used to return the left and right of the used Either
  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    //----------------------------------
    (await _loginUseCase.excute(
            LoginUseCaseInput(loginObject.username, loginObject.password)))
        .fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.popUpErrorState, StringsManager.connectionProblem));
      print("I got error here man ${failure.code}");
    }, (data) {
      inputState.add(ContentState);
      isUserLogedInSuccefullyStreamController.add(
          true); // in THis case we send bool true that the user has loged in
      print(data.data?.user?.firstName);
    });
  }
}

//----------------------------------------------------------------
abstract class LoginViewModelInput {
  setUsername(String username);
  setPassword(String password);
  // For API CAll
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAreAllDataValid;
  Sink get inputIsLogin;
}

//----------------------------------------------------------------
abstract class LoginViewModelOutput {
  Stream<bool> get outputIsLogin;
  Stream<bool> get outIsUsernameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outputAreAllDataValid;
}
