import 'dart:convert';
import 'dart:io';


//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/Utils/Api_constant.dart';
import 'package:pocketuse/model/RatingResponse.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import '../Utils/Consts.dart';

class CallbackOfRatinngdDialog {
  void ratingComplete(RatingResponse ratingResponse) {}
}

class RatingDialog extends StatefulWidget {

  RatingDialog(this.product_id, this.review_text_by_customer,this.rating_by_customer, this.callbackOfratingdDialog);
//  EnjoyServiceRatingDialog(this.callbackOfForgotPasswordDialog);
  CallbackOfRatinngdDialog callbackOfratingdDialog;

  String product_id;
  String review_text_by_customer;
  double rating_by_customer ;

  @override
  RatingDialogState createState() => RatingDialogState();
}

class RatingDialogState extends State<RatingDialog> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Wrap(
        children: <Widget>[
          Container(
//            height: 450,
//        decoration: new BoxDecoration(
//          image: new DecorationImage(
//            image: new AssetImage('assets/images/login_background.png'),
//            fit: BoxFit.cover,
//
//          ),
//        ),
            child: Column(
              children: <Widget>[
//                Align(
//                  alignment: Alignment.topRight,
//                  child: Image.asset('assets/images/forgot_password_bg.png'),
//                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Review Product",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600),
                                  ),
//                                  TextSpan(
//                                    text: "Tap a star to rate it on.",
//                                    style: TextStyle(
//                                        color: Colors.black,
//                                        fontSize: 18,
//                                        height: 1.2,
//                                        fontWeight: FontWeight.w400),
//                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            RatingBar(
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              unratedColor: Colors.green.withAlpha(50),
                              itemCount: 5,
                              itemSize: 28.0,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                         /*     itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.green,
                              ),
*/
                              initialRating: widget.rating_by_customer,
                              minRating: 0,
                              onRatingUpdate: (rating) {
                                setState(() {
                                  widget.rating_by_customer = rating;

                                });
                              },),
                          ],

                        ),),
                      Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
                      child:   TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (val) {
                          widget.review_text_by_customer = val;
                        },
                      ),),

//                      CommonWidget.divider(),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                          child: Text("SUBMIT",
                              style: TextStyle(color: Colors.red[900],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                        ),
                        onTap: () {
                          if(widget.review_text_by_customer.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "The comment field is required.",),
                              ),
                            );
                           /// Toast.show("The comment field is required.", , gravity: Toast.CENTER);

                          } else{
                            ratingAPiCall();
                          }
                        },
                      )

//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          InkWell(
//                            child: Padding(
//                              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
//                              child: Text("CANCEL",
//                                style: TextStyle(color: Colors.grey[400],
//                                    fontWeight: FontWeight.w600,
//                                    fontSize: 20),
//                              ),
//                            ),
//                            onTap: () {
//                              Navigator.pop(context);
//                            },
//                          ),
////                          VerticalDivider(color: Colors.red, width: 20),
//                          Container(
//                            color: Colors.grey[400],
//                            width: 0.8,
//                            height: 65,
//                            //height: -> setting to maximum of its parent
//                          ),
//                          InkWell(
//                            child: Padding(
//                              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
//                              child: Text("SUBMIT",
//                                  style: TextStyle(color: Colors.red[900],
//                                      fontWeight: FontWeight.w600,
//                                      fontSize: 20)),
//                            ),
//                            onTap: () {
//                              ratingAPiCall();
//                            },
//                          )
//
//                        ],
//                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> ratingAPiCall() async {

    final msg = jsonEncode({"user_id":Consts.current_userid,
      "product_id":  widget.product_id.toString(),
      "rating": widget.rating_by_customer.toString(),
      "comment":widget.review_text_by_customer});
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/reviewsubmit');

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader:
      'Bearer ' + Consts.api_authentication_token,
      'Content-Type': 'application/json'
    };

    var response = await http.post(url, body: msg, headers: requestHeaders);

     print(   "..............");
     print(url.toString() + "..............");
     print(msg);
     print(response.statusCode.toString() + "..............");
     print(response.body.toString() + "..............");

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

      if(userMap.containsKey("status") && userMap["status"]){
        var ratingResponse = new RatingResponse.fromJsonMap(userMap["data"]) as RatingResponse;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "successfully rating submit"),
          ),
        );
       // Toast.show("successfully rating submit", context, gravity: Toast.CENTER);
        widget.callbackOfratingdDialog.ratingComplete(ratingResponse);
        Navigator.pop(context);

      } else{
        if(userMap.containsKey("error") ){
//          String error = userMap["error"];
          Map erroruserMap =  userMap["error"];
          if(erroruserMap.containsKey("message")){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    erroruserMap["message"]),
              ),
            );
          //  Toast.show(erroruserMap["message"], context, gravity: Toast.CENTER);
          }
        }
        Navigator.pop(context);
      }
    }
  }
}