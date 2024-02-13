import 'dart:convert';
import 'package:pocketuse/helpers/helper.dart';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/model/CategorieWiseProductPackage/HomePageCategoriWiseProducts.dart';

Future<Stream<HomePageCategoriWiseProducts>> gethome_page_categories() async {
//  http://18.191.233.163/api/front/home_page_categories/
  final String url = '${GlobalConfiguration().getString('api_base_url')}home_page_categories/';
  print('url $url');
  final client = new http.Client();

  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => HomePageCategoriWiseProducts.fromJsonMap(data));
}

