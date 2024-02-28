import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/Providers/CartCountProvider.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/dialog/RatingDialog.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/elements/DetailPageItemsSliderList.dart';
import 'package:pocketuse/elements/FavouriteWidget.dart';
import 'package:pocketuse/elements/ProductsSimillerItemWidget.dart';
import 'package:pocketuse/elements/ShareWidget.dart';
import 'package:pocketuse/model/AddToCartRequestObjects/AddToCartRequest.dart';
import 'package:pocketuse/model/AddToCartRequestObjects/attributes.dart';
import 'package:pocketuse/model/Detail/ProductDetailResponse.dart';
import 'package:pocketuse/model/Detail/ReviewObj.dart';
import 'package:pocketuse/model/Detail/combinations.dart';
import 'package:pocketuse/model/Detail/images.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/model/temp/groupObj.dart';
import 'package:pocketuse/model/temp/group_data.dart';
import 'package:pocketuse/repository/productDetail_repository.dart' as settingRepo;
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/widgets/ShoppingCartButtonWidget.dart';
import 'package:provider/provider.dart';

import 'MyCartListPage.dart';
import 'OrderSummaryPage.dart';
import 'ReturnPolicyPage.dart';

class ProductDetailPage extends StatefulWidget {
  static const routeName = '/ProductDetailPage';

  RouteArgument routeArgument;

  ProductDetailPage({Key key, this.routeArgument}) : super(key: key);

  @override
  ProductDetailPageState createState() {
    return ProductDetailPageState();
  }
}

class ProductDetailPageState extends StateMVC<ProductDetailPage> implements FavouriteCallBack{
  ProductDetailResponse _productDetail = null;

  String firstSelection;
  String secondSelection;
  String thirdSelection;

  String firstSelectionCode;
  String secondSelectionCode;
  String thirdSelectionCode;

  List<Combinations> _combinations;
  List<Group_data> group_data_list =  <Group_data>[];

  String CurrentPrice;
  bool AddToCartEnable = true;

  @override
  void initState() {
    super.initState();
    settingRepo
//        .getProducatDetail("1")
        .getProducatDetail(widget.routeArgument.id)
        .then((productDetail) {
      setState(() {

        _productDetail = productDetail;

        if(_productDetail.first_image != null && _productDetail.first_image.isNotEmpty){
          _productDetail.images.add(new Images(789,_productDetail.first_image));
        }

        if (_productDetail.variations_data.variations.length > 0) {
          firstSelection = _productDetail.variations_data.variations[0].attribute_options[0];
          firstSelectionCode = _productDetail.variations_data.variations[0].attribute_code;
        }

        if (_productDetail.variations_data.variations.length > 1) {
          secondSelection = _productDetail.variations_data.variations[1].attribute_options[0];
          secondSelectionCode = _productDetail.variations_data.variations[1].attribute_code;
        }

        if (_productDetail.variations_data.variations.length > 2) {
          thirdSelection = _productDetail.variations_data.variations[2].attribute_options[0];
          thirdSelectionCode = _productDetail.variations_data.variations[2].attribute_code;
        }

        _combinations = _productDetail.variations_data.combinations;

        if(_productDetail.attributes != null && _productDetail.attributes.isNotEmpty){
          List<GroupObj> lis = _productDetail.attributes;

          for(int k=0; k< lis.length; k++){
            group_data_list.addAll(lis[k].group_data);
          }
        }

        CurrentPrice = _productDetail.current_price.toString();
      });
    });
  }
  CartCountProvider appState = null;

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<CartCountProvider>(context);

