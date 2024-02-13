import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/repository/category_repository.dart';

class CategoryController extends ControllerMVC {
  List<CategoryModel> categories = <CategoryModel>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  bool EmptyResponseGEtting = false;
  CategoryController() {
//    listenForCategories();
  }

  void listenForCategories() async {
    EmptyResponseGEtting = false;
    final Stream<CategoryModel> stream = await getCategories();
    stream.listen((CategoryModel _category) {
      print('url $_category');
      setState(() {
        categories.add(_category);
        EmptyResponseGEtting = false;
      });
//      setState(() => categories.add(_category));

    }, onError: (a) {
      setState(() =>  EmptyResponseGEtting = false);

    }, onDone: () {
      setState(() {
        EmptyResponseGEtting = true;

      });
    });
  }

  Future<void> refreshHome() async {
    categories = <CategoryModel>[];

    listenForCategories();
  }
}
