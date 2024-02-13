import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Consts {

  Consts._();

  static const String something_went_wrong = 'Something went wrong';
  static String currencySymbol= '₹ ';
  static String currencySymbolWithoutSpace= '₹';
  static const String app_name = 'Asia Online';
//  static const Color app_primary_color = Colors.blueAccent;
//  static const Color app_primary_color =  Color(0xff2874f0); // Second `const` is optional in assignments.
  static const Color app_primary_color =  Color(0xff2874f0); // Second `const` is optional in assignments.
  static const Color divider_or_bgcolor =  Color(0xffF2F3F7); // Second `const` is optional in assignments.
  static const Color orange_Button =  Color(0xFFFF6E40); // Second `const` is optional in assignments.
//  static const Color app_primary_color2 = const Color(0xff2874f0); // Second `const` is optional in assignments.

  static GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  static  String device_rendom_number = '';
  static  String api_authentication_token = '';
  static  String current_username = '';
  static  String current_useremail = '';
  static  String current_phonenumber = '';
  static  String current_userid = '';
  static  bool Is_user_login = false;
  static int cartItemcount=0;

}
