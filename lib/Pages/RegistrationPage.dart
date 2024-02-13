import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/Pages/LoginPage.dart';
import 'package:pocketuse/Utils/Api_constant.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:http/http.dart' as http;

import 'OtpVerificationPage.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = '/RegistrationPage';

  RouteArgument routeArgument;

  RegistrationPage({Key key, this.routeArgument}) : super(key: key);

  @override
  RegistrationPageState createState() {
    return RegistrationPageState();
  }
}

class RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  bool IsProgressIndicatorShow = false;
  bool SendOtpEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Consts.app_primary_color,
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(LoginPage.routeName,arguments: new RouteArgument(id: widget.routeArgument.id ));
//                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
                Expanded(
                  child: Text(
                    Consts.app_name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  flex: 1,
                ),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400].withOpacity(0.6),
                      spreadRadius: 0.5,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: IsProgressIndicatorShow ?
                CircularLoadingWidget(height: MediaQuery.of(context).size.width * 0.7) : ListView(
//                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 35, 20, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Looks like you're new here!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Experience the all new " + Consts.app_name + "!",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13)),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText: "Fullname",
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 1, 10, 1),
                              labelStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 14),
                            ),
                            controller: fullnameController,
                            onChanged: (val) {
                              if(phonenumberController.text.length == 10 && val.isNotEmpty){
                                setState(() {
                                  SendOtpEnable = true;
                                });
                              } else{
                                setState(() {
                                  SendOtpEnable = false;
                                });
                              }
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              hintText: "",
                              prefix: Container(
                                width: 62,
                                child: Row(
                                  children: [
                                    Text(
                                      '+91',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 1, 10, 1),
                              labelStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 14),
                            ),
                            controller: phonenumberController,
                            onChanged: (val) {
                              if(val.length == 10 && fullnameController.text.toString().isNotEmpty){
                                setState(() {
                                  SendOtpEnable = true;
                                });
                              } else{
                                setState(() {
                                  SendOtpEnable = false;
                                });
                              }
                            },
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Text(
                                'Existing User? Login',
                                style: TextStyle(
                                    color: Consts.app_primary_color,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              onTap: (){
                                Navigator.of(context).pushReplacementNamed(LoginPage.routeName, arguments: new RouteArgument(id: widget.routeArgument.id ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 10),
                      child: CommonWidget.customdividerwithCustomColor(context, 1, Colors.grey[400]),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child:  Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              if(SendOtpEnable){
                                RegistrationApicall();
                              }
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: SendOtpEnable ? Consts.orange_Button  : Colors.grey[400],
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))
                              ),
                              padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                              child: new Text('Send OTP', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400 ),
                                  textAlign: TextAlign.center),
                            ),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
  String addCountryCode(String phone) {
    if(phone != null && phone.isNotEmpty && phone.startsWith('+91')){
      return phone.replaceFirst('+91', '');
    } else if(phone != null && phone.isNotEmpty &&  phone.startsWith('91')){
      return phone.replaceFirst('91', '');
    } else{
      return phone;
    }
  }
  Future<void> RegistrationApicall() async {
    if(phonenumberController.text.isEmpty){
      Fluttertoast.showToast(
        msg: 'Please enter phone number',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    if(fullnameController.text.isEmpty){
      Fluttertoast.showToast(
        msg: 'Please enter name',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    var map = new Map<String, dynamic>();
    map['phone'] = addCountryCode(phonenumberController.text.trim());
    map['fullname'] = fullnameController.text.trim();

    print(map.toString() + "send otp..............");
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/registration');
    print(url);

    setState(() {
      IsProgressIndicatorShow = true;
    });

    var response = await http.post(url, body: map);
    setState(() {
      IsProgressIndicatorShow = false;
    });

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      var status = userMap["status"];
      var data = userMap["data"];

      if (status) {
        Fluttertoast.showToast(
          msg: data['message'],
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        Navigator.of(context).pushNamed(OtpVerificationPage.routeName,
            arguments: new RouteArgument(id: phonenumberController.text.toString(), heroTag: fullnameController.text.trim(), param:   widget.routeArgument.id ));
      } else {
        Fluttertoast.showToast(
          msg: 'status false',
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

      }
    } else {
      Fluttertoast.showToast(
        msg: Api_constant.something_went_wrong,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      throw Exception('Failed to load internet');
    }
  }
}
