import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/Utils/MyPreferenceManager.dart';
import 'package:pocketuse/model/ProfileEditResponse.dart';
import 'package:pocketuse/model/addressListArgument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';

import 'MyAddressListPage.dart';
import 'MyOrdersPage.dart';
import 'ProfileEditPage.dart';
import 'WishListPage.dart';

class MyAccountPage extends StatefulWidget {
  static const routeName = '/MyAccountPage';

  @override
  MyAccountPageState createState() {
    return MyAccountPageState();
  }
}

class MyAccountPageState extends State<MyAccountPage> {
  String imagePath = '';
  ProfileEditResponse profileEditResponse = null;

  @override
  Widget build(BuildContext context) {
//    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Consts.app_primary_color, // status bar color
////        backwardsCompatibility: false,
////        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.orange),
//      ),
      body: Container(
        color: Colors.grey[300],
//        color: Consts.app_primary_color,
        child: ListView(children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Consts.app_primary_color,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          width: 65.0,
                          height: 65.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                // image: AssetImage('assets/images/splash.png'),
                                image: getProfileImage(),
                              ))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      profileEditResponse != null
                          ? profileEditResponse.full_name
                          : Consts.current_username,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Text(
                      Consts.current_phonenumber,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      profileEditResponse != null
                          ? CommonWidget.replaceNullWithEmpty(profileEditResponse.email)
                          : CommonWidget.replaceNullWithEmpty(Consts.current_useremail),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      goToProfileEditWithAwait();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 40, 20),
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          size: 16, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);

//                    Navigator.of(context).pushNamedAndRemoveUntil(HomePage.routeName, (Route<dynamic> route) => false);
                      },
                    )),
              ),
            ],
          ),
          Container(
            color: Colors.grey[300],
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Wrap(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Orders',
                                style: getFirstTextLine(),
                              ),
                              getDivider(),
                              Align(
                                child: InkWell(
                                  child: Text(
                                    'VIEW ALL ORDERS',
                                    style: getsecondTextLine(),
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(MyOrdersPage.routeName);
                                  },
                                ),
                                alignment: Alignment.topRight,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 10,
                        color: Colors.grey[300],
                      ),
//                      Container(
//                        color: Colors.white,
//                        child: Padding(
//                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: [
//                              Text(
//                                'My Cards & Wallet',
//                                style: getFirstTextLine(),
//                              ),
//                              getDivider(),
//                              Align(
//                                child: Text(
//                                  'VIEW DETAILS',
//                                  style: getsecondTextLine(),
//                                ),
//                                alignment: Alignment.topRight,
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
//                      Container(
//                        height: 10,
//                        color: Colors.grey[300],
//                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Favorites',
                                style: getFirstTextLine(),
                              ),
                              getDivider(),
                              Align(
                                child: InkWell(
                                  child: Text(
                                    'VIEW YOUR FAVOURITE',
                                    style: getsecondTextLine(),
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(WishListPage.routeName);
                                  },
                                ),
                                alignment: Alignment.topRight,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 10,
                        color: Colors.grey[300],
                      ),
//                      Container(
//                        color: Colors.white,
//                        child: Padding(
//                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: [
//                              Text(
//                                'My Reviews',
//                                style: getFirstTextLine(),
//                              ),
//                              getDivider(),
//                              Align(
//                                child: Text(
//                                  'VIEW YOUR REVIEWS',
//                                  style: getsecondTextLine(),
//                                ),
//                                alignment: Alignment.topRight,
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
//                      Container(
//                        height: 10,
//                        color: Colors.grey[300],
//                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Questions & Answers',
                                style: getFirstTextLine(),
                              ),
                              getDivider(),
                              Align(
                                child: Text(
                                  'VIEW YOUR Q&A',
                                  style: getsecondTextLine(),
                                ),
                                alignment: Alignment.topRight,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 10,
                        color: Colors.grey[300],
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Addresses',
                                style: getFirstTextLine(),
                              ),
                              SizedBox(
                                height: 8,
                              ),
//                              Text('C-201, swasttic socity, varachha surat-302990', style: TextStyle(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.w400),),
                              getDivider(),
                              Align(
                                child: InkWell(
                                  child: Text(
                                    'VIEW 1 MORE',
                                    style: getsecondTextLine(),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        MyAddressListPage.routeName,
                                        arguments: new addressListArgument(
                                            IsSelectionEnable: false,
                                            selectedAddressid: ""));
                                  },
                                ),
                                alignment: Alignment.topRight,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: Column(
              children: [
//                Padding(
//                  padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
//                  child: Row(
//                    children: [
//                      Icon(
//                        Icons.settings,
//                        color: Colors.black54,
//                        size: 16,
//                      ),
//                      SizedBox(
//                        width: 10,
//                      ),
//                      Text(
//                        'Account Settings',
//                        style: TextStyle(
//                            fontSize: 15,
//                            color: Colors.black54,
//                            fontWeight: FontWeight.w400),
//                      )
//                    ],
//                  ),
//                ),
//                CommonWidget.customdivider(context, 1),
                InkWell(
                  child: Padding(
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.black54,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(15, 6, 15, 15),
                  ),
                  onTap: () {
                    logoutdialog(context);
                  },
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  TextStyle getFirstTextLine() {
    return TextStyle(
        fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w400);
  }

  TextStyle getsecondTextLine() {
    return TextStyle(
        fontSize: 13,
        color: Consts.app_primary_color,
        fontWeight: FontWeight.w400);
  }

  ImageProvider getProfileImage() {
    if (imagePath.isNotEmpty) {
      return new NetworkImage(imagePath);
    } else {
      return AssetImage("assets/images/person_placeholder.jpg");
    }
  }

  getDivider() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        12,
        0,
        12,
      ),
      child: CommonWidget.customdivider(context, 1),
    );
  }

  void logoutdialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(Consts.app_name),
          content: new Text('Are you sure you want to logout?'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new MaterialButton(
              child: new Text('CANCEL'),
              textColor: Colors.red[700],
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            new MaterialButton(
              child: new Text('SIGN OUT'),
              textColor: Colors.red[700],
              onPressed: () async {
                logout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    Consts.Is_user_login = false;
    Consts.api_authentication_token = '';
    Consts.current_username = '';
    Consts.current_phonenumber = '';
    Consts.current_userid = '';
    Consts.current_useremail = '';

    MyPreferenceManager _myPreferenceManager =
        await MyPreferenceManager.getInstance();
    _myPreferenceManager.clearData();

    Navigator.pop(context);
    Navigator.pop(context);

  }

  void goToProfileEditWithAwait() async {
    var result =
        await Navigator.of(context).pushNamed(ProfileEditPage.routeName);

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
//      getAddress();

      profileEditResponse = result;
    });
  }
}
