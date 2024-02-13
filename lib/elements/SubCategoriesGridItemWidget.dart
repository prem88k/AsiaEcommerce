import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pocketuse/Pages/AllProductsPage.dart';
import 'package:pocketuse/Pages/AllSubCategoriesPage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/model/ProductListArgument.dart';
import 'package:pocketuse/model/Productlist_route_argument.dart';
import 'package:pocketuse/model/SubCategory.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';

// ignore: must_be_immutable
class SubCategoriesGridItemWidget extends StatelessWidget {
  SubCategory category;
  int iindex;

  SubCategoriesGridItemWidget({Key key, this.category, this.iindex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List colors = [Colors.red[50], Colors.green[50], Colors.blue[50]];
    double width = (MediaQuery.of(context).size.width * 0.26);
    double height = (MediaQuery.of(context).size.width * 0.22);

    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed(AllProductsPage.routeName,
            arguments: new ProductListArgument(title : category.name,
                productlist_route_argument: new Productlist_route_argument(
                    user_id: Consts.current_userid, term: '',
                    sort: '',
                    category: category.category_id,
                    subcategory: category.id,
                    childcategory: 0,
                    page: 0,
                    paginate: 0)));
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (category.image == null || category.image.isEmpty) ?  Container(
              height: 80,
                decoration: (category.image == null || category.image.isEmpty) ? BoxDecoration(
//                  color: colors[iindex],
//                color: Colors.purple[50],
                color: Colors.white,
                  border: Border.all(color: Colors.grey[200]),
//                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ) : BoxDecoration(),
                child: Center(child:  Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(category.name, textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black),),),)
            ) :

            Container(
//              decoration: BoxDecoration(
//                color: colors[iindex],
////                color: Colors.purple[50],
//                borderRadius: BorderRadius.all(Radius.circular(20.0)),
//              ),
              child:
//              Padding(
//                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                child:
                  Image.network(
                category.image,
                width: width,
                height: height,
                    loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CommonWidget.getloadingBulder(loadingProgress);
                    },
//                    fit: BoxFit.fill,
              ),
//              )
            ),
            SizedBox(
              height: 5,
            ),
//            Text(
//                category.name,
//                maxLines: 2,
//                overflow: TextOverflow.ellipsis,
//                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black87),
//                textAlign: TextAlign.center,
//              )
          ],
        ),
      ),
    );
  }
}

class UniqueColorGenerator {
  static Random random = new Random();

  static Color getColor() {
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}
