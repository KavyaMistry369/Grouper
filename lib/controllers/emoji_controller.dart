import 'package:flutter/foundation.dart';

class Emoji_Controller extends ChangeNotifier{
  bool isKeyboardEnable=false;
  bool isDark=false;


  void ChangeKeyBoard(){
    isKeyboardEnable=!isKeyboardEnable;
    notifyListeners();
  }

  void ChangeTheme(){
    isDark=!isDark;
    notifyListeners();
  }


  void OffKeyBoard(){
    isKeyboardEnable=false;
    notifyListeners();
  }



}