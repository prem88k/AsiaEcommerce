import 'package:flutter/material.dart';
import 'package:pocketuse/Pages/AllSubCategoriesPage.dart';
import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';

// My Own Imports

class CategoryGrid extends StatefulWidget {
  List<CategoryModel> categories;
  CategoryGrid([this.categories]);

  @override
  CategoryGridState createState() {
    return CategoryGridState();
  }

}

class CategoryGridState extends State<CategoryGrid>{

//  CategoryController _con;
//
//  CategoryGridState() : super(CategoryController()) {
//    _con = controller;
//  }
//
//  CategoryModel category;
//
//  @override
//  void initState() {
//    super.initState();
//    _con.listenForCategories();
//  }

//  final categoryList = [
//    {'title': 'Top Offers', 'image': 'assets/gokartImages/category/top_offers.jpg'},
//    {
//      'title': 'Mobiles & Tablets',
//      'image': 'assets/gokartImages/category/mobile_tablet.jpg'
//    },
//    {'title': 'Fashion', 'image': 'assets/gokartImages/category/fashion.jpg'},
//    {
//      'title': 'Electronics & Accessories',
//      'image': 'assets/gokartImages/category/electronics.jpg'
//    },
//    {
//      'title': 'Home & Furniture',
//      'image': 'assets/gokartImages/category/home_forniture.jpg'
//    },
//    {'title': 'TV & Appliances', 'image': 'assets/gokartImages/category/tv_appliances.jpg'},
//    {'title': 'Beauty & Personal Care', 'image': 'assets/gokartImages/category/beauty.jpg'},
//    {
//      'title': 'Monthly Essentials',
//      'image': 'assets/gokartImages/category/monthly_essentials.jpg'
//    }
//  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    InkWell getStructuredGridCell(category) {
      final item = category;
        return InkWell(
          child: Image(
            image: NetworkImage(item.image),
            fit: BoxFit.fitHeight,
          ),
          onTap: () {
            Navigator.of(context).pushNamed( AllSubCategoriesPage.routeName, arguments: new RouteArgument(id: category.id.toString(), heroTag: category.name )  );

          },
        );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(5.0),
      alignment: Alignment.center,
      width: width - 20.0,
      height: MediaQuery.of(context).size.height * 0.27,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        padding: const EdgeInsets.all(0),
        crossAxisSpacing: 0,
        mainAxisSpacing: 15,
        crossAxisCount: 4,
        children: List.generate(widget.categories.length, (index) {
          return getStructuredGridCell(widget.categories[index]);
        }),
      ),
    );
  }
}
