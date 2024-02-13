import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/Utils/Api_constant.dart';
import 'package:pocketuse/controllers/home_controller.dart';
 import 'package:http/http.dart' as http;
import 'package:pocketuse/model/CategorieWiseProductPackage/HomePageCategoriWiseProducts.dart';
import 'package:pocketuse/model/CommanModal.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';


class HomePageCategorieWiseProductList extends StatefulWidget {
  @override
  HomePageCategorieWiseProductListState createState() {
    return HomePageCategorieWiseProductListState();
  }
}

class HomePageCategorieWiseProductListState
    extends StateMVC<HomePageCategorieWiseProductList> {
  List<HomePageCategoriWiseProducts> _homeCategorieWiseProduct = <HomePageCategoriWiseProducts>[];

  HomeController _con;
  bool _isDataLoaded = false;

//  HomePageCategorieWiseProductListState() : super(HomeController()) {
//    _con = controller;
//  }

  @override
  void initState() {
    super.initState();
    getCategoryProductList();
//    _con.listenForCategorieWiseProducts();
  }
  int _current = 0;

  @override
  Widget build(BuildContext context) {
   return _isDataLoaded ? new Container(
        child: new ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Wrap(
                direction: Axis.vertical,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(_homeCategorieWiseProduct[index].name, style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600)),),
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                            height: 140,
                            width: MediaQuery.of(context).size.width,
                            child: CarouselSlider(
                              options: CarouselOptions(autoPlay: true,
//                    height : 200,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  }
                              ),
                              items: _homeCategorieWiseProduct[index].products.map((item) => Container(
                                child: Center(
                                    child: Image.network(item.thumbnail, fit: BoxFit.cover,
                                      height: 140,
                                      width: MediaQuery.of(context).size.width,
                                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return CommonWidget.getloadingBulder(loadingProgress);
                                      },
                                    )
                                ),
                              )).toList(),
                            )
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _homeCategorieWiseProduct[index].products.map((url) {
                            int iindex = _homeCategorieWiseProduct[index].products.indexOf(url);
                            return Container(
                              width: 6.0,
                              height: 6.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == iindex
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),)
                    ],
                  )
                ]);
          },
          itemCount: _homeCategorieWiseProduct.length,
        )) :  CircularProgressIndicator();

//    return FutureBuilder<List<HomeCategorieWiseProduct>>(
//      future: getCategoryProductList(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData)
//          return Center(child:);
//
//        return ;
//      },
//    );


//
  }

  Future<List<HomePageCategoriWiseProducts>> getCategoryProductList() async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/home_page_categories/');
    print('url getCategoryProductList $url');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print('getCategoryProductList response ' + response_json_str +
          "..............");
      Map userMapp = jsonDecode(response_json_str);
      var _data = userMapp["data"];

      var CommanModal_obj = new CommanModal.fromJsonMap(
          userMapp) as CommanModal;
      if (CommanModal_obj.status) {
        try {
          List<Object> _resultList = _data;
          List<HomePageCategoriWiseProducts> homeCategoryWiseProductList = new List(_resultList.length);

          for (int i = 0; i < _resultList.length; i++) {
            Object obj = _resultList[i];
            HomePageCategoriWiseProducts g = new HomePageCategoriWiseProducts
                .fromJsonMap(obj);
            homeCategoryWiseProductList[i] = g;
          }
          print('homeCategoryWiseProductList response ' +
              homeCategoryWiseProductList.length.toString() + "..............");

          _homeCategorieWiseProduct.addAll(homeCategoryWiseProductList);

          setState(() {
            _isDataLoaded = true;
          });
        } catch (e) {
          print(e + "eroorrrrrrr");
          return null;
        }
      } else {
        print("error " + CommanModal_obj.error.toString());
        return null;

//        Toast.show(Api_constant.something_went_wrong, context,
//            gravity: Toast.CENTER);
      }
    } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);
      print("error " + Api_constant.something_went_wrong);

      return null;
    }
  }

}