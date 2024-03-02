import 'package:flutter/material.dart';
import 'package:pocketuse/Pages/AllProductsPage.dart';
import 'package:pocketuse/Pages/ProductDetailPage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/gokartPages/pages/category/top_offers.dart';
import 'package:pocketuse/model/ProductListArgument.dart';
import 'package:pocketuse/model/Productlist_route_argument.dart';
import 'package:pocketuse/model/CategorieWiseProductPackage/HomePageCategoriWiseProducts.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';



class BlockBusterDeals extends StatelessWidget {
  HomePageCategoriWiseProducts homeCategorieWiseProduct;
  BlockBusterDeals(this.homeCategorieWiseProduct);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
//       height: 580.0,
      child: Column(
        children: <Widget>[
          TopImage(homeCategorieWiseProduct),
          OfferGrid(homeCategorieWiseProduct),
        ],
      ),
    );
  }
}

class TopImage extends StatelessWidget {
  HomePageCategoriWiseProducts homeCategorieWiseProduct;
  TopImage(this.homeCategorieWiseProduct);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
//        Image(
//          image: AssetImage('assets/gokartImages/top_design/block_buster_deals.jpg'),
//        ),

        CachedNetworkImage(
          imageUrl: homeCategorieWiseProduct.background_image,
          fit: BoxFit.cover,
          progressIndicatorBuilder:
              (context, url, downloadProgress) =>
              getIconImgeWithCustomSize("assets/images/placeholder2.png", 45),

          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
        Image.network(homeCategorieWiseProduct.background_image,
          loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return CommonWidget.getloadingBulder(loadingProgress);
          },),
        Positioned(
          top: 40.0,
          left: 20.0,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(0.0),
            width: 320.0,
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      homeCategorieWiseProduct.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                    ),
//                   Text(
//                     homeCategorieWiseProduct.name,
//                     style: TextStyle(
//                       color: Colors.white54,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12.0,
//                     ),
//                   ),
                  ],
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'View All', style: TextStyle(color: Colors.black, fontWeight:  FontWeight.w600, fontSize: 13),
                        ),
                        SizedBox(width: 4,),
                        Icon(Icons.arrow_forward_ios, size: 12,color: Colors.black87,)
                      ],
                    ),
                  ),
                  onTap: () {

                    Navigator.of(context).pushNamed(AllProductsPage.routeName,
                        arguments: new ProductListArgument(title : homeCategorieWiseProduct.name,
                            productlist_route_argument: new Productlist_route_argument(user_id: Consts.current_userid, term: '', sort:'',
                                category: homeCategorieWiseProduct.id , subcategory: 0, childcategory: 0, page: 0, paginate: 0)));

//                    Navigator.push(context, MaterialPageRoute(builder: (context) => TopOffers(title: 'Block Buster Deals')),);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget getIconImgeWithCustomSize(String str, double size) {
    return Image(image: AssetImage(str), height: size, width: size,);
  }}

class OfferGrid extends StatelessWidget {
//  final blockBustorDealList = [
//    {
//      'image': 'assets/gokartImages/block_bustor_deal/block_bustor_1.jpg',
//      'title': 'Oppo A3s',
//      'offer': 'Flat ₹6,000 Off'
//    },
//    {
//      'image': 'assets/gokartImages/block_bustor_deal/block_bustor_2.jpg',
//      'title': 'Blockbustor Deals On TVs',
//      'offer': 'From ₹5,499'
//    },
//    {
//      'image': 'assets/gokartImages/block_bustor_deal/block_bustor_3.jpg',
//      'title': 'Asian, Kraasa & more',
//      'offer': 'Min. 55% Off'
//    },
//    {
//      'image': 'assets/gokartImages/block_bustor_deal/block_bustor_4.jpg',
//      'title': 'Puma, FILA & more',
//      'offer': 'Min. 60% Off'
//    }
//  ];

  HomePageCategoriWiseProducts homeCategorieWiseProduct;
  OfferGrid(this.homeCategorieWiseProduct);

  @override
  Widget build(BuildContext context) {
    int bgcolorr = int.parse("0xFF"+(homeCategorieWiseProduct.color_code.replaceAll("#", '')));
    double width = MediaQuery.of(context).size.width;

    InkWell getStructuredGridCell(blockBustorDeal) {
      final item = blockBustorDeal;
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
                child:   CachedNetworkImage(
                  imageUrl:blockBustorDeal.thumbnail,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) =>
                      getIconImgeWithCustomSize("assets/images/placeholder2.png", 45),

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
                    Padding(padding: EdgeInsets.fromLTRB(7, 4, 7, 5),
                      child: Text(
                        blockBustorDeal.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w400),
                      ),),
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
                            text: Consts.currencySymbolWithoutSpace+  blockBustorDeal.current_price.toString() + " ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,),
                          ),
                          TextSpan(
                            text: Consts.currencySymbolWithoutSpace+ blockBustorDeal.previous_price.toString(),
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text:  CommonWidget.IsdiscountVisibleForStr(blockBustorDeal.discount_percent) ?
                            " "+CommonWidget.replaceNullWithEmpty(blockBustorDeal.discount_percent)+ "% off" :"",
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
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                blockBustorDeal.rating.toString(),
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
                        Text(
                          "  " + CommonWidget.getintFromStr(blockBustorDeal.total_reviews)+' ratings',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          print("------Details-----${blockBustorDeal.id.toString()}");
          Navigator.of(context).pushNamed(ProductDetailPage.routeName,
              arguments: new RouteArgument(
                  id: blockBustorDeal.id.toString(), heroTag: blockBustorDeal.title));

//          Navigator.of(context).pushNamed(AllProductsPage.routeName,
//              arguments: new Productlist_route_argument(user_id: Consts.current_userid,
//                  term: '', sort:'' , category: blockBustorDeal.id  , subcategory: 0, childcategory: 0, page: 0, paginate: 0));
//          Navigator.push(context, MaterialPageRoute(builder: (context) => TopOffers(title: '${item['title']}')),);
        },
      );
    }

    return  Column(
      children: <Widget>[
        SizedBox(
          width: width,
          height: 490.0,
          child: Stack(
            children: <Widget>[
              Container(
                width: width,
                height: 500.0,
                decoration: BoxDecoration(
                  color:  Color(bgcolorr),
//                  color: const Color(0xFFF83850),
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
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 2,
                  childAspectRatio: ((width) / 525),
                  children: List.generate(homeCategorieWiseProduct.products.length, (index) {
                    return getStructuredGridCell(homeCategorieWiseProduct.products[index]);
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
    return Image(image: AssetImage(str), height: size, width: size,);
  }
}
