import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pocketuse/Pages/LoginPage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/Utils/MyPreferenceManager.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonWidget{

  static Widget lblText(String lbl) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
      child: Text(lbl, style: TextStyle(fontSize : 12, color: Colors.grey[600], fontWeight: FontWeight.w600),),
    );
  }

  static Widget customdivider(BuildContext context, double height) {
    return Container(
      color: Colors.grey[200],
      height: height,
      width: MediaQuery.of(context).size.width,
    );
  }
  static Widget getIconImgeWithNHeightCustomSize(
      String str, double _height, double _width) {
    return Image(
      image: AssetImage(str),
      height: _height,
      width: _width,
    );
  }

  static Widget customdividerwithCustomColor(BuildContext context, double height, Color _color) {
    return Container(
      padding: EdgeInsets.all(0),
      color: _color,
      height: height,
      width: MediaQuery.of(context).size.width,
    );
  }

  static InputDecoration ETInputDecoration() {
    return new InputDecoration(
      labelStyle: TextStyle(color: Colors.black87, fontSize: 10),
      hintStyle: TextStyle(
          color: Colors.grey[500], fontSize: 10
      ),
      contentPadding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      border: new OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(5.0),
        ),
        borderSide: new BorderSide(
          color: Colors.black12,
          width: 0.7,
        ),
      ),
    );
  }

  static Widget submitButtonBottomLine(){
    return SizedBox(
      height: 10.0,
      width: 55.0,
      child: new Center(
        child: new Container(
          decoration:  BoxDecoration(
            color: Consts.app_primary_color,
          ),
          margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
          height: 5.0,
//                                color: Colors.red,
        ),
      ),
    );
  }
  static TextStyle TFCommnTextStyle() {
    return  TextStyle(fontSize : 13, color: Colors.black87, fontWeight: FontWeight.w600);
  }
  static InputDecoration PETInputDecoration() {
    return new InputDecoration(
      labelStyle: TextStyle(color: Colors.black87, fontSize: 10),
      hintStyle: TextStyle(
          color: Colors.grey[500], fontSize: 10
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
//      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      border: new OutlineInputBorder(
        gapPadding: 2.0,
        borderRadius: const BorderRadius.all(
          const Radius.circular(5.0),
        ),
        borderSide: new BorderSide(
          color: Colors.black12,
          width: 0.7,
        ),
      ),
    );
  }
  static Widget ActionBarBg(){
//    Container(
//      color: Consts.app_primary_color,
//    );
//    return Container(
//      decoration: BoxDecoration(
//        gradient: LinearGradient(
//          begin: Alignment.centerLeft,
//          end: Alignment.centerRight,
//          colors: <Color>[
//            Color(0xFFE64A19),
//            Color(0xFFE64A19),
////            Color(0xFFFF0000),
//          ],
//        ),
//      ),
//    );
    return Container(
      color: Consts.app_primary_color,
//      color: Theme.of(context).primaryColor,
    );
  }

  static Widget getActionBarTitleText(String title){
    return Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
    );
  }

  static Widget priceDarkRedcolorText(String price){
    return Text(price,
      style: TextStyle(color: Consts.app_primary_color,
          fontWeight: FontWeight.w600,
          fontSize: 14));
  }


  static Widget leadidDarkRedcolorText(String leadid){
//    if(leadid.contains('(')){
//      var arr = leadid.split('(');
//      var valueWithLbl ="Référence "+arr[0]+"("+"Localiser "+arr[1];
//      return Text(valueWithLbl,
//        style: TextStyle(color: Colors.yellow.shade800, fontWeight: FontWeight.w400, fontSize: 17),);
//
//    } else{
//      return Expanded(
//        child: Text(Api_constant.Reference+leadid,
//          style: TextStyle(color: Colors.yellow.shade800, fontWeight: FontWeight.w400, fontSize: 13),),
//      );

    return
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(leadid,
          style: TextStyle(color: Colors.blueAccent[700], fontWeight: FontWeight.w400, fontSize: 14),),
      );
