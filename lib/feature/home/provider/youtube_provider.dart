import 'package:flutter/material.dart';

class YoutubeProvider with ChangeNotifier {
  bool isNetworkError = false;
  bool isSearchDialog = false;
  bool isLoading = false;
  int buttonActive = 0;
  double progress = 0;

  void isNatworkUpdate(bool data) {
    isNetworkError = data;
    notifyListeners();
  }

  void isSearchDialogUpdate(bool data) {
    isNetworkError = data;
    notifyListeners();
  }

  void isLoadingUpdate(bool data) {
    isLoading = data;
    print(data);
    notifyListeners();
  }

  void buttonActiveUpdate(int data) {
    buttonActive = data;
    notifyListeners();
  }

  void progressUpdate(double data) {
    progress = data;
    notifyListeners();
  }
}