    return WillPopScope(
        child: Scaffold(
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
//            Navigator.of(context).pushNamedAndRemoveUntil(
//                HomePage.routeName, (Route<dynamic> route) => false);
                Navigator.pop(context, _productDetail.in_wishlist);
              },
            ),
            title: CommonWidget.getActionBarTitleText(CommonWidget.replaceNullWithEmpty(widget.routeArgument.heroTag)),
            flexibleSpace: CommonWidget.ActionBarBg(),
            actions: <Widget>[
//            IconButton(
//              icon: Icon(
//                Icons.search,
//                color: Colors.white,
//                size: 24,
//              ),
//              onPressed: () {},
//            ),
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
          body: _productDetail == null
              ? CircularLoadingWidget(
              height: MediaQuery.of(context).size.height * 0.70)
              : Column(
            children: [
              Expanded(
                  child: ListView(
//                mainAxisAlignment: MainAxisAlignment.start,
//                crossAxisAlignment: CrossAxisAlignment.start,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          DetailPageItemsSliderList(_productDetail.images),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Column(
                              children: [
                                FavouriteWidget( _productDetail.id.toString(), _productDetail.in_wishlist, this), ShareWidget(_productDetail)
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              CommonWidget.replaceNullWithEmpty(_productDetail.title),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Align(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'Special price',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
//                    color: Colors.blueGrey[100],
                                height: 18,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(3),
                                      topRight: Radius.circular(3),
                                      bottomLeft: Radius.circular(3),
                                      bottomRight: Radius.circular(3)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[400].withOpacity(0.6),
                                      spreadRadius: 0.5,
                                      blurRadius: 1,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
//                style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: Consts.currencySymbol +
                                            CurrentPrice+
                                            "  ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: _productDetail.getpreviousprice(),
                                        style: TextStyle(
                                            decoration:
                                            TextDecoration.lineThrough,
                                            color: Colors.grey,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text: CommonWidget.IsdiscountVisibleForStr(_productDetail.discount_percent) ?
                                        "  "+CommonWidget.replaceNullWithEmpty(_productDetail.discount_percent)+ "% off" : "",
                                        style: CommonWidget.getDiscountTextStyle(),
                                      ),
                                    ],
                                  ),
                                ),
//                              Text(
//                                "@ " +
//                                    Consts.currencySymbolWithoutSpace +
//                                    '0/Units',
//                                style: TextStyle(
//                                    color: Colors.grey,
//                                    fontSize: 13,
//                                    fontWeight: FontWeight.w500),
//                              )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Visibility(child: Container(
                                  padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        CommonWidget.replaceNullWithEmpty(_productDetail.rating.toString()),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 11),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 10,
                                      )
                                    ],
                                  ),
                                ),visible: !( _productDetail.rating == null || _productDetail.rating == "0"
                                    || _productDetail.rating == "0.00")),
                                Visibility(child: Text(
                                  "  " +  CommonWidget.getintFromStr(_productDetail.total_reviews)+' ratings',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),visible: ( _productDetail.total_reviews != null && _productDetail.total_reviews != 0),)
                              ],
                            ),
                            SizedBox(
                              height: 17,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey[200],
                        height: 2,
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Visibility(child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getTitleText("Available offers"),
                            SizedBox(
                              height: 10,
                            ),
                            ( _productDetail.available_offers != null &&  _productDetail.available_offers.isNotEmpty) ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: _productDetail.available_offers.map((data) {
                                  return   Padding(padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.local_offer,
                                          color: Colors.green,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                            child: Text(
                                              data,
//                                    'Bank offer: 10% off on sbi credit cards, up to  2780, on order of 5000 and above',
                                              style: TextStyle(color: Colors.black87),
                                            )),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                      ],
                                    ),);
                                }).toList()) : Container(),
                          ],
                        ),
                      ),visible:   ( _productDetail.available_offers != null &&  _productDetail.available_offers.isNotEmpty),),

                      _productDetail.variations_data.variations.length > 0
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          CommonWidget.customdividerwithCustomColor(
                              context, 1, Colors.grey[400]),
                          broadDivider(),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: getTitleText(CommonWidget.replaceNullWithEmpty(_productDetail
                                .variations_data
                                .variations[0]
                                .attribute_name)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: _productDetail.variations_data
                                      .variations[0].attribute_options
                                      .map((data) {
                                    return get1siXeBox(data);
                                  }).toList()),
                            ),
                          ),
                        ],
                      )
                          : Container(),

                      _productDetail.variations_data.variations.length > 1
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          CommonWidget.customdividerwithCustomColor(
                              context, 1, Colors.grey[400]),
                          broadDivider(),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: getTitleText(_productDetail.variations_data.variations[1].attribute_name),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                                children: _productDetail.variations_data.variations[1].attribute_options.map((data) {
                                  return get2siXeBox(data);
                                }).toList()),
                          ),
                        ],
                      )
                          : Container(),

                      _productDetail.variations_data.variations.length > 2
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          CommonWidget.customdividerwithCustomColor(
                              context, 1, Colors.grey[400]),
                          broadDivider(),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: getTitleText(_productDetail
                                .variations_data
                                .variations[2]
                                .attribute_name),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                                children: _productDetail.variations_data
                                    .variations[2].attribute_options
                                    .map((data) {
                                  return get3siXeBox(data);
                                }).toList()),
                          ),
                        ],
                      )
                          : Container(),

                      SizedBox(
                        height: 15,
                      ),
                      CommonWidget.customdividerwithCustomColor(
                          context, 1, Colors.grey[400]),
                      broadDivider(),
