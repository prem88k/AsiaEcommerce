import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/Pages/AllProductsPage.dart';
import 'package:pocketuse/Utils/Api_constant.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/model/ProductListArgument.dart';
import 'package:pocketuse/model/Productlist_route_argument.dart';
import 'package:pocketuse/model/SubCategory.dart';
import 'package:pocketuse/repository/subcategory_repository.dart';

class SubcategoryController extends ControllerMVC {
  List<SubCategory> subcategories = <SubCategory>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  bool EmptyResponseGEtting = false;

  SubcategoryController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForsubCategories({String id, String message, BuildContext cntx}) async {
    EmptyResponseGEtting = false;

    final Stream<SubCategory> stream = await getSubCategories(id);
    stream.listen((SubCategory _subcategory) {
      print('url $_subcategory');

      setState(() {
        subcategories.add(_subcategory);
        EmptyResponseGEtting = false;
      });
    }, onError: (a) {
      print('url onError $subcategories');
      print(a);
      ScaffoldMessenger.of(cntx).showSnackBar(
        SnackBar(
          content: Text(
              Api_constant.Verify_your_internet_connection),
        ),
      );
    }, onDone: () {
      print('url onDone $subcategories');

      if(subcategories.isNotEmpty){
        setState(() {
          EmptyResponseGEtting = true;

        });
      } else{
        print('=========== message ======================================= $message');

        Navigator.of(cntx).pushReplacementNamed(AllProductsPage.routeName,
            arguments: new ProductListArgument(title : message,
                productlist_route_argument: new Productlist_route_argument(
                user_id: Consts.current_userid, term: '',
                sort: '',
                category: (id == null || id.isEmpty) ? 0 : int.parse(id),
                subcategory: 0,
                childcategory: 0,
                page: 0,
                paginate: 0)));
      }

    });
  }
}
