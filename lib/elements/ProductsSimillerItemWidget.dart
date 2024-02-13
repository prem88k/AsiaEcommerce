import 'package:flutter/material.dart';
import 'package:pocketuse/Pages/AllSubCategoriesPage.dart';
import 'package:pocketuse/Pages/ProductDetailPage.dart';
import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/model/Detail/related_products.dart';
import 'package:pocketuse/model/ProductList/Product.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';

import 'FavouriteWidget.dart';

// ignore: must_be_immutable
class ProductsSimillerItemWidget extends StatelessWidget implements FavouriteCallBack{
  Related_products product;

  ProductsSimillerItemWidget(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Theme.of(context).accentColor.withOpacity(0.08),
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.of(context).pushNamed(ProductDetailPage.routeName,
              arguments: new RouteArgument(
                  id: product.id.toString(), heroTag: product.title));
//                  id: category.id.toString(), heroTag: category.name));
        },
        child: Container(
          width: 150,
          padding: EdgeInsets.fromLTRB(7, 0, 7, 12),
          margin: EdgeInsets.fromLTRB(12, 0, 0, 15),
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
                  Image.network(
                      product.thumbnail,
//                    "http://18.191.233.163/assets/images/thumbnails/1568026368CzWwfWLG.jpg",
//                width: 70,
//                height: 70,
          loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return CommonWidget.getloadingBulder(loadingProgress);
        },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    product.title,
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
                          text: product.current_price + " ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: product.previous_price,
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
//                        TextSpan(
//                          text: ' '+CommonWidget.replaceNullWithEmpty(product.discount_percent)+ '% off',
//                          style: CommonWidget.getDiscountTextStyle(),
//                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                   CommonWidget.replaceNullWithEmpty(product.discount_percent)+ '% off',
                    style: CommonWidget.getDiscountTextStyle(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                     Visibility(child:  Container(
                       padding: EdgeInsets.fromLTRB(7, 2, 7, 2),
                       decoration: BoxDecoration(
                         color: Colors.green,
                         borderRadius: BorderRadius.all(Radius.circular(4.0)),
                       ),
                       child: Row(
                         children: [
                           Text(
                             product.rating.toString(),
                             style: TextStyle(color: Colors.white),
                           ),
                           Icon(
                             Icons.star,
                             color: Colors.white,
                             size: 12,
                           )
                         ],
                       ),
                     ),
                     visible: !( product.rating == null || product.rating == "0"
                         || product.rating == "0.00"),),
                     Visibility(child:  Text(
                       "  " + CommonWidget.getintFromStr(product.total_reviews)+' ratings',
                       style: TextStyle(
                           color: Colors.grey,
                           fontSize: 12,
                           fontWeight: FontWeight.w500),
                     ), visible: ( product.total_reviews != null && product.total_reviews != 0))

                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
//                  Text(
//                    'Temp No Cost EMI',
//                    style: TextStyle(
//                        color: Colors.black,
//                        fontSize: 13,
//                        fontWeight: FontWeight.w400),
//                  )
                ],
              ),
              FavouriteWidget(product.id.toString(), product.in_wishlist, this)
            ],
          ),
        ));
  }

  @override
  onfavouriteCallback(String id, bool Isfav) {
    if(Isfav){
      product.in_wishlist = 1;
    } else{
      product.in_wishlist = 0;
    }
  }
}
