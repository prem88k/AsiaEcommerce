import 'package:flutter/material.dart';
import 'package:pocketuse/Pages/AllProductsPage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/gokartPages/pages/category/top_offers.dart';
import 'package:pocketuse/model/HomeBestSaleItem.dart';
import 'package:pocketuse/model/ProductListArgument.dart';
import 'package:pocketuse/model/Productlist_route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';

// My Own Imports

class BestDealGrid extends StatelessWidget {

//  final bestDealList = [
//    {'title': 'Latest Winter Collection', 'image': 'assets/gokartImages/best_deal/best_deal_1.jpg'},
//    {
//      'title': 'Bedsheets, Curtains & More',
//      'image': 'assets/gokartImages/best_deal/best_deal_2.jpg'
//    }
//  ];
  List<HomeBestSaleItem> homeBestSaleItems;
  BestDealGrid([this.homeBestSaleItems]);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    InkWell getStructuredGridCell(bestDeal) {
      final item = bestDeal;
      return InkWell(
        child:  CachedNetworkImage(
          imageUrl:item.image,
          fit: BoxFit.cover,
          progressIndicatorBuilder:
              (context, url, downloadProgress) =>
              getIconImgeWithCustomSize("assets/images/placeholder2.png", 100),

          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
//        Image(
//          image: AssetImage(item['image']),
//          fit: BoxFit.fitHeight,
//        ),
        onTap: () {
          Navigator.of(context).pushNamed(AllProductsPage.routeName,
              arguments: new ProductListArgument(title : "",
                  productlist_route_argument: new Productlist_route_argument(user_id: Consts.current_userid, term: '', sort:'' ,
                      category: item.id, subcategory: 0, childcategory: 0, page: 0, paginate: 0)));


//          Navigator.push(context, MaterialPageRoute(builder: (context) => TopOffers(title: '${item['title']}')),);
        },
      );
    }

    return Container(
      padding: EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: width - 20.0,
//      height: 220.0,
      child: GridView.count(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(0),
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        crossAxisCount: 2,
        childAspectRatio: ((width) / 430),
        children: List.generate(homeBestSaleItems.length, (index) {
          return getStructuredGridCell(homeBestSaleItems[index]);
        }),
      ),
    );
  }

  static Widget getIconImgeWithCustomSize(String str, double size) {
    return Image(image: AssetImage(str), height: size, width: size,);
  }}