//    }
  }

  static bool ISCorporateUser(int corporateid){
      if(corporateid != null && corporateid != 0){
        return true;

      } else{
        return false;
      }
  }

  static Widget divider(){
    return Divider(
      thickness: 0.4,
      color: Colors.black87,);
  }

  static Widget jobnameText(String jobname){
    return Visibility(
      visible: false,
      child: Text(jobname, style: TextStyle(color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 20),),
    );
  }

  static Widget redHeaderLbl(String title){
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: 17,
        color: Consts.app_primary_color,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static Widget redHeadersmallLbl(String title){
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: 13,
        color: Consts.app_primary_color,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static Widget redHeaderBigLbl(String title){
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: 15,
        color: Consts.app_primary_color,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static Widget blackDiscriptionText(String title){
    return Expanded(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          height: 1.5,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static Widget grayDiscriptionText(String title) {
    return Expanded(
      child: Text(title, style: TextStyle(color: Colors.grey[700],
          fontWeight: FontWeight.w400,
          fontSize: 16),),
    );
  }

  static Widget gryIconNdGrayTextheaderLayout(String title, String icon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          getIconImge(icon),
          SizedBox(
            width: 15,
          ),
          grayDiscriptionText(title),
        ],
      ),
    );
  }

  static Widget gryCustomIconNdGrayTextheaderLayout(String title, String icon, double size) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          getIconImgeWithCustomSize(icon, size),
          SizedBox(
            width: 15,
          ),
          grayDiscriptionText(title),
        ],
      ),
    );
  }

  static Widget gryIconNdBlackTextheaderLayout(String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child:  Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Icon(
                icon,
                size: 22,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          blackDiscriptionText(title),
        ],
      ),
    );
  }
  static Widget getIconImge(String str) {
    return Image(image: AssetImage(str), height: 22, width: 22,);
  }

  static Widget getIconImgeWithCustomSize(String str, double size) {
    return Image(image: AssetImage(str), height: size, width: size,);
  }

  static String replaceNullWithEmpty(dynamic str){
      if(null == str || str == "null" || str == "Null" || str == "NULL"){
      return '';
    } else{
      return str.toString();
    }
  }
  static String replaceNullIntWithEmpty(int str){
    if(null == str){
      return '';
    } else{
      return str.toString();
    }
  }

  static double getDoubleFromStrForRating(String str){
    if(null == str || str.isEmpty){
      return 0.0;
    } else{
      return double.parse(str);
    }
  }
  static String getintFromStr(int str){
    if(null == str  ){
      return "0" ;
    } else{
      return str.toString();
    }
  }

  static getboolFromInt(int intValue) {
    if(null == intValue){
      return true;
    }else if(intValue==0){
      return true;
    }else if(intValue ==1){
      return false;
    } else{
      return true;
    }
  }

  static forEmptyReturnHide(String str){
    if(null == str || str.isEmpty) {
      return false;
    } else{
      return true;
    }
  }

  static bool isPasswordCompliant(String password, BuildContext context) {
    int minLength = 5;
//    int minLength = 7;
    if (password == null || password.isEmpty) {
      return false;
    }

//    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
//    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
//    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
//    bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
//    bool hasMinLength = password.length > minLength;
    bool hasMinLength = 13 > password.length && password.length > minLength ;

    if(12 < password.length){
     // Toast.show('gih', context, gravity: Toast.CENTER);
//      Toast.show("Veuillez saisir un mot de passe d'au moins 8 chiffres", context, gravity: Toast.CENTER);
    }

    if(password.length < 6 ){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'hg'),
        ),
      );
      //Toast.show('hg', context, gravity: Toast.CENTER);
//      Toast.show("Veuillez saisir un mot de passe d'au moins 8 chiffres", context, gravity: Toast.CENTER);
    }
//    else if(!hasDigits){
//      Toast.show("Le mot de passe doit contenir au moins un caractère numérique", context, gravity: Toast.CENTER);
//    } else if(!hasLowercase){
//      Toast.show("Le mot de passe doit contenir au moins un caractère minuscule", context, gravity: Toast.CENTER);
//    } else if(!hasUppercase){
//      Toast.show("Le mot de passe doit contenir au moins un caractère majuscule", context, gravity: Toast.CENTER);
//    }else if(!hasSpecialCharacters){
//      Toast.show("Le mot de passe doit contenir au moins un caractère de caractères spéciaux", context, gravity: Toast.CENTER);
//    }

