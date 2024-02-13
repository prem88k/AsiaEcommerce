import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/elements/OrderFilterBottomSheetDialog.dart';
import 'package:pocketuse/elements/OrderListItemWidget.dart';
import 'package:pocketuse/model/OrderListResponse/Order_list_response.dart';
import 'package:pocketuse/model/OrderListResponse/orders_data.dart';
import 'package:pocketuse/model/ProductList/Product.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:pocketuse/widgets/ShoppingCartButtonWidget.dart';
import 'package:http/http.dart' as http;

class MyOrdersPage extends StatefulWidget {
  static const routeName = '/MyOrdersPage';

  @override
  MyOrdersPageState createState() {
    return MyOrdersPageState();
  }
}

class MyOrdersPageState extends StateMVC<MyOrdersPage> implements CAllBackOfOrderSortingSelection {
  final TextEditingController OrderSearchController = TextEditingController();

//  List<Orders_data> products = null;
  bool IsIndicatorShow = false;

  int currentPage = 1;
  int next_page = 0;
  final PagingController<int, Orders_data> _pagingController = PagingController(firstPageKey: 0);

  String filterType = "";

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    OrderSearchController.addListener(() {
//      products
    });

    _pagingController.addPageRequestListener((listener) {
      print('_pagingController============');

      if(next_page != 0){
        currentPage = currentPage+1;
        getOrders(currentPage);
      }
    });

     getOrders(currentPage);
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
//            Navigator.of(context)
//                .pushNamedAndRemoveUntil(HomePage.routeName, (Route<dynamic> route) => false);
            Navigator.pop(context);
          },
        ),
        title: CommonWidget.getActionBarTitleText('My Orders'),
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
      body: Column(
        children: [
//          TextField(
//            controller: OrderSearchController,
//            autofocus: false,
//            cursorColor: Colors.black,
//            keyboardType: TextInputType.text,
//            textInputAction: TextInputAction.search ,
//            decoration: new InputDecoration(
//              filled: true,
//              fillColor: Colors.grey,
//              enabledBorder: OutlineInputBorder(
//                borderSide: const BorderSide(color: Colors.white, width: 0.0,),
//                borderRadius: BorderRadius.circular(10.7),
//              ),
//              focusedBorder: OutlineInputBorder(
//                borderSide: const BorderSide(color: Colors.white, width: 0.0,),
//                borderRadius: BorderRadius.circular(10.7),
//              ),
//              border: OutlineInputBorder(
//                borderSide: BorderSide(color: Colors.white),
//                borderRadius: BorderRadius.circular(10.7),
//              ),
//              contentPadding: EdgeInsets.only(left: 0, bottom: 8, top: 8, right: 15),
//              hintText: 'Find a product', hintStyle:  TextStyle(fontWeight: FontWeight.w500, color: Colors.blueGrey),
//              prefixIcon: Padding(padding: EdgeInsets.fromLTRB(18, 4, 15, 4),
//                  child: Image(image: AssetImage('assets/UserAppIcons/search.png',), height: 18, width: 18,)),
//            ),
//            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
//          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 13, 10, 13),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      textAlign: TextAlign.left,
                      textInputAction: TextInputAction.search,
                      style: TextStyle(color: Colors.black87, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Search your order here',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
//                        prefix: Padding(
////                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                          padding: const EdgeInsets.fromLTRB(0, 6, 10, 0),
//                          child: Icon(
//                            Icons.search,
////                            size: 18,
//                          ),
//                        ),
//                        contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
//                        isDense: true,
//                        contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                        contentPadding: EdgeInsets.fromLTRB(10.0, 5, 10, 5),
                      ),
//                      controller: ,
                    ),
                    height: 38,
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.filter_list),
                      Text(' Filters')
                    ],
                  ),
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return OrderFilterBottomSheetDialog(this, filterType);
                      },
                    );
                  },
                )
              ],
            ),
          ),
          CommonWidget.customdividerwithCustomColor(
              context, 4, Colors.grey[200]),