//                    Padding(
//                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
//                      child: Row(
//                        children: [
//                          Expanded(child: Text('Deliver to xyz -000000')),
//                          Card(
//                            child: Padding(
//                              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
//                              child: Text(
//                                'Change',
//                                style: TextStyle(
//                                    color: Consts.app_primary_color,
//                                    fontSize: 14,
//                                    fontWeight: FontWeight.w500),
//                              ),
//                            ),
//                          ),
////                        Container(
////                          width: 60,
////                          height: 25,
////                          decoration: BoxDecoration(
////                            color: Colors.white,
////                            borderRadius:
////                            BorderRadius.all(Radius.circular(2.0)),
////                            border: new Border.all(
////                              color: Colors.grey[400],
////                              width: 1,
////                            ),
////                          ),
////                          child: Center(
////                            child: Text(
////                              'Change',
////                              style: TextStyle(
////                                  color: Consts.app_primary_color,
////                                  fontSize: 14,
////                                  fontWeight: FontWeight.w500),
////                            ),
////                          ),
////                        ),
//                        ],
//                      ),
//                    ),
                      CommonWidget.customdivider(context, 2),
//                    Padding(
//                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 8),
//                      child: Row(
//                        children: [
//                          Icon(
//                            Icons.directions_car,
//                            size: 17,
//                            color: Consts.app_primary_color,
//                          ),
//                          SizedBox(
//                            width: 10,
//                          ),
//                          Expanded(
//                            child: Text(
//                              'Usually deliver in 3 days',
//                              style: TextStyle(
//                                  fontWeight: FontWeight.w400,
//                                  color: Colors.black,
//                                  fontSize: 14),
//                            ),
//                          ),
//                          SizedBox(
//                            width: 10,
//                          ),
//                          Icon(
//                            Icons.arrow_forward_ios,
//                            size: 15,
//                            color: Colors.grey,
//                          )
//                        ],
//                      ),
//                    ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.policy,
                                size: 17,
                                color: Consts.app_primary_color,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'Return policy',
//                              '14 days Return policy',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                      fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        onTap: (){
                          Navigator.of(context).pushNamed(
                              ReturnPolicyPage.routeName);
                        },
                      ),

//                    Padding(
//                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//                      child: Row(
//                        children: [
//                          Icon(
//                            Icons.directions_car,
//                            size: 17,
//                            color: Colors.lightGreen,
//                          ),
//                          SizedBox(
//                            width: 10,
//                          ),
//                          Expanded(
//                            child: Text(
//                              'Cash on Delivery Available',
//                              style: TextStyle(
//                                  fontWeight: FontWeight.w400,
//                                  color: Colors.black54,
//                                  fontSize: 14),
//                            ),
//                          ),
//                          Icon(
//                            Icons.arrow_forward_ios,
//                            size: 15,
//                            color: Colors.grey,
//                          )
//                        ],
//                      ),
//                    );
                      CommonWidget.customdividerwithCustomColor(
                          context, 1, Colors.grey[400]),
                      broadDivider(),

                      SizedBox(
                        height: 15,
                      ),
                      Visibility(child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: getTitleText("Sold By"),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  CommonWidget.replaceNullWithEmpty(_productDetail.shop.name),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Consts.app_primary_color,
                                      fontSize: 13),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
