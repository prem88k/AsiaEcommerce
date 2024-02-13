
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/elements/ProductsGridItemWidget.dart';
import 'package:pocketuse/elements/SortingBottomSheetDialog.dart';
import 'package:pocketuse/model/ProductList/Product.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/widgets/ShoppingCartButtonWidget.dart';


class WishListPage extends StatefulWidget {
  static const routeName = '/WishListPage';

  @override
  WishListPageState createState() {
    return WishListPageState();
  }

}

class WishListPageState extends StateMVC<WishListPage> implements CAllBackOfSortingSelection {

  List<Product> Products = null;
  String sort = "price_asc";

  @override
  void initState() {
    super.initState();
    getfavProducts();
//    getProducts('hot', '10', 'Physical', 'normal', '3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
//        iconTheme: IconThemeData(
//          color: Colors.black, //change your color here
//        ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () {
//          Navigator.of(context).pushNamedAndRemoveUntil(HomePage.routeName, (Route<dynamic> route) => false);
          Navigator.pop(context);
        },
      ),
        title: CommonWidget.getActionBarTitleText('Wishlist'),
        flexibleSpace: CommonWidget.ActionBarBg(),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SortingBottomSheetDialog(
                      this,
                      sort
                  );
                },
              );
            },
          ),
          ShoppingCartButtonWidget()
//          IconButton(
//            icon: Icon(
//              Icons.shopping_cart,
//              color: Colors.white,
//              size: 24,
//            ),
//            onPressed: () {
//              Navigator.of(context).pushNamed(MyCartListPage.routeName);
//            },
//          )
        ],
      ),
      body: getFavListView()
//      Column(
////        shrinkWrap: true,
////        primary: true,
////        physics: new NeverScrollableScrollPhysics(),
//        children: [
//
//          Container(
//            color: Colors.white,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: [
//                Expanded(
//                  child: InkWell(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: [
//                        Icon(Icons.sort),
//                        Text('  '+'Sort', style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500, fontSize: 14),)
//                      ],
//                    ),
//                    onTap: (){
//                      showModalBottomSheet<void>(
//                        context: context,
//                        builder: (BuildContext context) {
//                          return SortingBottomSheetDialog(
//                              this,
//                              ''
//                          );
//                        },
//                      );
//                    },
//                  )
//                ),
//                Container(width: 1.2, color: Colors.grey[200], height: 45,),
//
//              ],
//            ),
//          ),
//          Container(height: 0.5, color: Colors.grey[200], width: MediaQuery.of(context).size.width,),
//
//          getFavListView()
//        ],
//      ),
    );
  }

  @override
  void sortingType(String sType) {
    setState(() {
      // sType sortingtype
      sort = sType;
      getfavProducts();
//      getProducts('', 'limit', 'type', 'product_type', 'paginate');
    });
  }

  Future<void> getfavProducts() async {
    print('url '+Consts.api_authentication_token);
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/wishlists?sort=$sort');

//        '?highlight''=$highlight&limit=$limit&type=$type&product_type=$product_type&paginate=$paginate';

    print('url $url');

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer '+ Consts.api_authentication_token
    };

    var response = await http.get(url, headers: requestHeaders );
    print(response.body + "..............");

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap["status"]) {
        List<Object> resultList = userMap["data"];

        List<Product> mycategoriesList = new List(resultList.length);

        for (int i = 0; i < resultList.length; i++) {
          Object obj = resultList[i];
          Product g = new Product.fromJsonMap(obj);
          mycategoriesList[i] = g;
        }

        setState(() {
          Products = mycategoriesList;
        });
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
        setState(() {
          Products = <Product>[];
        });
      }
    } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);
      setState(() {
        Products = <Product>[];
      });
    }
  }

   Widget getFavListView() {
    if(Products == null){
      return CircularLoadingWidget(
          height: MediaQuery.of(context).size.height * 0.75);

    } else if(Products.isEmpty){

      return Container(
        height: MediaQuery.of(context).size.height * 0.65,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/no_record_found_small_img.png'),
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              SizedBox(height: 20),
              Text(
                "No product found.",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    fontSize: 17),
              )
            ],
          ),
        ),
      );

    } else{
      return GridView.count(
//              shrinkWrap: true,
        primary: false,
        childAspectRatio:  0.72,
//        childAspectRatio: 0.65,
//              scrollDirection: Axis.vertical,
//              physics: ScrollPhysics(),

//          primary: false,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        padding: EdgeInsets.symmetric(horizontal: 0),
        crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
        children: List.generate(Products.length, (index) {
          return ProductsGridItemWidget(
            product: Products.elementAt(index),
          );
        }),
      );
    }
  }

}