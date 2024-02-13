import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/Utils/MyPreferenceManager.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/model/ProfileEditResponse.dart';

class ProfileEditPage extends StatefulWidget {
  static const routeName = '/ProfileEditPage';

  @override
  ProfileEditPageState createState() {
    return ProfileEditPageState();
  }
}

class ProfileEditPageState extends State<ProfileEditPage> {
  String imagePath = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool VerifyBtnEnable = false;

  bool IsProgressIndicatorEnable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text =Consts.current_username;
    emailController.text =Consts.current_useremail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IsProgressIndicatorEnable ?
      CircularLoadingWidget(height: MediaQuery.of(context).size.width * 0.90) :
      ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Consts.app_primary_color,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
//                      Padding(
//                        padding: EdgeInsets.fromLTRB(15, 0, 15  , 0),
//                        child: Text(
//                          'or',
//                          style: TextStyle(
//                            color: Colors.white,
//                          ),
//                        ),
//                      ),
//                      Align(
//                        alignment: Alignment.topCenter,
//                        child: Container(
//                            width: 65.0,
//                            height: 65.0,
//                            decoration: new BoxDecoration(
//                                shape: BoxShape.circle,
//                                image: new DecorationImage(
//                                  fit: BoxFit.fill,
//                                  // image: AssetImage('assets/images/splash.png'),
//                                  image: getProfileImage(),
//                                ))),
//                      ),
                    ],
                  ),
                ),
                InkWell(
                  child: Padding(padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                    child: Icon(Icons.arrow_back, color: Colors.white,size: 18, ),),
                  onTap: (){
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),

          Padding(padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: "Fullname",
              contentPadding:
              EdgeInsets.fromLTRB(10.0, 1, 10, 1),
              labelStyle: TextStyle(
                  color: Colors.grey[500], fontSize: 14),
            ),
            controller: nameController,
          ),),

          Padding(padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: "Email",
              contentPadding:
              EdgeInsets.fromLTRB(10.0, 1, 10, 1),
              labelStyle: TextStyle(
                  color: Colors.grey[500], fontSize: 14),
            ),
            controller: emailController,
          ),),

//          Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
//          child: InkWell(
//            child: Center(
//              child: Text('SUBMIT', style:  TextStyle(color: Consts.app_primary_color, fontWeight: FontWeight.w600, fontSize: 16),),
//            ),
//            onTap: (){
//              if(nameController.text.isEmpty){
//                Fluttertoast.showToast(msg: 'Please enter name', backgroundColor: Colors.black, textColor: Colors.white,);
//
//              } else if(emailController.text.isEmpty){
//                Fluttertoast.showToast(msg: 'Please enter email', backgroundColor: Colors.black, textColor: Colors.white,);
//
//              } else{
//                editProfileAPiCall();
//
//              }
//            },
//          ))
          Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child:  Center(
              child: SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    if(nameController.text.isEmpty){
                      Fluttertoast.showToast(msg: 'Please enter name', backgroundColor: Colors.black, textColor: Colors.white,);

                    } else if(emailController.text.isEmpty){
                      Fluttertoast.showToast(msg: 'Please enter email', backgroundColor: Colors.black, textColor: Colors.white,);

                    } else{
                      editProfileAPiCall();

                    }
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color:  Consts.orange_Button  ,
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0))
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                    child: new Text('SUBMIT', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400 ),
                        textAlign: TextAlign.center),
                  ),),
              ),
            ),
          )
        ],
      ),
    );
  }

  ImageProvider getProfileImage() {
    if (imagePath.isNotEmpty) {
      return new NetworkImage(imagePath);
    } else {
      return AssetImage("assets/images/person_placeholder.jpg");
    }
  }

  Future<void> editProfileAPiCall() async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/profile/update');
    print('url $url');
    print('api_authentication_token== '+Consts.api_authentication_token);

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer '+ Consts.api_authentication_token
    };

    var map = new Map<String, dynamic>();
    map['name'] = nameController.text.toString() ;
    map['email'] =  emailController.text.toString()  ;

    setState(() {
      IsProgressIndicatorEnable = true;
    });

    var response = await http.post(url, headers: requestHeaders, body: map);

    setState(() {
      IsProgressIndicatorEnable = false;
    });

    print('statusCode== '+response.statusCode.toString());

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap["status"]) {
         var data =  userMap["data"];
         var CommanModal_obj = new ProfileEditResponse.fromJsonMap(data) as ProfileEditResponse;

         MyPreferenceManager _myPreferenceManager = await MyPreferenceManager.getInstance();

         _myPreferenceManager.setString(MyPreferenceManager.LOGIN_USER_NAME, CommanModal_obj.full_name.toString());
         Consts.current_username = _myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_NAME);

         _myPreferenceManager.setString(MyPreferenceManager.LOGIN_USER_EMAIL, CommanModal_obj.email.toString());
         Consts.current_useremail = _myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_EMAIL);

         Navigator.pop(context, CommanModal_obj);

      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
//        setState(() {
//          addressList = <AddressListObj>[];
//        });
      }
    } else {
//      setState(() {
//        addressList = <AddressListObj>[];
//      });
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);
    }
  }
}