//                          Container(
//                            padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
//                            decoration: BoxDecoration(
//                              color: Consts.app_primary_color,
//                              borderRadius:
//                              BorderRadius.all(Radius.circular(15.0)),
//                            ),
//                            child: Row(
//                              children: [
//                                Text(
//                                  _productDetail.rating,
//                                  style: TextStyle(
//                                      color: Colors.white, fontSize: 11),
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: Colors.white,
//                                  size: 10,
//                                )
//                              ],
//                            ),
//                          ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CommonWidget.customdividerwithCustomColor(
                              context, 1, Colors.grey[400]),
                          broadDivider(),
                        ],
                      ), visible: CommonWidget.replaceNullWithEmpty(_productDetail.shop.name).isNotEmpty,),

                      (group_data_list != null && group_data_list.isNotEmpty) ? Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getTitleText("Product Details"),
                            SizedBox(
                              height: 10,
                            ),
                            group_data_list != null ?
                            Column(
                                children: group_data_list.map((data) {
                                  return Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child:  Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            CommonWidget.replaceNullWithEmpty(data.label),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(CommonWidget.replaceNullWithEmpty(data.label_value),
                                                textAlign: TextAlign.left))
                                      ],
                                    ),);
                                }).toList())
                                : Container(),

                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ) : Container(),

                      (group_data_list != null && group_data_list.isNotEmpty) ?   CommonWidget.customdividerwithCustomColor(
                          context, 2, Colors.grey[300]) : Container(),

                      (_productDetail.details != null && _productDetail.details.isNotEmpty) ? Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: getTitleText("Details"),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Html(
                                data:_productDetail.details
                            )
//                          Text(
//                            CommonWidget.replaceNullWithEmpty(_productDetail.details),
//                            style: TextStyle(color: Colors.black54),
//                          )
                          ],
                        ),
                      ) : Container() ,

                      (_productDetail.details != null && _productDetail.details.isNotEmpty) ? Column(
                        children: [
                          CommonWidget.customdividerwithCustomColor(
                              context, 1, Colors.grey[400]),
                          broadDivider(),
                          broadDivider(),
                        ],
                      ): Container() ,

                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: getTitleText((_productDetail.reviews != null && _productDetail.reviews.length > 0)  ? "Ratings & Reviews" :
                              "There are no reviews for this product" ),
                            ),
//                          InkWell(
//                            child: Card(
//                              child: Padding(
//                                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//                                child: Text(
//                                  'Rate Product',
//                                  style: TextStyle(
//                                      color: Consts.app_primary_color,
//                                      fontSize: 14,
//                                      fontWeight: FontWeight.w500),
//                                ),
//                              ),
//                            ),
//                            onTap: (){
//                              onRate();
//                            },
//                          ),
                          ],
                        ),
                      ),

                      (_productDetail.reviews != null && _productDetail.reviews.length > 0)  ?  Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 15),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    CommonWidget.replaceNullWithEmpty(_productDetail.rating.toString()),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 17,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              CommonWidget.getintFromStr(_productDetail.total_reviews)+ ' reviews',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      )  : Container(),

                      CommonWidget.customdividerwithCustomColor(
                          context, 2, Colors.grey[300]),

//                    ------------------
                      (_productDetail.reviews != null && _productDetail.reviews.length > 0)  ?
                      Column(
                          children: _productDetail.reviews.map((data) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(15.0)),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              CommonWidget.replaceNullWithEmpty(data.rating),
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 11),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'ABCD',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    CommonWidget.replaceNullWithEmpty(data.review),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.network(
                                        data.user_image,
                                        width: 45,
                                        height: 45,
                                        loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return CommonWidget.getloadingBulder(loadingProgress);
                                        },
                                      ),
//                                    Image.network(
//                                      "http://18.191.233.163/assets/images/thumbnails/1568026368CzWwfWLG.jpg",
//                                      width: 45,
//                                      height: 45,
//                                    ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                            CommonWidget.replaceNullWithEmpty(data.name),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[500],
                                                fontSize: 12),
                                          )),
