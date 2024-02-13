import 'dart:convert';
import 'dart:core';
import 'dart:ffi';
import 'dart:io';

//import 'package:arabacustomer/Utils/Api_constant.dart';
//import 'package:arabacustomer/Utils/Utility.dart';
//import 'package:arabacustomer/model/AboutUsResponse.dart';
//import 'package:arabacustomer/model/CommanModal.dart';
//import 'package:arabacustomer/model/StatusMsgResponse.dart';
//import 'package:arabacustomer/model/Vehicle_category.dart';
//import 'package:arabacustomer/widgets/CommonWidget.dart';
//import 'package:arabacustomer/widgets/SubmitButton.dart';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/Utils/Api_constant.dart';
import 'package:pocketuse/Utils/MyColors.dart';
import 'package:pocketuse/Utils/MyPreferenceManager.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/model/CancelReasonListObj.dart';
import 'package:pocketuse/model/OrderDetail/OrderDetailResponse.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:pocketuse/widgets/SubmitButton.dart';
import 'package:pocketuse/widgets/image_picker_handler.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Utils/Consts.dart';

class CallbackOfCancelOrderDialog {
  void CancelOrderCallback() {}
}

class CancelOrderDialog extends StatefulWidget {
  OrderDetailResponse orderResponse;
  ImagePickerHandler imagePicker;
  CallbackOfCancelOrderDialog callbackOfCancelOrderDialog;

//  VehicleList();
  CancelOrderDialog(this.orderResponse,this.callbackOfCancelOrderDialog);


  @override
  CancelOrderDialogState createState() => CancelOrderDialogState();


}

class CancelOrderDialogState extends State<CancelOrderDialog> with TickerProviderStateMixin,ImagePickerListener  {
  bool IsProgressIndicatorShow = false;

  String aboutContent="";
   final TextEditingController descriptionController = TextEditingController();
  ImagePickerHandler imagePicker;

  File _image=null;

  AnimationController _controller;

  CancelReasonListObj selectedUser = null;
  List<CancelReasonListObj> users = List();


