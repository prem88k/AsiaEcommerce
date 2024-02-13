import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/Utils/Api_constant.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/dialog/CancelOrderDialog.dart';
import 'package:pocketuse/dialog/RatingDialog.dart';
import 'package:pocketuse/dialog/ReturnOrderDialog.dart';
import 'package:pocketuse/model/OrderDetail/OrderDetailResponse.dart';
import 'package:pocketuse/model/RatingResponse.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:pocketuse/widgets/ShoppingCartButtonWidget.dart';
import 'package:http/http.dart' as http;

import 'NeedHelpPage.dart';

class OrderDetaiPage extends StatefulWidget {
  static const routeName = '/OrderDetaiPage';

  RouteArgument routeArgument;

  OrderDetaiPage({Key key, this.routeArgument}) : super(key: key);

  @override
  OrderDetaiPageState createState() {
    return OrderDetaiPageState();
  }
}

class OrderDetaiPageState extends State<OrderDetaiPage>
    implements
        CallbackOfRatinngdDialog,
        CallbackOfCancelOrderDialog,
        CallbackOfReturnOrderDialog {
  OrderDetailResponse orderResponse;

  @override
  void initState() {
    super.initState();
    getOrderDetail(widget.routeArgument.id);
  }

  @override
  Widget build(Object context) {
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
//            Navigator.of(context).pushNamedAndRemoveUntil(
//                HomePage.routeName, (Route<dynamic> route) => false);
              Navigator.pop(context);
            },
          ),
          title: CommonWidget.getActionBarTitleText("Order Details"),
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
//            IconButton(
//              icon: Icon(
//                Icons.shopping_cart,
//                color: Colors.white,
//                size: 24,
//              ),
//              onPressed: () {
//                Navigator.of(context).pushNamed(MyCartListPage.routeName);
//              },
//            )
          ],
        ),
        body: orderResponse != null
            ? Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    CommonWidget.customdividerwithCustomColor(
                        context, 3, Colors.white),
                    CommonWidget.customdividerwithCustomColor(
                        context, 3, Colors.grey[200]),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                      child: Text(
                        'Order Id - ' + orderResponse.order_number.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    CommonWidget.customdividerwithCustomColor(
                        context, 3, Colors.grey[200]),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 100, 0),
                              child: Wrap(
                                direction: Axis.vertical,
                                children: [
                                  Text(
                                    orderResponse.product_name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w400),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  orderResponse.optopns.length > 0
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children:
                                              orderResponse.optopns.map((data) {
                                            return Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 4, 0, 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data.attribute_name +
                                                          ": ",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black45,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      data.option_name,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black45,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ));
                                          }).toList())
                                      : Container(),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
//                style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: orderResponse.paid_amount
                                                  .toString() +
                                              "  ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        TextSpan(
                                          text: Consts
                                                  .currencySymbolWithoutSpace +
                                              orderResponse.total.toString() +
                                              "  ",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        TextSpan(
                                          text: "  " + '00% off',
                                          style: CommonWidget
                                              .getDiscountTextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            CommonWidget.customdivider(context, 1),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Column(
                            children: [
                              Image.network(
                                orderResponse.thumbnail,
                                width: 55,
                                height: 75,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return CommonWidget.getloadingBulder(
                                      loadingProgress);
                                },
                              ),
                              InkWell(
                                child: Container(
                                  width: 75,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2.0)),
                                    border: new Border.all(
                                      color: Colors.grey[400],
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Qty: 1',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.black87),
                                        ),
//                                  SizedBox(
//                                    width: 5,
//                                  ),
//                                  Icon(
//                                    Icons.arrow_drop_down,
//                                    size: 16,
//                                    color: Colors.black87,
//                                  ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 17, 10, 15),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  'Ordered ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Sat, 12th Oct 19 ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Delivered ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Ordered ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(1, 5, 0, 0),
                            child: Container(
                              width: 7.0,
                              height: 7.0,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                      child: Text(
                        'Value retdhf dfh urned and 100  will be in your account ill be in your account ',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        maxLines: 2,
                      ),
                    ),
                    CommonWidget.customdividerwithCustomColor(
                        context, 3, Colors.grey[200]),

                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingBarIndicator(
                              rating: orderResponse.rating,
                              direction: Axis.horizontal,
//                      allowHalfRating: true,
                              unratedColor: Colors.green.withAlpha(50),
                              itemCount: 5,
                              itemSize: 28.0,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              'Write a review ',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blueAccent[700],
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => RatingDialog(
                                orderResponse.product_id.toString(),
                                '',
                                5.0,
                                this));
                      },
                    ),
                    CommonWidget.customdividerwithCustomColor(
                        context, 3, Colors.grey[200]),

                   InkWell(child: Padding(
                     padding: EdgeInsets.fromLTRB(0, 17, 0, 17),
                     child: Center(
                       child: Text(
                         'Need help? ',
                         style: TextStyle(
                             fontSize: 13,
                             color: Colors.grey[700],
                             fontWeight: FontWeight.w500),
                       ),
                     ),
                   ),onTap: (){
                     Navigator.of(context).pushNamed(NeedHelpPage.routeName);
                   },),
                    CommonWidget.customdividerwithCustomColor(
                        context, 1, Colors.black12),
                    broadDivider(),
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 17, 10, 17),
                        child: Row(
                          children: [
                            Icon(Icons.list),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                'Download Invoice',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        CommonWidget.launchInBrowser(
                            "http://docs.google.com/viewer?url=http://www.pdf995.com/samples/pdf.pdf");
//               launch("http://docs.google.com/viewer?url=http://www.pdf995.com/samples/pdf.pdf");
                      },
                    ),
                    CommonWidget.customdividerwithCustomColor(
                        context, 1, Colors.black12),
                    broadDivider(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 17, 10, 17),
                      child: Text(
                        'Shipping Details',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    CommonWidget.customdividerwithCustomColor(
                        context, 1, Colors.black12),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 17, 10, 10),
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            orderResponse.shipping_name,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            orderResponse.shipping_address,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            orderResponse.shipping_city,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            orderResponse.shipping_zip,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400),
                          ),