//                                    InkWell(
//                                      child: Row(
//                                        children: [
//                                          Icon(
//                                            Icons.thumb_up,
//                                            color: Colors.grey[500],
//                                            size: 18,
//                                          ),
//                                          SizedBox(
//                                            width: 5,
//                                          ),
//                                          Text(
//                                            '00',
//                                            style: TextStyle(
//                                                fontWeight: FontWeight.w400,
//                                                color: Colors.grey[500],
//                                                fontSize: 13),
//                                          ),
//                                        ],
//                                      ),
//                                      onTap: () {},
//                                    ),
//                                    SizedBox(
//                                      width: 8,
//                                    ),
//                                    InkWell(
//                                      child: Row(
//                                        children: [
//                                          Icon(
//                                            Icons.thumb_down,
//                                            color: Colors.grey[500],
//                                            size: 18,
//                                          ),
//                                          SizedBox(
//                                            width: 5,
//                                          ),
//                                          Text(
//                                            '00',
//                                            style: TextStyle(
//                                                fontWeight: FontWeight.w400,
//                                                color: Colors.grey[500],
//                                                fontSize: 13),
//                                          ),
//                                        ],
//                                      ),
//                                      onTap: () {},
//                                    ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        color: Colors.grey[500],
                                        size: 16,
                                      ),
                                      Text(
                                        CommonWidget.replaceNullWithEmpty( data.review_date),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[500],
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  CommonWidget.customdivider(context, 1),
                                ],
                              ),
                            );
                          }).toList())
                          : Container(),


                      CommonWidget.customdividerwithCustomColor(
                          context, 2, Colors.grey[300]),

                      Visibility(
                          visible:  _productDetail.related_products.length > 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 20, 15),
                                child: getTitleText("Similar Products"),
                              ),

                              Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: _productDetail.related_products.map((data) {
                                        return ProductsSimillerItemWidget(data);
                                      }).toList()),
                                ),),
                            ],
                          )),

                      SizedBox(
                        height: 5,
                      ),

//            ListView.builder(
//              itemBuilder: (context, index) {
//                return ProductsGridItemWidget(
//                  category: this._con.categories.elementAt(index),
//                );
//              },
//              scrollDirection: Axis.horizontal,
//              shrinkWrap: true, physics: ScrollPhysics(),
//            )
                    ],
                  )
//            SingleChildScrollView(
//              child: ,
//            ),
              ),
