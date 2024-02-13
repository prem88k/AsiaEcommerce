import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/controllers/CategoryController.dart';
import 'package:pocketuse/model/CategoryModel.dart';

import 'CategoriesHomeListItemWidget.dart';
import 'CircularLoadingWidget.dart';

class HomeScreenCategoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenCategoryListState();
  }
}

class HomeScreenCategoryListState extends StateMVC<HomeScreenCategoryList>{
  CategoryController _con;

  HomeScreenCategoryListState() : super(CategoryController()) {
    _con = controller;
  }

  CategoryModel category;

    @override
    Widget build(BuildContext context) {
      return  _con.categories .isEmpty
      ? CircularLoadingWidget(height: MediaQuery.of(context).size.height) :
      Container(
          height: 80,
//          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Stack(
            children: [
//              CategoriesHomeListFirstAllItem(),
              ListView.builder(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                itemCount: _con.categories.length,
                itemBuilder: (context, index) {
                  return CategoriesHomeListItemWidget(
                    category: _con.categories.elementAt(index),
                  );
                },
                scrollDirection: Axis.horizontal,
              )
            ],
          )
      );
  }

}
