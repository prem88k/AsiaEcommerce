import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pocketuse/Pages/AllSubCategoriesPage.dart';
import 'package:pocketuse/Pages/ProductDetailPage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/model/Detail/related_products.dart';
import 'package:pocketuse/model/ProductList/Product.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';

import 'FavouriteWidget.dart';

// ignore: must_be_immutable
class ProductsGridItemWidget extends StatefulWidget{
  Product product;

  ProductsGridItemWidget( {Key key, this.product}) : super(key: key);

  @override
  ProductsGridItemWidgetState createState() {
    return ProductsGridItemWidgetState();
  }
}

class ProductsGridItemWidgetState extends State<ProductsGridItemWidget>  implements FavouriteCallBack{

  @override
  Widget build(BuildContext context) {
    var heightt = MediaQuery.of(context).size.height;
    return InkWell(
        splashColor: Theme.of(context).accentColor.withOpacity(0.08),
        highlightColor: Colors.transparent,
        onTap: ()  {
          _awaitGoToDetailPage();
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: new Border.all(
              color: Colors.grey[200],
              width: 0.5,
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    child: Center(
                      child: Image.network(
                          widget.product.thumbnail,
//                    "http://18.191.233.163/assets/images/thumbnails/1568026368CzWwfWLG.jpg",
//                width: 70,
                          height: heightt * 0.23,
                          loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return CommonWidget.getloadingBulder(loadingProgress);
                          }
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
//                    product.id.toString(),
                    widget.product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
//                style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: Consts.currencySymbolWithoutSpace+widget.product.current_price + " ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text:  widget.product.getpreviousprice(),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text:  CommonWidget.IsdiscountVisibleForStr(widget.product.discount_percent) ?
                          " "+CommonWidget.replaceNullWithEmpty(widget.product.discount_percent)+ "% off" :"",
                          style: CommonWidget.getDiscountTextStyle(),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Visibility(child: Container(
                        padding: EdgeInsets.fromLTRB(7, 2, 7, 2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              widget.product.rating.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 12,
                            )
                          ],
                        ),
                      ),visible: !( widget.product.rating == null || widget.product.rating == "0"
                          || widget.product.rating == "0.00"),),
                      Visibility(child: Text(
                        "  " +  CommonWidget.getintFromStr(widget.product.total_reviews)+' ratings',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      visible:( widget.product.total_reviews != null && widget.product.total_reviews != 0),)
                    ],
                  ),
//                  SizedBox(
//                    height: 6,
//                  ),
//                  Text(
//                    'Temp No Cost EMI',
//                    style: TextStyle(
//                        color: Colors.black,
//                        fontSize: 13,
//                        fontWeight: FontWeight.w400),
//                  )
                ],
              ),
              FavouriteWidget(widget.product.id.toString(), widget.product.in_wishlist, this)
            ],
          ),
        ));
  }

  @override
  onfavouriteCallback(String id, bool Isfav) {
    if(Isfav){
      widget.product.in_wishlist = 1;
    } else{
      widget.product.in_wishlist = 0;
    }
  }


  void _awaitGoToDetailPage() async{
    final result = await Navigator.of(context).pushNamed(ProductDetailPage.routeName,
        arguments: new RouteArgument(
            id: widget.product.id.toString(), heroTag: widget.product.title));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      widget.product.in_wishlist = result;
    });

  }
}
