import 'base_view_view_model.dart';

enum State { ok, error, loading }

/// createdby Daewu Bintara
/// Saturday, 1/30/21

///
/// --------------------------------------------
/// There are several [State]s in this class.
/// The [Function]s and [State]s in this class are only to be used in classes that extend in [BaseViewModel].
/// You can find and use on your Controller wich is the Controller extends [BaseController].
class WidgetState {
  final Rx<State> _widgetState = State.loading.obs;
  Rx<State> stateLoading = State.loading.obs;
  Rx<State> stateOk = State.ok.obs;
  Rx<State> stateError = State.error.obs;

  Rx<State> get getWiState => _widgetState;

  set setWiState(Rx<State> event) => _widgetState.value = event.value;

  bool get wiStateIsLoading => _widgetState.value == stateLoading.value;

  bool get wiStateIsOK => _widgetState.value == stateOk.value;

  bool get wiStateIsError => _widgetState.value == stateError.value;
}

///
/// --------------------------------------------
/// There are several [State]s in this class.
/// The [Function]s and [State]s in this class are only to be used in classes that extend in [BaseView].
/// You can find and use on your Controller wich is the Controller extends [BaseController].
class ScreenState {
  State _screenState = State.loading;
  State screenStateLoading = State.loading;
  State screenStateOk = State.ok;
  State screenStateError = State.error;

  State get getScreenState => _screenState;

  set setScreenState(State event) => _screenState = event;

  bool get screenStateIsLoading => _screenState == screenStateLoading;

  bool get screenStateIsOK => _screenState == screenStateOk;

  bool get screenStateIsError => _screenState == screenStateError;
}
