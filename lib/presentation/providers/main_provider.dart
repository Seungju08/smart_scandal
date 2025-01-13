import 'package:flutter/material.dart';

final mainProvider = MainProvider();

class MainProvider extends ChangeNotifier {
  int currentTabIndex = 0;

  PageController pageController = PageController();

  void changeTabIndex(int index) {
    currentTabIndex = index;
    pageController.jumpToPage(currentTabIndex);
    notifyListeners();
  }
}
