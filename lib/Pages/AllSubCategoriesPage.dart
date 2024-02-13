import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/controllers/SubcategoryController.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/elements/SubCategoriesGridItemWidget.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:pocketuse/widgets/ShoppingCartButtonWidget.dart';

import 'MyCartListPage.dart';

class AllSubCategoriesPage extends StatefulWidget {
  static const routeName = '/AllSubCategoriesPage';
  RouteArgument routeArgument;

  AllSubCategoriesPage({Key key, this.routeArgument}) : super(key: key);

  @override
  AllSubCategoriesPageState createState() {
    return AllSubCategoriesPageState();
  }
}

class AllSubCategoriesPageState extends StateMVC<AllSubCategoriesPage> {
  SubcategoryController _con;

  AllSubCategoriesPageState() : super(SubcategoryController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForsubCategories(id: widget.routeArgument.id,
        message: widget.routeArgument.heroTag,
        cntx:  context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    var size = MediaQuery
        .of(context)
        .size;

    final double itemHeight = (size.width / 4) + 20;
    final double itemWidth = size.width / 4;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing : 0.0,
        //        iconTheme: IconThemeData(
//          color: Colors.black, //change your color here
//        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: CommonWidget.getActionBarTitleText(widget.routeArgument.heroTag),
        flexibleSpace: CommonWidget.ActionBarBg(),
        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.search,
//              color: Colors.white,
//              size: 24,
//            ),
//            onPressed: () {},
//          ),
          ShoppingCartButtonWidget()
//          IconButton(
//            icon: Icon(
//              Icons.shopping_cart,
//              color: Colors.white,
//              size: 24,
//            ),
//            onPressed: () {
//              Navigator.of(context).pushNamed(MyCartListPage.routeName);
//            },
//          )
        ],
      ),
      body: getAllSubCatView(itemWidth, itemHeight, random),
//      Container(
//        color: Colors.white54,
//        child: GridView.count(
//          // Create a grid with 2 columns. If you change the scrollDirection to
//          // horizontal, this produces 2 rows.
//          crossAxisCount: 4,
//          // Generate 100 widgets that display their index in the List.
//          children: List.generate(20, (index) {
//            return Padding(padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
//                  child: Center(
//                    child:  ListView(
////                      alignment : WrapAlignment.center,
////                      crossAxisAlignment : WrapCrossAlignment.center,
////                      direction: Axis.vertical,
//                      children: [
//                        SizedBox(height: 10,),
//                        Container(
////                          width: MediaQuery.of(context).size.width * 0.22,
////                          height: 80,
//                          decoration: BoxDecoration(
//                            color: Colors.purple[50],
//                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                          ),
//                          child: Padding(
//                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                            child: Icon(
//                              Icons.cake,
//                              color: Colors.black,
//                              size: 40,
//                            ),
////                              child: CommonWidget.getIconImgeWithCustomSize('assets/temp2.jpg',20),
//                          ),
//                        ),
////                        Flexible(child: Text(
////                          'Item ItemI xg tsdf sg $index',
////                          maxLines: 3,
////
//////                              style: Theme.of(context).textTheme.bodyText2,
////                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
////                        ),)
//                      ],
//                    ),
//                  )
////                  Expanded(
////                    flex: 1,
////                    child: ,
////
////                  )
//            );
//          }),
//        ),
//      ),
    );
  }

  Widget getAllSubCatView(itemWidth, itemHeight, random) {
    if (_con.subcategories.isNotEmpty) {
     return Container(
        margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
        color: Colors.white54,
        child: GridView.count(
          childAspectRatio:  0.87,
//          childAspectRatio: (itemWidth / itemHeight),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
//          primary: false,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          padding: EdgeInsets.symmetric(horizontal: 3),
          crossAxisCount:
          MediaQuery
              .of(context)
              .orientation == Orientation.portrait ? 4 : 4,
          children: List.generate(_con.subcategories.length, (index) {
            return SubCategoriesGridItemWidget(
              category: this._con.subcategories.elementAt(index),
              iindex: random.nextInt(3),
            );
          }),
        ),
      );
    } else {
      if(_con.EmptyResponseGEtting ){

//        Navigator.of(context).pushNamed(
//          AllProductsPage.routeName,
//          arguments: new Productlist_route_argument(
//              term: '',
//              sort: '',
//              category: int.parse(widget.routeArgument.id),
//              subcategory: 0,
//              childcategory: 0,
//              page: 0,
//              paginate: 0),
//        );
        return  Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: MediaQuery
              .of(context)
              .size
              .height * 0.63,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image(
                  image: AssetImage(
                      'assets/images/no_record_found_small_img.png'),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                ),
                SizedBox(height: 20),
                Text(
                  "No subcategory Found",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                      fontSize: 17),
                )
              ],
            ),
          ),
        );
      } else{
        return CircularLoadingWidget(height: MediaQuery
            .of(context)
            .size
            .height * 0.70);
      }
    }
  }
}
