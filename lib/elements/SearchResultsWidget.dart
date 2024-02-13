import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/Pages/AllProductsPage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/model/ProductListArgument.dart';
import 'package:pocketuse/model/Productlist_route_argument.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/widgets/CommonWidget.dart';

import '../SearchSuggetionListObj.dart';
import 'CircularLoadingWidget.dart';

class SearchResultWidget extends StatefulWidget {
  String heroTag;
  List<CategoryModel> categories = [];

  SearchResultWidget({Key key, this.heroTag, this.categories}) : super(key: key);

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends StateMVC<SearchResultWidget> {
//  SearchController _con;
//
//  _SearchResultWidgetState() : super(SearchController()) {
//    _con = controller;
//  }

  String searchtxt = "";
  bool EnableApiCall = true;

  List<SearchSuggetionListObj> products = <SearchSuggetionListObj>[];

  @override
  void initState() {
    super.initState();
    getSearchList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,

      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
//            child: ListTile(
//              dense: true,
//              contentPadding: EdgeInsets.symmetric(vertical: 0),
//              trailing: IconButton(
//                icon: Icon(Icons.close),
//                color: Theme.of(context).hintColor,
//                onPressed: () {
//                  Navigator.pop(context);
//                },
//              ),
//              title: Text(
//                'search',
//                style: Theme.of(context).textTheme.display1,
//              ),
//              subtitle: Text(
//                'Search for products, brands and more..',
//                style: Theme.of(context).textTheme.caption,
//              ),
//            ),
//          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: TextField(
              textInputAction: TextInputAction.search,
              onChanged: (text) {
                searchtxt = text.replaceAll(" ", "%20");

                getSearchList();
//                _con.refreshSearch(text);
              },
              onSubmitted: (text) {
                getSearchList();
//                _con.saveSearch(text);
              },
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: 'Search for products, brands and more..',
                hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
                border:
                    OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
              ),
            ),
          ),
          products.length == 0 ?   Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey[300],
                  height: 8,
                ),

                Padding(padding: EdgeInsets.fromLTRB(20, 15, 0, 6),
                child: Text('Discover More',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey[700]),),)
              ],
            ),
          ) :Container(),
          products.length == 0 ?  Center(
            child: Wrap(
                spacing: 8.0, // gap between adjacent chips
                runSpacing: 8.0, // gap between lines
                children: List.generate(widget.categories.length, (index) {
                  return InkWell(
                    onTap: (){

                      Navigator.of(context).pushNamed(AllProductsPage.routeName,
                          arguments: new ProductListArgument(title : widget.categories.elementAt(index).name ,
                              productlist_route_argument: new Productlist_route_argument(
                                  user_id: Consts.current_userid, term: '',
                                  sort: '',
                                  category: widget.categories.elementAt(index).id,
                                  subcategory: 0,
                                  childcategory: 0,
                                  page: 0,
                                  paginate: 0)));
                    },
                    child: Container(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        decoration: BoxDecoration(
                          color: Colors.white ,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: new Border.all(
                            color: Colors.grey[200],
                            width: 1,
                          ),
                        ),child: Text(
                      widget.categories.elementAt(index).name,
                      style: TextStyle(color: Consts.app_primary_color, fontSize: 12, fontWeight: FontWeight.w500),
                    ), ),
                  );
                }).toList()),
          ) :Container(),
//          products.isEmpty ? CircularLoadingWidget(height: 288) :
          Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    primary: false,
//                    itemCount: 20,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      var searchSuggetionListObj = products.elementAt(index);
                      return GestureDetector(
                        onTap: () {
//                          Navigator.of(context).pushNamed('/Details',
//                              arguments: RouteArgument(
//                                id: products.elementAt(index).category_id.toString(),
//                                heroTag: widget.heroTag,
//                              ));
                        },
                        child: ListTile(
                          onTap: (){

                            Navigator.of(context).pushNamed(AllProductsPage.routeName,
                                arguments: new ProductListArgument(title :
//                                     searchtxt.isEmpty ?
                                products.elementAt(index).keyword,
//                                    :searchtxt
                                    productlist_route_argument: new Productlist_route_argument(
                                        user_id: Consts.current_userid, term: '',
                                        sort: '',
                                        category: searchSuggetionListObj.category_id,
                                        subcategory: searchSuggetionListObj.subcategory_id,
                                        childcategory: searchSuggetionListObj.childcategory_id,
                                        page: 0,
                                        paginate: 0),));
                          },
//                          title: Text(searchSuggetionListObj.keyword),
                          title: Html(
                              data:  searchSuggetionListObj.suggestion
                          ),
                          leading:  searchSuggetionListObj.image != null ?Image.network(
                            searchSuggetionListObj.image,
                            width: 55,
                            height: 55,
                            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return CommonWidget.getloadingBulder(loadingProgress);
                            },
                          ) : IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.grey[700],
                              size: 20,
                            ),
                            onPressed: () {

                            },

                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[600],
                              size: 18,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(AllProductsPage.routeName,
                                  arguments: new ProductListArgument(title :
//                                               searchtxt.isEmpty ?
                                  searchSuggetionListObj.keyword,
//                                    :searchtxt
                                      productlist_route_argument:  new Productlist_route_argument(
                                          user_id: Consts.current_userid, term: '',
                                          sort: '',
                                          category: searchSuggetionListObj.category_id,
                                          subcategory: searchSuggetionListObj.subcategory_id,
                                          childcategory: searchSuggetionListObj.childcategory_id,
                                          page: 0,
                                          paginate: 0)));
                          },

                          ),
                        ),
//                        child: InkWell(
//                          child: Padding(
//                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                            child: Text(products.elementAt(index).keyword),
//                          ),
//                          onTap: (){

//                          },
//                        ),
//                        child: CardWidget(restaurant: _con.restaurants.elementAt(index), heroTag: widget.heroTag),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(65, 6, 0, 6),
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      );
                    },
                  ),
                ),




        ],
      ),
    );
  }


  Future<void> getSearchList() async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/keywordsearch?keyword='+searchtxt);

//        '?highlight''=$highlight&limit=$limit&type=$type&product_type=$product_type&paginate=$paginate';

    print('url $url');

//    if(!EnableApiCall){
//      return;
//    }
//    EnableApiCall = false;

    var response = await http.get(url );
//    EnableApiCall = true;

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap['status'] && userMap.containsKey("data")) {
        List<Object> resultList = userMap['data'];

        List<SearchSuggetionListObj> mycategoriesList = new List(resultList.length);

        for (int i = 0; i < resultList.length; i++) {
          Object obj = resultList[i];
          SearchSuggetionListObj g = new SearchSuggetionListObj.fromJsonMap(obj);
          mycategoriesList[i] = g;
        }

        setState(() {
          products = mycategoriesList;
        });
      }else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
        setState(() {
          products = <SearchSuggetionListObj>[];

        });
      }
    } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
      setState(() {
        products = <SearchSuggetionListObj>[];

      });
    }
  }

}