  @override
  userImage(File  _image) {
    this._image = _image;
    setState(() {
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCancelOrder();

    _controller = new AnimationController(
      duration: const Duration(milliseconds: 500), vsync: this,
    );
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    vehivlelist.add(VehicleCategory())
    return  new Scaffold(
        appBar: new AppBar(
          iconTheme: new IconThemeData(color: Colors.black),
          title:   Text("CANCEL ORDER", style: TextStyle(color: Colors.black87, fontSize: 13)),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: MyColors.veryLightPurple,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.90,
          child: Stack(
            children: [
              ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 18, 15, 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order Id: ', style: getTiteTextStyle(),),
                            SizedBox(height: 10,),
                            Text(widget.orderResponse.order_id.toString(), style: getTiteTextStyle(),),


                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 11, 10, 0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 18, 15, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
//                            Text(
//                              'Upload Product Images', style: getTiteTextStyle(),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Cancel Reason', style: getTiteTextStyle(),),
                              ],
                            ),

                            Center(
                              child:  DropdownButton<CancelReasonListObj>(
                                hint:  Text("Select Reason"),
                                value: selectedUser,
                                onChanged: (CancelReasonListObj Value) {
                                  setState(() {
                                    selectedUser = Value;
                                  });
                                },
                                items: users.map((CancelReasonListObj user) {
                                  return  DropdownMenuItem<CancelReasonListObj>(
                                    value: user,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Text(
                                          user.title,
                                          textAlign: TextAlign.start,
                                          style:  TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 18, 15, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Comment', style: getTiteTextStyle(),),
                            SizedBox(height: 10,),
                            Container(
                              decoration: const BoxDecoration(
                                  color: MyColors.lightGreyTwo,
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      10.0))
                              ),
                              child: TextFormField(
                                minLines: 4,
                                maxLines: 20,
                                keyboardType: TextInputType.multiline,
                                style: getContentTextStyle(),
                                controller: descriptionController,
                                textInputAction: TextInputAction.next,
                                cursorColor: MyColors.app_primary_color,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 13, bottom: 12, top: 12, right: 13),
                                    hintText: 'Enter Comment',
                                    hintStyle: getContentTextStyle()),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 11, 10, 0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 18, 15, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
//                            Text(
//                              'Upload Product Images', style: getTiteTextStyle(),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Attachment', style: getTiteTextStyle(),),
                              ],
                            ),

                            SizedBox(height: 10,),
                            InkWell(
                              child: Container(
                                height: 130,
                                decoration: const BoxDecoration(
                                    color: MyColors.lightGreyTwo,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))
                                ),
                                child: Center(
                                    child: getImage()
                                ),
                              ),
                              onTap: () {
                                imagePicker.showDialog(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child:  Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            if(selectedUser == null){
                              Fluttertoast.showToast(msg: "Please choose cancel reason", backgroundColor: Colors.black, textColor: Colors.white,);

                            } else{
                              CancelOrderSubmit();

                            }
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color:  Consts.orange_Button ,
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0))
                            ),
                            padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                            child: new Text('CANCEL ORDER', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500 ),
                                textAlign: TextAlign.center),
                          ),),
                      ),
                    ),
                  )
                ],
              ),
              Visibility(child: CircularLoadingWidget(
                  height: MediaQuery.of(context).size.height * 0.75),
              visible: IsProgressIndicatorShow,)
            ],
          ),
        ),
    );
  }

  getImage() {
    if( _image != null ){
//      return Image(image: FileImage(_imagesList[0]));
      return Image(image: FileImage(_image));
    }  else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonWidget.getIconImgeWithNHeightCustomSize(
              'assets/images/addImagePlaceHolder.png',
              51, 57),
          SizedBox(height: 6,),
          Text('Upload Images',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: MyColors
                    .boldTitleColorcharcoalGrey),),
        ],
      );
    }

  }
  TextStyle getTiteTextStyle() {
    return TextStyle(fontWeight: FontWeight.w600,
        fontSize: 14,
        color: MyColors.boldTitleColorcharcoalGrey);
  }

  getContentTextStyle() {
    return TextStyle(fontWeight: FontWeight.w600,
        fontSize: 12,
        color: MyColors.boldTitleColorcharcoalGrey);
  }

  Future<void> getCancelOrder() async {
    print('url ' + Consts.api_authentication_token);
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/order-cancel-reasons');


    print('url $url');

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader:
      'Bearer ' + Consts.api_authentication_token
    };

    setState(() {
      IsProgressIndicatorShow = true;
    });
    var response = await http.get(url, headers: requestHeaders);
    setState(() {
      IsProgressIndicatorShow = false;
    });
    print(response.body + "..............");

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

      if (userMap["status"]) {
        List<Object> resultList = userMap['data'];
        List<CancelReasonListObj> mycategoriesList = new List(resultList.length);

        for (int i = 0; i < resultList.length; i++) {
          Object obj = resultList[i];
          CancelReasonListObj g = new CancelReasonListObj.fromJsonMap(obj);
          mycategoriesList[i] = g;
        }
//        var orderListResponse_obj = new OrderDetailResponse.fromJsonMap(data) as OrderDetailResponse;
        setState(() {
          users = mycategoriesList;
        });

      } else {
        Fluttertoast.showToast(
          msg: Api_constant.something_went_wrong,
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
    }
  }


  Future<void> CancelOrderSubmit() async {

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader:
      'Bearer ' + Consts.api_authentication_token
    };

    setState(() {
      IsProgressIndicatorShow = true;
    });

     final String url = '${GlobalConfiguration().getString('base_url')}user/order/'+widget.orderResponse.order_id.toString()+'/cancel' ;

     setState(() {
      IsProgressIndicatorShow = false;
    });

     var request = new http.MultipartRequest(
        Api_constant.POST, Uri.parse(url));


    request.fields["reason_id"] = selectedUser.id.toString();
    request.fields["message"] = descriptionController.text.toString();

    request.headers.addAll(requestHeaders);

    if (_image != null) {
      final length = await _image.length();

      final file = await http.MultipartFile.fromPath("attachment", _image.path);
      request.files.add(file);
      /* request.files.add(
          new http.MultipartFile(Api_constant.profile_pic, _image.openRead(), length));*/
    }else{
      request.fields["attachment"] = '';
    }
    print(request.fields.toString()+"request..........");

    setState(() {
      IsProgressIndicatorShow = true;
    });


    http.Response response = await http.Response.fromStream(await request.send());

    //  var response = await http.post(edit_profile_customer_api, body: map);
    print(response.statusCode.toString() +"statusCode..............");
    print(response.body.toString() +"response..............");
    setState(() {
      IsProgressIndicatorShow = false;
    });

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str +"..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];
//      var profileResponseObj = new ProfileResponse.fromJsonMap(data) as ProfileResponse;

//      var response_code = userMap["response_code"];
       var status = userMap["status"];

//      Toast.show(Api_constant.profile_update, context, gravity: Toast.CENTER);

      if(status ) {
        Fluttertoast.showToast(
          msg: 'Order cancel successfully',
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        widget.callbackOfCancelOrderDialog.CancelOrderCallback();
        Navigator.pop(context);

      } else{
        var error = userMap["error"];
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
        Navigator.pop(context);
      }

    }  else if (response.statusCode == Api_constant.unauthenticated_Error_Code ){
      CommonWidget.handleUnError(context, response.body);

    } else {
      String response_json_str = response.body;
      Map userMap = jsonDecode(response_json_str);

      if(userMap.containsKey("message")){
        var response_code = userMap["message"];
        Fluttertoast.showToast(msg: response_code, backgroundColor: Colors.black, textColor: Colors.white,);
       }
      throw Exception('Failed to load internet');
    }
  }

}