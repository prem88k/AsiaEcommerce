import 'package:flutter/material.dart';
import 'package:pocketuse/Pages/AllCategoriesPage.dart';
import 'package:pocketuse/Pages/AllSubCategoriesPage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/model/route_argument.dart';

// ignore: must_be_immutable
class CategoriesHomeListFirstAllItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed(AllCategoriesPage.routeName);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        width: 65,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 5.0, color: Consts.app_primary_color),
                  ),
                 child: Icon(
                   Icons.category,
                   color: Colors.white,
                   size: 30.0,
                 ),
                width: 45,
                height: 45,
              ),
              Text(
                'All Categories',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black87),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      )
    );
  }
}