import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:like_button/like_button.dart';
import 'package:pocketuse/Pages/LoginPage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/model/route_argument.dart';

class FavouriteCallBack{
   onfavouriteCallback(String id, bool Isfav ){}
}

class FavouriteWidget extends StatefulWidget{
  String id;
  int in_wishlist;
  FavouriteCallBack favouriteCallBack;

  FavouriteWidget(this.id, this.in_wishlist, this.favouriteCallBack);

  @override
  FavouriteWidgetState createState() {
    return FavouriteWidgetState();
  }
}

class FavouriteWidgetState extends State<FavouriteWidget>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
//      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(left: 3, top: 2, right: 0, bottom: 0),
          margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(0.6),
                spreadRadius: 0.5,
                blurRadius: 1,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: LikeButton(
              onTap: onLikeButtonTapped,
              isLiked : (widget.in_wishlist == null || widget.in_wishlist == 0) ? false : true,
              size: 20,
            ),
          )
//          child: Icon(Icons.favorite,color: Colors.grey[400],size: 20,),
        ),
//        onTap: (){
//
////          if (widget.in_wishlist == null || widget.in_wishlist == 0){
////            print('favApiCAll '+Consts.api_authentication_token);
////            favApiCAll();
////
////          } else{
////            print('unfavApiCAll '+Consts.api_authentication_token);
////            unfavApiCAll();
////          }
//
//        },
//      ),
    );
  }
  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

   if(Consts.Is_user_login){
     if(isLiked){
       print('unfavApiCAll '+Consts.api_authentication_token);
       unfavApiCAll();

     }else{
       print('favApiCAll '+Consts.api_authentication_token);
       favApiCAll();

     }
     return !isLiked;

   } else{
     Navigator.of(context).pushNamed(LoginPage.routeName, arguments: new RouteArgument(id: ""));
     return isLiked;

   }
  }
  Future<void> favApiCAll() async {
    widget.favouriteCallBack.onfavouriteCallback(widget.id , true);

    print('url '+Consts.api_authentication_token);
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/wishlist/add');
    print('url $url');

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer '+ Consts.api_authentication_token
    };
    var map = new Map<String, dynamic>();
    map['product_id'] = widget.id ;

    var response = await http.post(url, headers: requestHeaders, body: map );
    print(response.body + "..............");

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap["status"]) {

        Fluttertoast.showToast(
          msg: 'Add To Wishlist Successfully',
          backgroundColor: Colors.black,
          textColor: Colors.white,);

        setState(() {
          widget.in_wishlist =1;
        });

//        List<Object> resultList = data['data'];
//
//        List<Product> mycategoriesList = new List(resultList.length);
//
//        for (int i = 0; i < resultList.length; i++) {
//          Object obj = resultList[i];
//          Product g = new Product.fromJsonMap(obj);
//          mycategoriesList[i] = g;
//        }
//
//        setState(() {
//          Products = mycategoriesList;
//        });
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
      }
    } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);

    }
  }

  Future<void> unfavApiCAll() async {
    widget.favouriteCallBack.onfavouriteCallback(widget.id , false);

    print('url '+Consts.api_authentication_token);
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/wishlist/remove/'+widget.id);

//    final String url = '${GlobalConfiguration().getString('base_url')}user/wishlist/delete/'+widget.id;
    print('url $url');

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer '+ Consts.api_authentication_token
    };

    var response = await http.get(url, headers: requestHeaders);
    print(response.body + "..............");

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap["status"]) {

        Fluttertoast.showToast(
          msg: 'Item Remove From Wishlist.',
          backgroundColor: Colors.black,
          textColor: Colors.white,);

        setState(() {
          widget.in_wishlist =0;
        });
//        List<Object> resultList = data['data'];
//
//        List<Product> mycategoriesList = new List(resultList.length);
//
//        for (int i = 0; i < resultList.length; i++) {
//          Object obj = resultList[i];
//          Product g = new Product.fromJsonMap(obj);
//          mycategoriesList[i] = g;
//        }
//
//        setState(() {
//          Products = mycategoriesList;
//        });
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
      }
    } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);

    }
  }

}