import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/Pages/MyCartListPage.dart';
import 'package:pocketuse/Providers/CartCountProvider.dart';
import 'package:provider/provider.dart';

class ShoppingCartButtonWidget extends StatefulWidget {

  const ShoppingCartButtonWidget({
//    this.count,
    Key key,
  }) : super(key: key);

//  final Color iconColor;
//  final Color labelColor;
//  final String count;

  @override
  _ShoppingCartButtonWidgetState createState() => _ShoppingCartButtonWidgetState();
}

class _ShoppingCartButtonWidgetState extends StateMVC<ShoppingCartButtonWidget> {
//  CartController _con;
//
//  _ShoppingCartButtonWidgetState() : super(CartController()) {
//    _con = controller;
//  }

  @override
  void initState() {
//    _con.listenForCartsCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 5),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 20,
                ),),
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
               child: Container(
                width: 50,
                child: Center(

                  child: Consumer<CartCountProvider>(
                    builder: (context, cart, child) {
                      print(cart.cartItemcount.toString()+"==cartItemcount==");
                      print(cart.getCartItemCount().toString()+"==cartItemcount==");
                      return Text(
                        cart.getCartItemCount().toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.merge(
                          TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 9),
                        ),
                      );
                    },
                  ) ,
//                  child: Text(
//                    Consts.cartItemcount.toString(),
//                    textAlign: TextAlign.center,
//                    style: Theme.of(context).textTheme.caption.merge(
//                      TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 9),
//                    ),
//                  ),
                ),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(10))),
                constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),

              ),),
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.of(context).pushNamed(MyCartListPage.routeName);
      },
    );
//    return MaterialButton(
//      onPressed: () {
//        if (Consts.Is_user_login) {
//          Navigator.of(context).pushNamed(MyCartListPage.routeName);
//        } else {
//          Navigator.of(context).pushNamed(LoginPage.routeName);
//        }
//      },
//      child: ,
//      color: Colors.transparent,
//    );
  }
}
