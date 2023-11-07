
import 'package:flutter/material.dart';
import '../Authentication/LoginPage.dart';

class PageProvider extends ChangeNotifier {
  int _pageIdx = 0;
  int _pageState = 0;

  int get pageIdx => _pageIdx;
  int get pageState => _pageState;

  setPageIdx(int value) {
    _pageIdx = value;
    notifyListeners();
  }

  setPageState(int value) {
    _pageState = value;
    notifyListeners();
  }
}