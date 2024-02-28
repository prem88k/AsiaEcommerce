import 'dart:convert';
import 'package:pocketuse/helpers/helper.dart';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/model/SubCategory.dart';

Future<Stream<SubCategory>> getSubCategories(String id) async {
 // final String url = '${GlobalConfiguration().getString('base_url')}$id/subcategory_list';
  var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/$id/subcategory_list');

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', url));
  print('subcategory_list url $url');

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => SubCategory.fromJsonMap(data));
}
