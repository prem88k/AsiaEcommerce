import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/Utils/Api_constant.dart';
import 'package:pocketuse/model/CommanModalWithObj.dart';
import 'package:pocketuse/model/Detail/ProductDetailResponse.dart';
import 'package:http/http.dart' as http;

Future<ProductDetailResponse> getProducatDetail(String id) async {

//  id = "32";
  var url = Uri.https(GlobalConfiguration().getString('url'),'/api/product/$id/details');
  print('url $url');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    String response_json_str = response.body;
    print(response_json_str + "..............");
    Map userMap = jsonDecode(response_json_str);
//      var data = userMap["data"];

    var CommanModal_obj = new CommanModalWithObj.fromJson(userMap) as CommanModalWithObj;
    if(CommanModal_obj.status) {
      Object resultList = CommanModal_obj.data;
      ProductDetailResponse productDetail = new ProductDetailResponse.fromJsonMap(resultList);
      return productDetail;

    } else{
      print("error "+CommanModal_obj.error.toString());
      return null;

//        Toast.show(Api_constant.something_went_wrong, context,
//            gravity: Toast.CENTER);
    }
  } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);
    print("error "+Api_constant.something_went_wrong);

    return null;
  }
}