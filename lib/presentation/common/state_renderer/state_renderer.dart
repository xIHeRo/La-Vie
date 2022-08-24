import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/style_manager.dart';
import '../../resources/values_manager.dart';

enum StateRendererType {
  popUpLoadingState,
  popUpErrorState,

  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  contentState,
}

// Class upon its paramters show the Rendering page
class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String title;
  String message;
  Function retryActionFunction;

  StateRenderer(
      {required this.stateRendererType,
      this.title = "",
      this.message = StringsManager.loading,
      required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      //------------------
      case StateRendererType.popUpLoadingState:
        return _getPopUpDialog(
            context, [_getRenderAnimatedImage(JsonAssetsManager.loading)]);
      //------------------
      case StateRendererType.popUpErrorState:
        return _getPopUpDialog(context, [
          _getRenderAnimatedImage(JsonAssetsManager.error),
          _getRenderMessage(message),
          _getRenderRetryButton(context, StringsManager.ok)
        ]);
//------------------
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn([
          _getRenderAnimatedImage(JsonAssetsManager.loading),
          _getRenderMessage(message),
        ]);
//------------------
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getRenderAnimatedImage(JsonAssetsManager.error),
          _getRenderMessage(message),
          _getRenderRetryButton(context, StringsManager.tryAgain)
        ]);

      //------------------
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn([
          _getRenderAnimatedImage(JsonAssetsManager.empty),
          _getRenderMessage(message),
        ]);
      //------------------
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  //-----------------------PopUp Dialoge--------------------------------
  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeManager.s14)),
      elevation: SizeManager.s2,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(SizeManager.s14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        child: _getDialogContent(context, children),
      ),
    );
  }

//--------------- PopUp Dialoge Column of widgets----------------------
  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
        mainAxisSize: MainAxisSize.min, // to minimize the empty space in
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children);
  }

  // Since all the state renders are in column but with different elemtns we made a
  // function to return Column with list of items
  //--------------------------Full Screen -Column of Items---------------------------
  Widget _getItemsColumn(List<Widget> children) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children);
  }

//------------------------Render Image------------------------------------
  Widget _getRenderAnimatedImage(String animationName) {
    return SizedBox(
      height: SizeManager.s150,
      width: SizeManager.s150,
      child: Lottie.asset(animationName),
    );
  }

//------------------------ Render Message -------------------------------
  Widget _getRenderMessage(String message) {
    return Text(
      message,
      style: getRegularFont(
          fontSize: FontSizeManager.s20, color: ColorManager.black),
    );
  }

  //------------------------Render Button------------------------------------
  Widget _getRenderRetryButton(BuildContext context, String messageOnButton) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PaddingManager.p10),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (stateRendererType == StateRendererType.fullScreenErrorState) {
                retryActionFunction.call();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(messageOnButton),
          ),
        ),
      ),
    );
  }
  //---------------------------------------------------------------------------

}
