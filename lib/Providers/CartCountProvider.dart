import 'package:flutter/material.dart';
import 'package:pocketuse/Utils/MyPreferenceManager.dart';

class CartCountProvider extends ChangeNotifier{

  int cartItemcount=0;


  void setDisplayText(int text) {
    cartItemcount = text;
    notifyListeners();
    setCountInPrefrense();
  }

  int getCartItemCount(){
    print('Count=========='+cartItemcount.toString());
    return cartItemcount;
  }

  setCountInPrefrense() async {
    MyPreferenceManager _myPreferenceManager = await MyPreferenceManager.getInstance();
    _myPreferenceManager.setInt(MyPreferenceManager.CART_COUNT, cartItemcount);
    print('Count=========='+cartItemcount.toString());
  }


}