//            CommonWidget.customdividerwithCustomColor(context, 2, Colors.grey[300]),
              Container(
                decoration: CommonWidget.containerShadow(),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  children: [

                    Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              if(AddToCartEnable){
                                AddToCartApiCall(false);
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color:  Colors.grey[100] ,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0))
                              ),
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: new Text('ADD TO CART', style: TextStyle(fontSize: 13,
                                  color : AddToCartEnable ? Colors.black87 : Colors.grey[400],
                                  fontWeight: FontWeight.w500 ),
                                  textAlign: TextAlign.center),
                            ),),
                        )),
                    Expanded(child: Center(
                      child: InkWell(
                        onTap: () {
                          if(AddToCartEnable){
                            AddToCartApiCall(true);
                          }},
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color:  Consts.orange_Button ,
                              borderRadius:
                              BorderRadius.all(Radius.circular(1.0))
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: new Text('BUY NOW', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500 , color: Colors.white),
                              textAlign: TextAlign.center),
                        ),),
                    ))
                  ],
                ),
              ),
              CommonWidget.customdivider(context, 2)
            ],
          ),
        ),
        onWillPop: _onWillPop
    );
  }

  Future<bool> _onWillPop() async {
    print("_onWillPop===========" );
    Navigator.pop(context, _productDetail.in_wishlist);
    return true;
  }
  getTitleText(String s) {
    return Text(
      CommonWidget.replaceNullWithEmpty(s),
      style: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
      textAlign: TextAlign.left,
    );
  }

  Widget get1siXeBox(String s) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 13, 0),
      child: InkWell(
        child: Container(
          width: 45,
          height: 25,
          decoration: BoxDecoration(
            color: s == firstSelection ? Colors.blueAccent : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            border: new Border.all(
              color: s == firstSelection ? Colors.blueAccent : Colors.black26,
              width: 0.5,
            ),
          ),
          child: Center(
            child: Text(CommonWidget.replaceNullWithEmpty(s), style: TextStyle(color: s == firstSelection ? Colors.white : Colors.black87),),
          ),
        ),
        onTap: (){
          setState(() {
            firstSelection = s;
            checkOtherCombinations();
          });
        },
      ),
    );
  }

  Widget get2siXeBox(String s) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 13, 0),
      child: InkWell(
        child: Container(
          width: 45,
          height: 25,
          decoration: BoxDecoration(
            color: s == secondSelection ? Colors.blueAccent : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            border: new Border.all(
              color: s == secondSelection ? Colors.blueAccent : Colors.black26,
              width: 0.5,
            ),
          ),
          child: Center(
            child: Text(CommonWidget.replaceNullWithEmpty(s), style: TextStyle(color: s == secondSelection ? Colors.white : Colors.black87),),
          ),
        ),
        onTap: (){
          setState(() {
            secondSelection = s;
            checkOtherCombinations();
          });
        },
      ),
    );
  }

  Widget get3siXeBox(String s) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 13, 0),
      child: InkWell(
        child: Container(
          width: 45,
          height: 25,
          decoration: BoxDecoration(
            color: s == thirdSelection ? Colors.blueAccent : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            border: new Border.all(
              color: s == thirdSelection ? Colors.blueAccent : Colors.black26,
              width: 0.5,
            ),
          ),
          child: Center(
            child: Text(CommonWidget.replaceNullWithEmpty(s), style: TextStyle(color: s == thirdSelection ? Colors.white : Colors.black87),),
          ),
        ),
        onTap: (){
          setState(() {
            thirdSelection = s;
            checkOtherCombinations();
          });
        },
      ),
    );
  }

  broadDivider() {
    return Container(
      color: Colors.grey[200],
      height: 7,
      width: MediaQuery.of(context).size.width,
    );
  }

  void checkOtherCombinations() {
    for(int i =0; i< _combinations.length ; i++){
      List<String> options= _combinations[i].options;

      if(options.length == 1){
        //means there is 1 variations
        if(options[0] == firstSelection){
          setPrice(_combinations[i]);
          return;
        }

      }else if(options.length == 2){
        //means there is 2 variations
        if(options[0] == firstSelection && options[1] == secondSelection){
          setPrice(_combinations[i]);
          return;
        }
      } else if(options.length == 3){
        //means there is 3 variations
        if(options[0] == firstSelection && options[1] == secondSelection && options[2] == thirdSelection){
          setPrice(_combinations[i]);
          return;
        }

      }
    }
  }


  void setPrice(Combinations combination) {
    CurrentPrice= combination.price.toString();
    if(combination.status == 1 && combination.quantity >0){
      AddToCartEnable = true;
    } else{
      AddToCartEnable = false;
    }
  }

  Future<void> AddToCartApiCall(bool IsFromBuynow) async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/addnumcart');

    List<Attributes> attributes = <Attributes>[];

    if (_productDetail.variations_data.variations.length ==  1) {
      attributes.add(new Attributes(firstSelectionCode, firstSelection));

    } else if(_productDetail.variations_data.variations.length == 2){
      attributes.add(new Attributes(firstSelectionCode, firstSelection));
      attributes.add(new Attributes(secondSelectionCode, secondSelectionCode));

    } else if(_productDetail.variations_data.variations.length == 3){
      attributes.add(new Attributes(firstSelectionCode, firstSelection));
      attributes.add(new Attributes(secondSelectionCode, secondSelectionCode));
      attributes.add(new Attributes(thirdSelectionCode, thirdSelection));

    }

    print('url $url');
    var card = new AddToCartRequest(
        Consts.device_rendom_number,
        CommonWidget.StringConvertintiInt(Consts.current_userid), _productDetail.id, 1, attributes);

    print(card.toJson());
    const headers = {'Content-Type': 'application/json'};

    var response = await http.post(url, headers: headers, body: json.encode(card));

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
//      if (userMap["status"]) {

//      } else {
      if(appState != null && userMap.containsKey('cart_items') && userMap['cart_items'] != null){
//        appState.setDisplayText( userMap['cart_items']);
        if(appState != null){
          appState.setDisplayText(userMap['cart_items']);
        }
      }

      Fluttertoast.showToast(
        msg: userMap['msg'],
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );

      if(IsFromBuynow){
        Navigator.of(context).pushNamed(MyCartListPage.routeName);
      }
//        setState(() {
//          products = <Products>[];
//        });
//      }
//    } else {
////    Toast.show(Api_constant.something_went_wrong, context,
////        gravity: Toast.CENTER);
//      setState(() {
//        products = <Products>[];
//      });
    }
  }

  @override
  onfavouriteCallback(String id, bool Isfav) {
    if(Isfav){
      _productDetail.in_wishlist = 1;
    } else{
      _productDetail.in_wishlist = 0;
    }
  }

  void onRate() {
//    showDialog(
//        context: context,
//        builder: (BuildContext context) =>
//            RatingDialog(_productDetail.id.toString(),'',
////                                                                 MyRequestcompletedObjList[index].transporter_name
//                this)
//    );
  }


}

