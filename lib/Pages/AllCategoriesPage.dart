import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pocketuse/Pages/HomePage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/controllers/CategoryController.dart';
import 'package:pocketuse/elements/CategoriesGridItemWidget.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/elements/ProductsGridItemWidget.dart';
import 'package:pocketuse/model/ProductList/Product.dart';
import 'package:pocketuse/model/ProductListArgument.dart';
import 'package:pocketuse/model/Productlist_route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/widgets/ShoppingCartButtonWidget.dart';
import 'package:http/http.dart' as http;

import 'MyCartListPage.dart';

class AllCategoriesPage extends StatefulWidget {
  static const routeName = '/AllCategoriesPage';

  @override
  AllCategoriesPageState createState() {
    return AllCategoriesPageState();
  }
}

class AllCategoriesPageState extends StateMVC<AllCategoriesPage> {
  CategoryController _con;

  AllCategoriesPageState() : super(CategoryController()) {
    _con = controller;
  }

  int currentPage = 1;
  final PagingController<int, Product> _pagingController = PagingController(firstPageKey: 0);
  List<Product> Products = null;
  String next = "";
  ProductListArgument productlistall_argument;

  void initState() {
    _con.listenForCategories();

    productlistall_argument = new ProductListArgument(title : "",
        productlist_route_argument:  Productlist_route_argument(user_id: Consts.current_userid, term: '', sort:'' ,
            category: 0, subcategory: 0, childcategory: 0, page: 0, paginate: 0));

//    _pagingController.addPageRequestListener((listener) {
//      print('_pagingController============');
//
//      if(next != null){
//        currentPage = currentPage+1;
//        getProducts(currentPage);
//      }
//    });
//
//    getProducts(currentPage);

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
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
//          Navigator.of(context)
//              .pushNamedAndRemoveUntil(HomePage.routeName, (Route<dynamic> route) => false);
              Navigator.pop(context);
            },
          ),
          title: CommonWidget.getActionBarTitleText('All Categories'),
          flexibleSpace: CommonWidget.ActionBarBg(),
          actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.search,
//              color: Colors.white,
//              size: 24,
//            ),
//            onPressed: () {},
//          ),
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
        body: getAllCategoriesView());
  }

  Widget getAllCategoriesView() {
    if (_con.categories.isNotEmpty
//        || _pagingController.itemList.isNotEmpty
    ) {
      return
        ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
            color: Colors.white54,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
               scrollDirection: Axis.vertical,
              childAspectRatio: 0.90,
              shrinkWrap: true,
//          primary: false,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
//          padding: EdgeInsets.symmetric(horizontal: 3),
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 3
                      : 4,
              children: List.generate(_con.categories.length, (index) {
                return CategoriesGridItemWidget(
                  category: this._con.categories.elementAt(index),
                );
              }),
            ),
          ),
//          getListView()
        ],
      );
    } else {
      return _con.EmptyResponseGEtting
          ? Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image(
                      image: AssetImage(
                          'assets/images/no_record_found_small_img.png'),
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No subcategory Found",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                          fontSize: 17),
                    )
                  ],
                ),
              ),
            )
          : CircularLoadingWidget(
              height: MediaQuery.of(context).size.height * 0.70);
    }
  }

  Widget getListView() {
    if (Products == null) {
      return CircularLoadingWidget(
          height: MediaQuery.of(context).size.height * 0.75);
    } else if (Products.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.65,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image(
                image:
                AssetImage('assets/images/no_record_found_small_img.png'),
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
    } else if (Products.isNotEmpty) {
      return  Container(
//            margin: EdgeInsetsDirectional.only(top: 10),
        color: Colors.white54,
        child:   PagedGridView<int,  Product>(
//          physics: NeverScrollableScrollPhysics(),
//              primary: false,
          shrinkWrap: true,
          pagingController: _pagingController,
          padding: EdgeInsets.symmetric(horizontal: 0),
          builderDelegate: PagedChildBuilderDelegate<Product>(
            itemBuilder: (context, item, index) => ProductsGridItemWidget(
              product: item,
            ),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            crossAxisCount:  MediaQuery.of(context).orientation == Orientation.portrait ? 2  : 4,
            childAspectRatio:  0.72,
//              childAspectRatio:  0.65,
          ),
        ),

      );
    }
  }
  Future<void> getProducts(int pageKey) async {
    print('***********');
    productlistall_argument.productlist_route_argument.paginate = 15;
    productlistall_argument.productlist_route_argument.page = currentPage;
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/products');
    print('url $url');
    print(productlistall_argument.productlist_route_argument.toJson());
    const headers = {'Content-Type': 'application/json'};

    var response = await http.post(url,
        headers: headers, body: json.encode(productlistall_argument.productlist_route_argument));

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap["status"]) {
        List<Object> resultList = data['data'];

        List<Product> mycategoriesList = new List(resultList.length);

        for (int i = 0; i < resultList.length; i++) {
          Object obj = resultList[i];
          Product g = new Product.fromJsonMap(obj);
          mycategoriesList[i] = g;
        }

        var link = data["links"];
        next = link["next"];

        setState(() {
          Products = mycategoriesList;
          if(next == null){
            _pagingController.appendLastPage(Products);
          } else{
            _pagingController.appendPage(Products, currentPage);
          }

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

}