//                    Text(
//                      'Gujrat - 30800',
//                      style: TextStyle(
//                          fontSize: 14,
//                          color: Colors.black87,
//                          fontWeight: FontWeight.w400),
//                    ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Phone number: ' + orderResponse.shipping_phone,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    CommonWidget.customdividerwithCustomColor(
                        context, 1, Colors.black12),
                    broadDivider(),
//              Padding(
//                padding: EdgeInsets.fromLTRB(10, 17, 10, 17),
//                child: Wrap(
//                  direction: Axis.vertical,
//                  children: [
//                    Text(
//                      'Your rewards on this order',
//                      style: TextStyle(
//                          fontSize: 15,
//                          color: Colors.black87,
//                          fontWeight: FontWeight.w500),
//                    ),
//                    SizedBox(height: 5,),
//                    Row(
//                      mainAxisSize: MainAxisSize.max,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
//                      Row(
//                        children: [
//                          Container(child: Icon(Icons.star, size: 10,color: Colors.white,),
//                            width: 14,
//                            height: 14,
//                            decoration: const BoxDecoration(
//                              color: Colors.yellow,
//                              shape: BoxShape.circle,
//                            ),),
//                          SizedBox(width: 7,),
//                          Text(
//                            '50 super coins',
//                            style: TextStyle(
//                                fontSize: 14,
//                                color: Colors.black87,
//                                fontWeight: FontWeight.w400),
//                          ),
//                        ],
//                      ),
//                        Icon(Icons.arrow_forward_ios, size: 13,)
//                      ],
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                  ],
//                ),
//              ),
//              CommonWidget.customdividerwithCustomColor(
//                  context, 1, Colors.black12),
//              broadDivider(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 17, 10, 17),
                      child: Text(
                        'Price Details',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    CommonWidget.customdividerwithCustomColor(
                        context, 1, Colors.black12),
                    SizedBox(
                      height: 15,
                    ),
                    (orderResponse.order_amount_details != null &&
                            orderResponse.order_amount_details.isNotEmpty)
                        ?
//              Column(
////                direction: Axis.vertical,
////                children: [
////                  priceDetail('List Price', orderResponse.paid_amount.toString()),
////                  priceDetail('Selling price', orderResponse.paid_amount.toString()),
////                  priceDetail('Extra Discount', orderResponse.paid_amount.toString()),
////                  priceDetail('Special price', orderResponse.paid_amount.toString()),
//////                  priceDetail('10% Instant Discount on SBI Credit', '19900'),
////                  priceDetail('Shipping Free', orderResponse.paid_amount.toString()),
////                  priceDetail('Shipping Discoun', orderResponse.paid_amount.toString()),
////                  priceDetail('Exchange Value for Old Device', orderResponse.paid_amount.toString()),
////                  priceDetail('Pickup charge', orderResponse.paid_amount.toString()),
////                  SizedBox(
////                    height: 10,
////                  ),
////                  priceDetail('Total Amount',  orderResponse.paid_amount.toString()),
////                ],
//              children:  orderResponse.order_amount_details.map((data) {
//                return   priceDetail(data.label, data.amount.toString());
//              }).toList(),
//              )
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:
                                orderResponse.order_amount_details.map((data) {
                              return priceDetail(
                                  CommonWidget.replaceNullWithEmpty(data.label),
                                  CommonWidget.replaceNullWithEmpty(
                                      data.amount));
                            }).toList())
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    CommonWidget.customdividerwithCustomColor(
                        context, 1, Colors.black12),
                    SizedBox(
                      height: 7,
                    ),
                    priceDetail(
                        'Total Amount', orderResponse.paid_amount.toString()),
