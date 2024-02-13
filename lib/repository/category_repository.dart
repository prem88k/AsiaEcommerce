import 'dart:convert';
import 'package:pocketuse/helpers/helper.dart';
import 'package:pocketuse/model/CategoryModel.dart';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/model/CommanModal.dart';

Future<Stream<CategoryModel>> getCategories() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}category_list';
  print('url $url');
  final client = new http.Client();

  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => CategoryModel.fromJsonMap(data));
}

Future<List<CategoryModel>> getCategories2() async {
  var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/category_list');
  print('url $url');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    String response_json_str = response.body;
    print(response_json_str + "..............");
    Map userMap = jsonDecode(response_json_str);
    var data = userMap["data"];

    var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
    if(CommanModal_obj.status ==1) {
      List<Object> resultList = data;

      List<CategoryModel> myContributionList = new List(resultList.length);

      for (int i = 0; i < resultList.length; i++) {
        Object obj = resultList[i];
        CategoryModel g = new CategoryModel.fromJsonMap(obj);
        myContributionList[i] = g;
      }

      return myContributionList;
    } else{
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);

      return new List<CategoryModel>();
    }
  } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);

    return new List<CategoryModel>();
  }
}

//Future<Stream<Category>> getCategory(String id) async {
//  final String url = '${GlobalConfiguration().getString('api_base_url')}categories/$id';
//
//  final client = new http.Client();
//  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
//
//  return streamedRest.stream
//      .transform(utf8.decoder)
//      .transform(json.decoder)
//      .map((data) => Helper.getData(data))
//      .map((data) => Category.fromJSON(data));
//}