//          _con.categories.isEmpty
//              ? CircularLoadingWidget(
//                  height: MediaQuery.of(context).size.height * 0.70)
//              :
           getProductListView()
        ],
      ),
    );
  }


  Widget getProductListView() {
//    if(products == null || IsIndicatorShow){
//      return CircularLoadingWidget(
//          height: MediaQuery.of(context).size.height * 0.65);
//    } else if(products.isEmpty){
//      return Expanded(
////        height: MediaQuery.of(context).size.height * 0.65,
//        child: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            mainAxisSize: MainAxisSize.max,
//            children: <Widget>[
//              Image(
//                image: AssetImage('assets/images/no_record_found_small_img.png'),
//                width: MediaQuery.of(context).size.width * 0.8,
//              ),
//              SizedBox(height: 20),
//              Text(
//                "No product found.",
//                style: TextStyle(
//                    fontWeight: FontWeight.w600,
//                    color: Colors.black54,
//                    fontSize: 17),
//              )
//            ],
//          ),
//        ),
//      );
//    } else{
      return    Expanded(
          child: Container(
            color: Colors.white54,
padding: EdgeInsets.fromLTRB(0, 4, 0, 0),

//            child: PagedListView<int,  Orders_data>(
//              primary: false,
//              shrinkWrap: true,
//              pagingController: _pagingController,
//              padding: EdgeInsets.symmetric(horizontal: 0),
//              builderDelegate: PagedChildBuilderDelegate<Orders_data>(
//                itemBuilder: (context, item, index) => OrderListItemWidget(
//                  orderResponse: this.products.elementAt(index),
//                ),
//              ),
////              builderDelegate: SliverGridDelegateWithFixedCrossAxisCount(
////                crossAxisSpacing: 0,
////                mainAxisSpacing: 0,
////                crossAxisCount:  MediaQuery.of(context).orientation == Orientation.portrait ? 2  : 4,
////                childAspectRatio:  0.72,
////            //              childAspectRatio:  0.65,
////              ),
//            ),

           child: PagedListView.separated(
               primary: false,
               shrinkWrap: true,
               pagingController: _pagingController,
               padding: EdgeInsets.symmetric(horizontal: 0),
               builderDelegate: PagedChildBuilderDelegate<Orders_data>(
                 itemBuilder: (context, item, index) => OrderListItemWidget(
                   orderResponse: item,
                 ),
               ),
               separatorBuilder: (context, index) {
                 return Divider(color: Colors.grey,);
               }
               ),


//            child: ListView.separated(
//              itemCount: products.length,
//              itemBuilder: (context, index) {
//                return OrderListItemWidget(
//                  orderResponse: this.products.elementAt(index),
//                );
//              },
//              separatorBuilder: (context, index) {
//                return Divider(
//                  color: Colors.grey,
//                );
//              },
//            ),
          ));
//    }

  }

  Future<void> getOrders(int pageKey ) async {
//    String status = "pending";
    String page = currentPage.toString();

    print('url ' + Consts.api_authentication_token);
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/orders'+'?page''=$page&status=$filterType');

    print('url $url');

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader:
          'Bearer ' + Consts.api_authentication_token
    };

    var response = await http.get(url, headers: requestHeaders);
    print(response.body + "..............");

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

      if (userMap["status"]) {
        var data = userMap["data"];
        var orderListResponse_obj = new OrderListResponse.fromJsonMap(data) as OrderListResponse;
//
//        var link = data["links"];
        next_page = data["next_page"];

        setState(() {
//          products = orderListResponse_obj.orders_data;
          if(next_page == 0){
             _pagingController.appendLastPage(orderListResponse_obj.orders_data);
          } else{
             _pagingController.appendPage(orderListResponse_obj.orders_data, currentPage);
          }

        });
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
        setState(() {
          _pagingController.appendLastPage([]);
        });
      }
    } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);
      setState(() {
        _pagingController.appendLastPage([]);
      });
    }
  }

  @override
  void orderFilterType(String sType) {
    setState(() {
      // sType sortingtype
      filterType = sType;
      currentPage = 0;
      next_page = 1;
      _pagingController.refresh();

    });
  }
}
