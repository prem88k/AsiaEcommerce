import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/model/ProductList/Product.dart';
import 'package:pocketuse/repository/category_repository.dart';
import 'package:pocketuse/repository/productlist_repository.dart';

class ProductListController extends ControllerMVC {
  List<Product> Products = <Product>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  CategoryController() {
    listenForProducts();
  }

  void listenForProducts() async {
    final Stream<Product> stream = await getProducts('hot', '10', 'Physical', 'normal', '3');
    stream.listen((Product _category) {
      print('url $_category');

      setState(() => Products.add(_category));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> refreshHome() async {
    Products = <Product>[];

    listenForProducts();
  }
}
