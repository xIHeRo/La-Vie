import 'dart:async';

import '../../common/state_renderer/state_renderer_implementer.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // Shared variables and functions that will be used through any viewModel

  final StreamController _inputStreamController =
      StreamController<FlowState>.broadcast();

  @override
  //inputStreamController.sink is equivalent to input state
  Sink get inputState => _inputStreamController.sink;
  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowstate) => flowstate);
  @override
  void dispose() {
    _inputStreamController
        .close(); // to remove the SC when the baseViewModel ends its life cycle
  }
}

abstract class BaseViewModelInputs {
  void start(); // start view model Job
  void dispose(); // called when view model ends

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
