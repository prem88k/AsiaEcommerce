import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/Pages/LoginPage.dart';
import 'package:pocketuse/Pages/MyCartListPage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/model/RemoveCartRequest.dart';
import 'package:pocketuse/model/UpdateQuantityRequest.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:pocketuse/model/CardList/products.dart';
import 'package:http/http.dart' as http;

class UpdateTotal {
  void onUpdateTotal(String total) {}
  void refresh() {}
  void ProgressIndicator(bool b){}
}

class MycartItemWidgetForOrderSummery extends StatefulWidget {
  Products products;

  MycartItemWidgetForOrderSummery({Key key, this.products})
      : super(key: key);

  @override
  MycartItemWidgetState createState() {
    return MycartItemWidgetState();
  }
}

class MycartItemWidgetState extends State<MycartItemWidgetForOrderSummery> {
  double current_width;

  List<DropdownMenuItem<String>> dropdownlist = [];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    current_width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 14, 120, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
//                direction: Axis.vertical,
                children: [
                  Text(
                    widget.products.item.name,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  widget.products.variations.length>0 ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  widget.products.variations.map((data) {
                        return Padding(
                            padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.attribute_name+": ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  data.option_name,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                        );
                      }).toList()) : Container(),

                  SizedBox(
                    height: 12,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
//                style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: Consts.currencySymbolWithoutSpace +
                              widget.products.price.toString() +
                              "  ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: widget.products.getprevious_price(),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
//                        TextSpan(
//                          text: "  " + '00% off',
//                          style: TextStyle(
//                              color: Colors.lightGreen,
//                              fontSize: 12,
//                              fontWeight: FontWeight.w500),
//                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Visibility(
                    visible: CommonWidget.IsdiscountVisible(widget.products.item.discount_percentage),
                    child: Text(widget.products.item.getdiscount()+ '% off',
//                  Text(CommonWidget.replaceNullWithEmpty(widget.products.discount)+ '% off',
//                    '3 offers applied  . 2 offers available',
                    style: CommonWidget.getDiscountTextStyle(),
                  ),),


                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),



            Container(
              color: Colors.grey[200],
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
//            Container(
//              color: Colors.grey[200],
//              height: 6,
//              width: MediaQuery.of(context).size.width,
//            )
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: Column(
            children: [
              Image.network(
                widget.products.item.photo,
//                "http://18.191.233.163/assets/images/thumbnails/1568026368CzWwfWLG.jpg",
                width: 55,
                height: 75,
                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CommonWidget.getloadingBulder(loadingProgress);
                },
              ),



            ],
          ),
        )
      ],
    );
  }

}