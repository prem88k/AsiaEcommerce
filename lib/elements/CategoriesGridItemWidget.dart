import 'package:flutter/material.dart';
import 'package:pocketuse/Pages/AllSubCategoriesPage.dart';
import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';

// ignore: must_be_immutable
class CategoriesGridItemWidget extends StatelessWidget {
  CategoryModel category;
  CategoriesGridItemWidget({Key key , this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.31;
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed( AllSubCategoriesPage.routeName, arguments: new RouteArgument(id: category.id.toString(), heroTag: category.name )  );
      },
      child:
//      (category.main_image == null || category.main_image.isEmpty) ?  Container(
//          height: 85,
//          decoration: BoxDecoration(
//          color: Colors.white,
//          borderRadius: BorderRadius.all(Radius.circular(5.0)),
//          border: new Border.all(
//            color: Colors.grey[200],
//            width: 0.5,
//          ),
//        ),
//          child: Center(child:  Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
//            child: Text(category.name, textAlign: TextAlign.center,
//              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black),),),)
//      ) :
      Container(
//        decoration: BoxDecoration(
//          color: Colors.white,
//          borderRadius: BorderRadius.all(Radius.circular(5.0)),
//          border: new Border.all(
//            color: Colors.grey[200],
//            width: 0.5,
//          ),
//        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                category.main_image,
                width: width,
                height: width,
                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CommonWidget.getloadingBulder(loadingProgress);
                },
              ),
//              Text(
//                category.name,
//                maxLines: 2,
//                overflow: TextOverflow.ellipsis,
//                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
//                textAlign: TextAlign.center,
//              )
            ],
          ),
        ),
      )
    );
  }
}