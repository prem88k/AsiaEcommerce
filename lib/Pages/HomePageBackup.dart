import 'package:flutter/material.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/elements/HomePageCategorieWiseProductList.dart';
import 'package:pocketuse/elements/HomeScreenCategoryList.dart';
import 'package:pocketuse/elements/HomeScreenFeaturedBannerList.dart';
import 'package:pocketuse/elements/HomeScreenSliderList.dart';
import 'package:pocketuse/elements/SearchBarWidget.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:pocketuse/widgets/SideMenu.dart';

import 'MyCartListPage.dart';

class HomePageBackup extends StatefulWidget {
  static const routeName = '/HomePageBackup';

  @override
  HomePageState createState() {
    return HomePageState();
  }

}

class HomePageState extends State<HomePageBackup>{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: CommonWidget.getActionBarTitleText(
                Consts.app_name ),
            flexibleSpace: CommonWidget.ActionBarBg(),
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.  white,
                  size: 24,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(MyCartListPage.routeName);
                },
              )
            ],
          ),
          drawer: MainDrawer(context),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
               Container(
                 color: Consts.app_primary_color,

                 child:  Padding(
                   padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                   child: SearchBarWidget( ),
                 ),
               ),

                HomeScreenCategoryList(),

                SizedBox(height: 5,),
                HomeScreenSliderList(),
                CommonWidget.customdivider(context,1),
                Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text('Featured Brand', style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600),),),
                HomeScreenFeaturedBannerList(),
//                Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                  child:Text('CategoryWise Product List', style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600),),
//                ),
                CommonWidget.customdividerwithCustomColor(context, 2, Colors.blueGrey[100]),
                CommonWidget.customdividerwithCustomColor(context, 9, Colors.blueGrey[50]),
                HomePageCategorieWiseProductList()
              ],
            ),
          ),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() async {
    print("_onWillPop===========" );
    return true;
  }
}