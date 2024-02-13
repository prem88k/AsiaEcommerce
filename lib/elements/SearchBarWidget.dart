import 'package:flutter/material.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/model/CategoryModel.dart';

import 'SearchWidget.dart';

class SearchBarWidget extends StatelessWidget {
  List<CategoryModel> categories = [];
  SearchBarWidget({Key key }) : super(key: key);
//  SearchBarWidget({Key key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(SearchModal(categories));
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Theme.of(context).focusColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(3)),
        child:Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 0),
              child: Icon(Icons.search, color: Colors.grey,size: 19,),
            ),
            Text(
              'Search for Products, Brands and More',
              style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 13)),
            )
          ],
        ),
      ),
    );
  }
}
