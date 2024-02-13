//import 'package:dart_notification_center/dart_notification_center.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pocketuse/Providers/CartCountProvider.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/Utils/MyPreferenceManager.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

import 'HomePage.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/SplashPage';

  @override
  SplashPageState createState() => SplashPageState();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class SplashPageState extends State<SplashPage> {
// THIS FUNCTION WILL NAVIGATE FROM SPLASH SCREEN TO HOME SCREEN.    // USING NAVIGATOR CLASS.
  bool alreadyNavigateByNotificationClick = false;
//  Image image1;
  ImageProvider logo;

  Future navigationToNextPage() async {
    MyPreferenceManager _myPreferenceManager =
        await MyPreferenceManager.getInstance();
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);

//    if (alreadyNavigateByNotificationClick) {
//    } else
//    if (_myPreferenceManager.getBool(MyPreferenceManager.IS_USER_LOGIN)) {
//      Navigator.of(context).pushReplacementNamed(PostJob1New.routeName);
//    } else {
//      Navigator.of(context).pushReplacementNamed(Login.routeName);
//    }
  }

  startSplashScreenTimer() async {
    var _duration = new Duration(milliseconds: 750);
    return new Timer(_duration, navigationToNextPage);
  }

//  @override
//  void didChangeDependencies() {
//
//    precacheImage(image1.image, context);
//    super.didChangeDependencies();
//  }

  CartCountProvider appState = null;

  Future<void> updateCartItemCount() async {
    MyPreferenceManager _myPreferenceManager = await MyPreferenceManager.getInstance();
    var temp = _myPreferenceManager.getInt(MyPreferenceManager.CART_COUNT);
    print('Count=========='+temp.toString());

    if(appState != null && temp != null){
      appState.setDisplayText(temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<CartCountProvider>(context);
    updateCartItemCount();

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blue[700],
        body: Container(
            height: double.infinity,
            width: double.infinity,
//            color: Colors.blueAccent,
            child: new Center(
              child: Image(
                height: 162.0,
                width: 162.0,
                image: logo,
//                color: Colors.white,
              ),
//              child: Text(Consts.app_name, style: TextStyle(color: Colors.white, fontSize: 20),),
            )
        )
//            child: new Image.asset('assets/images/splash.png', fit: BoxFit.fill))
        );
  }

  @override
  void initState() {
    getdataFromPrefrense();

    logo = AssetImage(
      'assets/images/logosmall.png',
    );
    super.initState();

    _requestIOSPermissions();
    startSplashScreenTimer();
  }

  Future update_token(String token) async {
    var _myPreferenceManager = await MyPreferenceManager.getInstance();
    _myPreferenceManager.setString(
        MyPreferenceManager.DEVICE_TOKEN, token.toString());
  }

//  Future<void> displlayNotification(Map<String, dynamic> message) async {
  static Future<void> displlayNotification(Map<String, dynamic> message) async {
    var data = message['data'] ?? message;

    String notify_type = '';
    String title = '';
    String body = data['body'];
    String icon = data['icon'];

    notify_type = data['notify_type'];
    title = data['title'];
    String job_id = data['job_id'];

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'LAHAGLI', 'LAHAGLI',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
 //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails();
    if (flutterLocalNotificationsPlugin != null) {
      await flutterLocalNotificationsPlugin
          .show(0, title, body, platformChannelSpecifics, payload: job_id);
    }
  }

  static void _requestIOSPermissions() {
//    flutterLocalNotificationsPlugin
//        .resolvePlatformSpecificImplementation<
//        IOSFlutterLocalNotificationsPlugin>()
//        ?.requestPermissions(
//      alert: true,
//      badge: true,
//      sound: true,
//    );
  }

  static NotificationAppLaunchDetails notificationAppLaunchDetails;

//  static Future<void> initNoti(bool IsSowiDisplay) async {

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    print('on message++ $message');
  }

  //PRIVATE METHOD TO HANDLE NAVIGATION TO SPECIFIC PAGE
  static Future<void> _navigateToItemDetail(
      BuildContext context, String job_id) async {
    //on click of notification redirect to this page
//    print('==================='+context.toString()+" "+job_id+" "+Consts.navigatorKey.currentState.toString());
//    Consts.navigatorKey.currentState.pushNamed(MyRequestDetail.routeName, arguments: job_id);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              //on click of notification redirect to this page
//              Consts.navigatorKey.currentState.pushNamed(MyRequestDetail.routeName, arguments: payload);
            },
          )
        ],
      ),
    );
  }

  Future<void> getdataFromPrefrense() async {

    MyPreferenceManager _myPreferenceManager = await MyPreferenceManager.getInstance();
    Consts.Is_user_login = _myPreferenceManager.getBool(MyPreferenceManager.IS_USER_LOGIN);
    Consts.api_authentication_token = _myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_TOKEN);
    print('api_authentication_token== '+ Consts.api_authentication_token );

    Consts.current_username = _myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_NAME);
    Consts.current_phonenumber = _myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_PHONE_NUBER);
    Consts.current_userid =_myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_ID);
    Consts.current_useremail = _myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_EMAIL);

    if(_myPreferenceManager.getString(MyPreferenceManager.DEVICE_RENDOM_NUMBER).isEmpty){
      var uuid = Uuid(); // Generate a v4 (random) id
      _myPreferenceManager.setString(MyPreferenceManager.DEVICE_RENDOM_NUMBER, uuid.v4());// -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'
    }

    Consts.device_rendom_number = _myPreferenceManager.getString(MyPreferenceManager.DEVICE_RENDOM_NUMBER);
    print("current_userid "+Consts.current_userid);
    print("device_rendom_number "+Consts.device_rendom_number);

  }
}
