import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/elements/ProductsGridItemWidget.dart';
import 'package:pocketuse/elements/SortingBottomSheetDialog.dart';
import 'package:pocketuse/model/ProductList/Product.dart';
import 'package:pocketuse/model/ProductListArgument.dart';
import 'package:pocketuse/model/Productlist_route_argument.dart';
import 'package:pocketuse/model/productlist_route_argument_temp/attributes.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/widgets/ShoppingCartButtonWidget.dart';

import 'FilterPage.dart';
import 'MyCartListPage.dart';
import 'WishListPage.dart';

class AllProductsPage extends StatefulWidget {
  static const routeName = '/AllProductsPage';

  ProductListArgument productlistall_argument;

//  Productlist_route_argument productlist_route_argument;
  String title;

  AllProductsPage({Key key, this.productlistall_argument
//    , this.title
      })
      : super(key: key);

  @override
  AllProductsPageState createState() {
    return AllProductsPageState();
  }
}

class AllProductsPageState extends StateMVC<AllProductsPage>
    implements CAllBackOfSortingSelection, CallbackOfFilterDialog {

  int currentPage = 1;
  final PagingController<int, Product> _pagingController = PagingController(firstPageKey: 0);
  List<Attributes> attributes =null;

  @override
  void initState() {

    _pagingController.addPageRequestListener((listener) {
      print('_pagingController============');

      if(next != null){
        currentPage = currentPage+1;
        getProducts(currentPage);
      }
    });

    getProducts(currentPage);

    super.initState();
//    getProducts();
  }



  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

//  ProductListController _con;
//  AllProductsPageState() : super(ProductListController()) {
//    _con = controller;
//  }

  List<Product> Products = null;
  String next = "";

//  List<Product> Products = <Product>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing : 0.0,
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
            Navigator.pop(context);
          },
        ),
        title: CommonWidget.getActionBarTitleText((widget.productlistall_argument != null && widget.productlistall_argument.title != null &&
            widget.productlistall_argument.title.isNotEmpty) ? widget.productlistall_argument.title : 'Product List'),
        flexibleSpace: CommonWidget.ActionBarBg(),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(WishListPage.routeName);
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
      body: Column(
//        shrinkWrap: true,
//        primary: true,
//        physics: new NeverScrollableScrollPhysics(),
        children: [
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.sort),
                      Text(
                        '  ' + 'Sort',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {
                    String type = '';
                    if (widget.productlistall_argument != null && widget.productlistall_argument.productlist_route_argument != null &&
                        widget.productlistall_argument.productlist_route_argument.sort != null) {
                      type = widget.productlistall_argument.productlist_route_argument.sort;
                    }
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SortingBottomSheetDialog(this, type);
                      },
                    );
                  },
                )),
                Container(
                  width: 1.2,
                  color: Colors.grey[200],
                  height: 45,
                ),
                Expanded(
                    child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 7, 4),
                            child: Icon(
                              Icons.filter_list,
                              size: 20,
                            ),),
                          (attributes != null && attributes.isNotEmpty ) ? Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              width: 50,
                              child: Center(
                                child: Text(
                                  attributes != null ? attributes.length.toString() : "",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.caption.merge(
                                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 9),
                                  ),
                                )),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              decoration:
                              BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(10))),
                              constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),

                            ),) : Container(),
                        ],
                      ),
                      Text(
                        '  ' + 'Filter',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return new FilterPage(
                              this,
                              CommonWidget.replaceNullIntWithEmpty(
                                  widget.productlistall_argument.productlist_route_argument.category),
                              CommonWidget.replaceNullIntWithEmpty(widget
                                  .productlistall_argument.productlist_route_argument.subcategory),
                              CommonWidget.replaceNullIntWithEmpty(widget
                                  .productlistall_argument.productlist_route_argument.childcategory),
                              CommonWidget.replaceNullWithEmpty(
                                  widget.productlistall_argument.productlist_route_argument.term),

                              attributes);

//                            return new FilterPage(this, "3" );
                        },
                        fullscreenDialog: true));
                  },
                )),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.grey[200],
            width: MediaQuery.of(context).size.width,
          ),
          getListView()
        ],
      ),
    );
  }

  @override
  void sortingType(String sType) {

    setState(() {
      // sType sortingtype
      widget.productlistall_argument.productlist_route_argument.sort = sType;
      currentPage = 0;
      next = "";
      _pagingController.refresh();

    });
  }

  @override
  void filteredData(List<Attributes> _attributes) {
    setState(() {
      attributes = _attributes;
    });

    if (widget.productlistall_argument.productlist_route_argument == null) {
      widget.productlistall_argument.productlist_route_argument = new Productlist_route_argument(
          user_id: Consts.current_userid,
          term: '',
          sort: '',
          category: 0,
          subcategory: 0,
          childcategory: 0,
          page: 0,
          paginate: 0,
          attributes: attributes);
    } else {
      try {
        widget.productlistall_argument.productlist_route_argument.attributes = attributes;
      } catch (e) {}
    }

    currentPage = 0;
    next = "";
    _pagingController.refresh();
  }

  Future<void> getProducts(int pageKey) async {
    print('***********');
    widget.productlistall_argument.productlist_route_argument.paginate = 15;
    widget.productlistall_argument.productlist_route_argument.page = currentPage;
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/products');

//        '?highlight''=$highlight&limit=$limit&type=$type&product_type=$product_type&paginate=$paginate';

    print('url $url');
    print(widget.productlistall_argument.productlist_route_argument.toJson());
    const headers = {'Content-Type': 'application/json'};

    var response = await http.post(url,
        headers: headers, body: json.encode(widget.productlistall_argument.productlist_route_argument));

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

//  Future<void> _fetchPage(int pageKey) async {
//    try {
//      final newItems = await RemoteApi.getCharacterList(pageKey, _pageSize);
//      final isLastPage = newItems.length < _pageSize;
//      if (isLastPage) {
//        _pagingController.appendLastPage(newItems);
//      } else {
//        final nextPageKey = pageKey + newItems.length;
//        _pagingController.appendPage(newItems, nextPageKey);
//      }
//    } catch (error) {
//      _pagingController.error = error;
//    }
//  }

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
      return Expanded(
          child: Container(
//            margin: EdgeInsetsDirectional.only(top: 10),
            color: Colors.white54,
           child:   PagedGridView<int,  Product>(
            primary: false,
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
//        child: GridView.count(
////              shrinkWrap: true,
//          primary: false,
//          childAspectRatio: 0.65,
////              scrollDirection: Axis.vertical,
////              physics: ScrollPhysics(),
////          primary: false,
//          crossAxisSpacing: 0,
//          mainAxisSpacing: 0,
//          padding: EdgeInsets.symmetric(horizontal: 0),
//          crossAxisCount:  MediaQuery.of(context).orientation == Orientation.portrait ? 2  : 4,
//          children: List.generate(Products.length, (index) {
//            return ProductsGridItemWidget(
//              product: this.Products.elementAt(index),
//            );
//          }),
//        ),
      ));
    }
  }
}
