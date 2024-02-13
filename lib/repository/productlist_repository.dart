import 'dart:convert';
import 'package:pocketuse/helpers/helper.dart';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/model/ProductList/Product.dart';

Future<Stream<Product>> getProducts(String highlight, String limit, String type, String product_type, String paginate) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}products?highlight'
      '=$highlight&limit=$limit&type=$type&product_type=$product_type&paginate=$paginate';

  print('url $url');
  final client = new http.Client();

  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => Product.fromJsonMap(data));
}