//              SizedBox(
//                height: 15,
//              ),CommonWidget.customdividerwithCustomColor(
//                  context, 1, Colors.black12),
                    SizedBox(
                      height: 15,
                    ),
//              Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//              child: Text(
//                '1 offer:',
//                style: TextStyle(
//                    fontSize: 14,
//                    color: Colors.green,
//                    fontWeight: FontWeight.w400),
//                maxLines: 1,
//                overflow: TextOverflow.ellipsis,
//              ),),
//              Padding(
//                padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    Text(
//                      '0% discount on  SBI Credit',
//                      style: TextStyle(
//                          fontSize: 14,
//                          color: Colors.black,
//                          fontWeight: FontWeight.w400),
//                      maxLines: 1,
//                      overflow: TextOverflow.ellipsis,
//                    ),
//                    Text(
//                      'Know more',
//                      style: TextStyle(
//                          fontSize: 14,
//                          color: Colors.blue[700],
//                          fontWeight: FontWeight.w400),
//                    ),
//                  ],
//                ),
//              ),
//              CommonWidget.customdividerwithCustomColor(
//                  context, 1, Colors.black12),

//              Padding(
//                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
//                child: Row(
//                  children: [
//                    Container(
//                      width: 7.0,
//                      height: 7.0,
//                      decoration: const BoxDecoration(
//                        color: Colors.black87,
//                        shape: BoxShape.circle,
//                      ),
//                    ),
//                    SizedBox(width: 7,),
//                    Text(
//                      'Credit card:13335.0 ',
//                      style: TextStyle(
//                          fontSize: 14,
//                          color: Colors.black,
//                          fontWeight: FontWeight.w400),
//                      maxLines: 1,
//                      overflow: TextOverflow.ellipsis,
//                    ),
//                  ],
//                ),
//              ),
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
                                Navigator.of(context)
                                    .push(new MaterialPageRoute<Null>(
                                        builder: (BuildContext context) {
                                          return new ReturnOrderDialog(
                                              orderResponse, this);
                                        },
                                        fullscreenDialog: true));
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1.0))),
                                padding:
                                    const EdgeInsets.fromLTRB(0, 16, 0, 16),
                                child: new Text('RETURN ORDER',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          )),
                          Container(
                            color: Colors.black87,
                            width: 1,
                            height: 28,
                          ),
                          Expanded(
                              child: Center(
                            child: InkWell(
                              onTap: () {
//                          if(AddToCartEnable){
                                Navigator.of(context)
                                    .push(new MaterialPageRoute<Null>(
                                        builder: (BuildContext context) {
                                          return new CancelOrderDialog(
                                              orderResponse, this);
                                        },
                                        fullscreenDialog: true));
//                          }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors
                                        .grey[100], // Consts.orange_Button ,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1.0))),
                                padding:
                                    const EdgeInsets.fromLTRB(0, 16, 0, 16),
                                child: new Text('CANCEL ORDER',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container());
  }

  broadDivider() {
    return Container(
      color: Colors.grey[200],
      height: 5,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget priceDetail(String s, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            CommonWidget.replaceNullWithEmpty(s),
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            Consts.currencySymbol + CommonWidget.replaceNullWithEmpty(value),
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Future<void> getOrderDetail(String id) async {
    print('url ' + Consts.api_authentication_token);
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/order/$id/details');


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
        var orderListResponse_obj =
            new OrderDetailResponse.fromJsonMap(data) as OrderDetailResponse;
//
        setState(() {
          orderResponse = orderListResponse_obj;
        });
      } else {
        Fluttertoast.showToast(
          msg: Api_constant.something_went_wrong,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: Api_constant.something_went_wrong,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  @override
  void ratingComplete(RatingResponse ratingResponse) {
    var str = CommonWidget.replaceNullWithEmpty(ratingResponse.rating);
    print(str);
    orderResponse.rating = double.parse(str);
  }

  @override
  void CancelOrderCallback() {
    getOrderDetail(widget.routeArgument.id);
  }

  @override
  void ReturnOrderCallback() {
    getOrderDetail(widget.routeArgument.id);
  }
}
