import 'package:flutter/material.dart';
import 'package:la_vie/presentation/common/state_renderer/state_renderer.dart';

import '../../../app/constants.dart';
import '../../resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRenderType();
  String getMessage();
}
// Class contains 2 functions
// 1) to get the loadingMessage
// 2) to get the type of the error

// Loading ( PopUp & Full Screen)
//----------------------------------------------------------------
class LoadingState extends FlowState {
  StateRendererType
      stateRendererType; // needs an object from the generated enum
  String? message;

  LoadingState(
      {required this.stateRendererType,
      String message = StringsManager.loading});
  @override
  String getMessage() => message ?? StringsManager.loading;

  @override
  StateRendererType getStateRenderType() => stateRendererType;
}

//----------------------------------------------------------------
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
// Error Message that will come from the api
  String message;

  ErrorState(this.stateRendererType, this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderType() => stateRendererType;
}

//----------------------------------------------------------------
class ContentState extends FlowState {
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRenderType() => StateRendererType.contentState;
}

//----------------------------------------------------------------
class EmptyState extends FlowState {
// Error Message that will come from the api
  String message;
  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderType() =>
      StateRendererType.fullScreenEmptyState;
}

//----------------------------------------------------------------
//LoadingState.getScreenWidget( , ,)
extension FlowStateExtenetion on FlowState {
  Widget getScreenWidget(BuildContext context, Function onRetryActionFunction,
      Widget contentStateWidget) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRenderType() == StateRendererType.popUpLoadingState) {
            // show PopUp Loading
            showPopUp(context, getStateRenderType(), getMessage());
            // show content of Ui screen
            return contentStateWidget;
          } else {
            // full screen loading state
            return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRenderType(),
              retryActionFunction: onRetryActionFunction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRenderType() == StateRendererType.popUpErrorState) {
            // show PopUp Error
            showPopUp(context, getStateRenderType(), getMessage());
            // show content of Ui screen
            return contentStateWidget;
          }
          // full screen loading state
          else {
            return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRenderType(),
              retryActionFunction: onRetryActionFunction,
            );
          }
        }
      case EmptyState:
        {
          return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRenderType(),
              retryActionFunction: () {});
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentStateWidget;
        }
      default:
        {
          dismissDialog(context);
          return contentStateWidget;
        }
    }
  }

//----------------------------------------------------------------
// Function to check if there is a dialoge opened return true
  _isCurrentDialogeShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
  //----------------------------------------------------------------
  dismissDialog(BuildContext context) {
    if (_isCurrentDialogeShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

//----------------------------------------------------------------
  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          retryActionFunction: () {},
        ),
      ),
    );
  }
}
