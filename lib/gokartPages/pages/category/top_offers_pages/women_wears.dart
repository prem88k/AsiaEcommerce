import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pocketuse/gokartPages/Animation/slide_left_rout.dart';

import '../../cart.dart';
import '../../wishlist.dart';
import '../top_offers.dart';
import 'get_products.dart';

class WomensWear extends StatefulWidget {
  final PassData data;

  WomensWear({Key key, this.data}) : super(key: key);

  @override
  _WomensWearState createState() => _WomensWearState();
}

class _WomensWearState extends State<WomensWear> {
  bool progress = true;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      setState(() {
        progress = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.data.title),
        titleSpacing: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, SlideLeftRoute(page: WishlistPage()));
            },
          ),
          IconButton(
            icon: Badge(
             /* badgeContent: Text('3'),
              badgeColor: Theme.of(context).primaryColorLight,*/
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(context, SlideLeftRoute(page: CartPage()));
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF1F3F6),
      body: (progress)
          ? Center(
              child: SpinKitFoldingCube(
                color: Theme.of(context).primaryColor,
                size: 35.0,
              ),
            )
          : GetProducts(),
    );
  }
}
