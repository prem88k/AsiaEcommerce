import 'package:flutter/material.dart';
import 'package:pocketuse/Pages/AllSubCategoriesPage.dart';
import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';

// ignore: must_be_immutable
class CategoriesHomeListItemWidget extends StatelessWidget {
  CategoryModel category;
  CategoriesHomeListItemWidget({Key key , this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed( AllSubCategoriesPage.routeName, arguments: new RouteArgument(id: category.id.toString(), heroTag: category.name )  );
      },
      child: SafeArea(
        child: Center(
          child: Image.network(
            category.image,
            width: 80,
            height: 80,
            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return CommonWidget.getloadingBulder(loadingProgress);
            },
          ),
        ),
      )
//      child: Container(
//        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//        width: 58,
//        child: Center(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Image.network(
//                category.image,
//                width: 50,
//                height: 50,
//              ),
//              Text(
//                category.name,
//                maxLines: 1,
//                overflow: TextOverflow.ellipsis,
//                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black87),
//                textAlign: TextAlign.center,
//              )
//            ],
//          ),
//        ),
//      );
    );
  }
}