import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pocketuse/Pages/AllProductsPage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/gokartPages/pages/category/top_offers.dart';
import 'package:pocketuse/model/FeaturedBanner.dart';
import 'package:pocketuse/model/ProductListArgument.dart';
import 'package:pocketuse/model/Productlist_route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';

// My Own Imports

class FeaturedBrandSlider extends StatelessWidget {
  List<FeaturedBanner> featuredBanners;

  String featuredBannersTitle = "";
  String featuredBannersSubTitle = "";

  FeaturedBrandSlider([this.featuredBanners,
    this.featuredBannersTitle, this.featuredBannersSubTitle]);



  @override
  Widget build(BuildContext context) {
    InkWell getStructuredGridCell(featuredBrand) {
      final item = featuredBrand;
      return InkWell(
          onTap: () {

            Navigator.of(context).pushNamed(AllProductsPage.routeName,
                arguments: new ProductListArgument(title : featuredBannersTitle,
                    productlist_route_argument: new Productlist_route_argument(user_id: Consts.current_userid, term: '', sort:'' ,
                        category: item.id, subcategory: 0, childcategory: 0, page: 0, paginate: 0)));

//          Navigator.push(context, MaterialPageRoute(builder: (context) => TopOffers(title: '${item['title']}')),);
          },
          child: Image.network(item.photo,loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return CommonWidget.getloadingBulder(loadingProgress);
          },)
//        Image(
//          image: AssetImage(item['image']),
//        ),
      );
    }

    return Container(
      height: 305.0,
      padding: EdgeInsets.only(bottom: 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[

          Visibility(child: Container(
            padding: EdgeInsets.fromLTRB(12.0,12,12,0),
            alignment: Alignment.topLeft,
            child: Text(
              featuredBannersTitle.isEmpty ? "Featured Brands" : featuredBannersTitle,
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
            visible: (featuredBanners != null && featuredBanners.length > 0),),
          Visibility(child: Container(
            padding: EdgeInsets.fromLTRB(12.0, 0 ,12, 7),
            alignment: Alignment.topLeft,
            child: Text(
              featuredBannersSubTitle.isEmpty ?  "Sponsored" :featuredBannersSubTitle,
              style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
            visible: (featuredBanners != null && featuredBanners.length > 0),),

          CarouselSlider(
            options: CarouselOptions(
                height: 250.0,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 1),
                viewportFraction: 0.75,
                onPageChanged: (index, reason) {
//                setState(() {
//                  _current = index;
//                });
                }
            ),
            items: List.generate(featuredBanners.length, (index) {
              return getStructuredGridCell(featuredBanners[index]);
            }),
          ),
        ],
      ),
    );
  }
}