//    return hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters & hasMinLength;
    return hasMinLength;
  }

  static String addCurrency(String delay_charges) {
    if(delay_charges == null || delay_charges.isEmpty){
      return "";
    } else{
      return Consts.currencySymbol +delay_charges;
    }
  }
  static Widget plblText(String lbl) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
      child: Text(lbl, style: TextStyle(fontSize : 10, color: Colors.grey[600], fontWeight: FontWeight.w600),),
    );
  }

  static Widget bottomSheetTitle(String s) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
      child: Text(
        s,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black87),
      ),
    );
  }
  static Widget bottomSheetTitle2(String s) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child:  Text(s,
        style: TextStyle(
            fontWeight: FontWeight.w400, color: Colors.black87, fontSize: 12
        ),),
    );
  }

  static int StringConvertintiInt(String current_userid) {
    if(Consts.current_userid != null && Consts.current_userid.isNotEmpty){
      return   int.parse(Consts.current_userid);
    } else{
      return 0;
    }

  }

  static getPAymentTopView(int i, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        SizedBox(
          height: 15,
        ),
        Padding(padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
          child:   Wrap(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  i ==0 ? Icon(Icons.check_circle, color: Consts.app_primary_color, size: 24,): Icon(Icons.check_circle_outline, color: Consts.app_primary_color, size: 24,),

                  Expanded(child:  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    color:  i == 1 ? Colors.blue : Colors.grey,
//                      width: linewidth,
                    height: 2,
                  ),),

                  i == 1 ? Icon(Icons.check_circle, color: Consts.app_primary_color, size: 24,): Icon(Icons.check_circle_outline, color: Consts.app_primary_color, size: 24,),
                  Expanded(child:  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    color: Colors.grey,
//                      width: linewidth,
                    height: 2,
                  ),),

                  i == 2 ? Icon(Icons.check_circle, color: Consts.app_primary_color, size: 24,): Icon(Icons.check_circle_outline, color: Consts.app_primary_color, size: 24,),
                  SizedBox(width: 10,)
                ],
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Text('Cart', style: TextStyle(fontSize: 11, color: i ==0 ?  Colors.grey[800] : Colors.grey[600])),

                  Expanded(child:  Container(),),

                  Center(
                    child: Text('      Order summary', style: TextStyle(fontSize: 11, color: i ==1 ?  Colors.grey[800] :Colors.grey[500]),),
                  ),
                  Expanded(child:  Container(),),

                  Text('Payment', style: TextStyle(fontSize: 11, color: i ==2 ?  Colors.grey[800] :Colors.grey[500]),)
                ],
              ),

            ],
          ),),
        SizedBox(
          height: 15,
        ),
        CommonWidget.customdividerwithCustomColor(
            context, 1, Colors.grey[400]),
        Container(
          color: Colors.grey[200],
          height: 7,
          width: MediaQuery.of(context).size.width,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  static BoxDecoration containerShadow(){
    return  BoxDecoration(
    boxShadow: <BoxShadow>[
    BoxShadow(
    color: Colors.black45,
    blurRadius: 10.0,
    offset: Offset(0.0, 0.75)
    )
    ],
    color: Colors.white
    );
  }

  static getDiscountTextStyle() {
    return TextStyle(
        color: Colors.green[700],
        fontSize: 14,
        fontWeight: FontWeight.w600);
  }

  static bool IsdiscountVisible(String discount_percentage) {
    if(discount_percentage == null || discount_percentage.isEmpty || discount_percentage == "0"){
      return false;
    } else{
      return true;
    }

  }

  static bool IsdiscountVisibleForStr(String discount_percentage) {
    if(discount_percentage == null|| discount_percentage.isEmpty ||
        discount_percentage == "0.0" || discount_percentage == "0" ||
    discount_percentage == "0.00"){
      return false;
    } else{
      return true;
    }

  }
  static Widget getloadingBulder(ImageChunkEvent loadingProgress) {
   return Center(
    child: /*CircularProgressIndicator(
      value: loadingProgress.expectedTotalBytes != null ?
      loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
          : null,
    ),*/
      getIconImgeWithCustomSize("assets/images/placeholder2.png", 30),
//   child: getIconImgeWithCustomSize("assets/images/person_placeholder.jpg", 30),
   );
  }

  static Future<void>  launchInBrowser(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }
  static handleUnError(BuildContext context, String body) async {
    Map userMap = jsonDecode(body);

    if(userMap.containsKey("message")){
      var response_code = userMap["message"];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              response_code),
        ),
      );
     // Toast.show( response_code, context, gravity: Toast.CENTER);
    }

//    Toast.show( "Unauthenticated. Please Login", context, gravity: Toast.BOTTOM);
    MyPreferenceManager _myPreferenceManager = await MyPreferenceManager.getInstance();
    _myPreferenceManager.clearData();
    Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.routeName, (Route<dynamic> route) => false);
  }
}

