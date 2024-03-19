import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';

import '../Utils/Consts.dart';
import '../model/GetStoreData.dart';
import '../model/route_argument.dart';
import '../widgets/CommonWidget.dart';
import 'ProductDetailPage.dart';

class AllSellerProductPage extends StatefulWidget {
  String storeId;

  AllSellerProductPage(this.storeId);

  @override
  State<AllSellerProductPage> createState() => _AllSellerProductPageState();
}

class _AllSellerProductPageState extends State<AllSellerProductPage> {
  bool isloading = false;
  GetStoreData getStoreData;
  List<Products> productList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSllerAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Consts.app_primary_color,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 5,right: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(getStoreData.data.vendor.shopName),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(getStoreData.data.vendor.address),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(getStoreData.data.vendor.email),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Colors.grey[200],
            ),
            OfferGrid1(productList)
          ],
        ),
      ),
    );
  }

  Future<void> getSllerAPI() async {
    setState(() {
      isloading = true;
    });
    var url = Uri.https(GlobalConfiguration().getString('url'),
        '/api/front/store/${widget.storeId}');

    Response response = await get(
      url,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    var getdata = json.decode(response.body);

    print("ProductResponse::$responseBody");
    if (statusCode == 200) {
      if (getdata["status"]) {
        if (mounted == true) {
          setState(() {
            isloading = false;
          });
        }

        getStoreData = GetStoreData.fromJson(jsonDecode(responseBody));
        productList.addAll(getStoreData.data.products);
      } else {
        if (mounted == true) {
          setState(() {
            isloading = false;
          });
        }
      }
    }
  }
}

class OfferGrid1 extends StatelessWidget {


  List<Products> productList;

  OfferGrid1(this.productList);

  @override
  Widget build(BuildContext context) {
    //int bgcolorr = int.parse("0xFF"+(productList.color_code.replaceAll("#", '')));
    double width = MediaQuery.of(context).size.width;

    InkWell getStructuredGridCell(Products productList) {
      final item = productList;
      return InkWell(
        child: Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Colors.grey,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(6.0),
                height: 120.0,
                child: CachedNetworkImage(
                  imageUrl: productList.thumbnail,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      getIconImgeWithCustomSize(
                          "assets/images/placeholder2.png", 45),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
//                Image(
//                  image: AssetImage(item['image']),
//                  fit: BoxFit.fitWidth,
//                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 4, 7, 5),
                      child: Text(
                        productList.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.w400),
                      ),
                    ),
//                    Text(
////                      "From ₹5,499",
//                      blockBustorDeal.current_price.toString()+" "+ blockBustorDeal.previous_price.toString(),
//                      style: TextStyle(
//                          color: const Color(0xFF67A86B), fontSize: 16.0),
//                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
//                style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: Consts.currencySymbolWithoutSpace +
                                productList.currentPrice.toString() +
                                " ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: Consts.currencySymbolWithoutSpace +
                                productList.previousPrice.toString(),
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: CommonWidget.IsdiscountVisibleForStr(
                                    productList.discountPercent)
                                ? " " +
                                    CommonWidget.replaceNullWithEmpty(
                                        productList.discountPercent) +
                                    "% off"
                                : "",
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(7, 2, 7, 2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                productList.rating.toString(),
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
                        /*Text(
                          "  " + CommonWidget.getintFromStr(productList.re)+' ratings',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )*/
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          print("------Details-----${productList.id.toString()}");
          Navigator.of(context).pushNamed(ProductDetailPage.routeName,
              arguments: new RouteArgument(
                  id: productList.id.toString(), heroTag: productList.title));

//          Navigator.of(context).pushNamed(AllProductsPage.routeName,
//              arguments: new Productlist_route_argument(user_id: Consts.current_userid,
//                  term: '', sort:'' , category: blockBustorDeal.id  , subcategory: 0, childcategory: 0, page: 0, paginate: 0));
//          Navigator.push(context, MaterialPageRoute(builder: (context) => TopOffers(title: '${item['title']}')),);
        },
      );
    }

    return Column(
      children: <Widget>[
        SizedBox(
          width: width,
          height: 550.0,
          child: Stack(
            children: <Widget>[
              Container(
                width: width,
                decoration: BoxDecoration(
                  //    color:  Color(bgcolorr),
                  color: const Color(0xFFF83850),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
                width: width - 20.0,
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
                child: GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 2,
                  childAspectRatio: ((width) / 525),
                  children: List.generate(productList.length, (index) {
                    return getStructuredGridCell(productList[index]);
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget getIconImgeWithCustomSize(String str, double size) {
    return Image(
      image: AssetImage(str),
      height: size,
      width: size,
    );
  }
}
