import 'package:flutter/material.dart';

enum ViewState{Idle, Busy, Success}

class BaseProviderModel extends ChangeNotifier{
  ViewState _viewState = ViewState.Idle;

  ViewState get viewState => _viewState;

  void setViewState(state){
    _viewState = state;
    notifyListeners();
  }
}