import 'dart:convert';
import 'package:pocketuse/Utils/Api_constant.dart';
import 'package:pocketuse/helpers/helper.dart';
import 'package:pocketuse/model/CategoryModel.dart';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/model/CommanModal.dart';
import 'package:pocketuse/model/FeaturedBanner.dart';
import 'package:pocketuse/model/SliderObj.dart';
import 'package:toast/toast.dart';

Future<Stream<FeaturedBanner>> getfeatured_banners() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}featured-banners';
  print('url $url');
  final client = new http.Client();

  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => FeaturedBanner.fromJsonMap(data));
}

