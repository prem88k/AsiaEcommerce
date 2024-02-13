import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pocketuse/Utils/Api_constant.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/Utils/MyPreferenceManager.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/model/VerifyOtpResonse.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:http/http.dart' as http;

import 'MyAccountPage.dart';

class  EditableTextFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    // prevents keyboard from showing on first focus
    return true;
  }
}

class OtpVerificationPage extends StatefulWidget {
  static const routeName = '/OtpVerificationPage';

  RouteArgument routeArgument;

  OtpVerificationPage({Key key, this.routeArgument}) : super(key: key);

  @override
  OtpVerificationPageState createState() {
    return OtpVerificationPageState();
  }
}

class OtpVerificationPageState extends State<OtpVerificationPage> {
//  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();

  String otp_text = '';
  bool IsProgressIndicatorShow = false;
  int _start = 30;
  bool IsResendTimerShow = false;
  bool VerifyBtnEnable = false;
  final TextEditingController fullnameController = TextEditingController();
  Timer _timer;

  @override
  void initState() {
    super.initState();
      startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer=   new Timer.periodic(oneSec,
          (Timer timer) => setState(() {
        if (_start < 1) {
          timer.cancel();
          setState(() {
            IsResendTimerShow =  true;
          });
        } else {
          _start = _start - 1;
        }
      },
      ),
    );
  }

  @override
  void dispose() {
    if(_timer != null ){
      _start = 0;
      _timer.cancel();
    }
    super.dispose();
  }
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
                      Navigator.pop(context);
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
                child: IsProgressIndicatorShow
                    ?  CircularLoadingWidget(height: MediaQuery.of(context).size.height * 0.50) : ListView(
//                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Visibility(child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
                            child: TextField(
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
                                if(otp_text.length == 6 && val.isNotEmpty){
                                  setState(() {
                                    VerifyBtnEnable = true;
                                  });
                                } else{
                                  setState(() {
                                    VerifyBtnEnable = false;
                                  });
                                }
                              },
                            ),
                          ),
                          visible: widget.routeArgument.heroTag != '1',),

                          Text("Please enter OTP we've send you on +"+widget.routeArgument.id.toString(),
//                          Text("Please enter OTP we've send you on +"+widget.routeArgument.id.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17)),

                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            child: PinCodeTextField(
                              length: 6,
                              autoFocus : true,
                              focusNode: EditableTextFocusNode(),
                              showCursor: true,
                              obscureText: false,
                              animationType: AnimationType.fade,
                              animationDuration: Duration(milliseconds: 300),
//                              errorAnimationController: errorController, // Pass it here
                              onChanged: (value) {
                                otp_text = value;

                                setState(() {
                                  if(value.length ==6){
                                    VerifyBtnEnable = true;
                                  } else{
                                    VerifyBtnEnable = false;
                                  }
                                });
                              },
                              appContext: context,
                              keyboardType : TextInputType.number,
                            ),
                            width: MediaQuery.of(context).size.width * 0.80,

                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IsResendTimerShow ? InkWell(
                              onTap: (){
                                LoginApicall();
                              },
                              child: Text("Resend OTP",
                                style: TextStyle(color: Consts.app_primary_color, fontWeight: FontWeight.w400, fontSize: 15),
                              ),
                            ) : Text("00:"+_start.toString(),
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 15),),
                          )
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
                              if(VerifyBtnEnable){
                                VerifyOtpApicall();
                              }
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: VerifyBtnEnable ? Consts.orange_Button  : Colors.grey[400],
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))
                              ),
                              padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                              child: new Text('Verify'
                                  , style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400 ),
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

  Future<void> VerifyOtpApicall() async {

    if(widget.routeArgument.heroTag != '1'){
      if(fullnameController.text.isEmpty){
        Fluttertoast.showToast(
          msg: 'Please enter Full name',
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return;
      }
    }

    if(otp_text.isEmpty){
      Fluttertoast.showToast(
        msg: 'Please enter Otp',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }


    var map = new Map<String, dynamic>();
    map['phone'] = widget.routeArgument.id;
    map['fullname'] = fullnameController.text.toString();
    map['otp'] = otp_text.trim();

    print(map.toString() + "send otp..............");
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/verify_otp');
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

        var loginResponseObj = new VerifyOtpResonse.fromJsonMap(data) as VerifyOtpResonse;
        print(loginResponseObj.token.toString() + " .......token.......");

        MyPreferenceManager _myPreferenceManager = await MyPreferenceManager.getInstance();

        _myPreferenceManager.setBool(MyPreferenceManager.IS_USER_LOGIN, true);
        _myPreferenceManager.setString(MyPreferenceManager.LOGIN_USER_TOKEN, loginResponseObj.token.toString());
        _myPreferenceManager.setString(MyPreferenceManager.LOGIN_USER_NAME, loginResponseObj.user.full_name.toString());
        _myPreferenceManager.setString(MyPreferenceManager.LOGIN_USER_ID, loginResponseObj.user.id.toString());
        _myPreferenceManager.setString(MyPreferenceManager.LOGIN_USER_PHONE_NUBER, loginResponseObj.user.phone.toString());
        _myPreferenceManager.setString(MyPreferenceManager.LOGIN_USER_EMAIL, loginResponseObj.user.email.toString());

        Consts.Is_user_login = _myPreferenceManager.getBool(MyPreferenceManager.IS_USER_LOGIN);
        Consts.api_authentication_token = _myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_TOKEN);
        Consts.current_username = _myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_NAME);
        Consts.current_phonenumber = _myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_PHONE_NUBER);
        Consts.current_userid =_myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_ID);
        Consts.current_useremail = _myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_EMAIL);

        print(Consts.Is_user_login .toString() + " .......Is_user_login.......");
        print(Consts.api_authentication_token + " .......api_authentication_token.......");
        print( Consts.current_username  + " .......current_username.......");
        print(Consts.current_phonenumber + " .......current_phonenumber.......");
        print(Consts.current_userid + " .......current_userid.......");



        if(widget.routeArgument.param != null && widget.routeArgument.param.toString().isNotEmpty){
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(widget.routeArgument.param.toString());
        } else{
          Navigator.pop(context);
          Navigator.pop(context);
        }


      } else {
        otp_text ="";
        VerifyBtnEnable = false;
        _start = 0;

        if(userMap.containsKey('error')){
          Map error = userMap["error"];
          if(error.containsKey('message')){
            Fluttertoast.showToast(
              msg: error['message'],
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );

          } else{
            Fluttertoast.showToast(
              msg: 'Something went wrong',
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
          }
        }
      }
    } else {

      otp_text ="";
      VerifyBtnEnable = false;
      _start = 0;

      Fluttertoast.showToast(
        msg: Api_constant.something_went_wrong,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      throw Exception('Failed to load internet');
    }
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
  Future<void> LoginApicall() async {

    var map = new Map<String, dynamic>();
    map['phone'] = addCountryCode( widget.routeArgument.id.trim());

    print(map.toString() + "send otp..............");
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/login');

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

        //
        _start = 60;
        setState(() {
          IsResendTimerShow = false;
        });
        startTimer();

//        VerifyOtpResonse

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
