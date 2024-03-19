import 'package:flutter/material.dart';
import 'package:pocketuse/Pages/AbountPocketusePage.dart';
import 'package:pocketuse/Pages/AllCategoriesPage.dart';
import 'package:pocketuse/Pages/LoginPage.dart';
import 'package:pocketuse/Pages/MyCartListPage.dart';
import 'package:pocketuse/Pages/MyAccountPage.dart';
import 'package:pocketuse/Pages/PrivacyPolicyPage.dart';
import 'package:pocketuse/Pages/ReturnPolicyPage.dart';
import 'package:pocketuse/Pages/SellerPolicyPage.dart';
import 'package:pocketuse/Pages/TermsOfUsePage.dart';
import 'package:pocketuse/Pages/razorPaymentDemo.dart';
import 'package:pocketuse/Pages/MyOrdersPage.dart';
import 'package:pocketuse/Pages/WishListPage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/Utils/MyPreferenceManager.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CommonWidget.dart';

class MainDrawer extends StatefulWidget {
  BuildContext ccontext;

  MainDrawer(this.ccontext);

  @override
  MainDrawerState createState() {
    return MainDrawerState();
  }

//  @override
//  MainDrawerState createState() {
//    return MainDrawerState();
//  }
}

class MainDrawerState extends State<MainDrawer> {
  bool IsProfesionalUser = true;

  String customer_name = '';

  Widget buildListTilewithBg(String title, IconData icon, Function tapHandler) {
    return InkWell(
      onTap: tapHandler,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 35, 0),
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 15,
                ),
//                Image(image: AssetImage(icon),
//                  color: Consts.SideMenuCurrentlySelectedPosition == indexInList ? Colors.white :Consts.app_primary_color,
//                  height: 23, width: 23,),
                Icon(
                  icon,
                  color: Colors.grey[600],
                  size: 20.0,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 13,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getIconImge(String str) {
    return Image(
      image: AssetImage(str),
      height: 23,
      width: 23,
    );
  }

  Widget divider() {
    return Padding(
        padding: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
        child: Container(
          height: 5,
          color: Colors.white24,
        )
//      Divider(
//        color: Colors.white24,
//        thickness: 0.8,
//      ),
    );
  }

  @override
  void initState() {
    super.initState();
    updateCustomerName();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.7,
      child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
//            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
//                      new Image.asset(
//                        'assets/images/sidemenu_araba_icon_2line.png',
//                        width: 190.0,
//                        height: 70.0,
//                        fit: BoxFit.fitWidth,
//                      ),
//                      Row(
//                        children: <Widget>[
//                          Image(
//                            image: AssetImage('assets/images/sidemenu_icon_only.png'),
//                            height: 50,
//                            width: 50,
//                          ),
//                          SizedBox(
//                            width: 5,
//                          ),
//                          Text(customer_name.toUpperCase(),
//                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),)
//                        ],
//                      ),
              InkWell(
                onTap: () {
                  /*Navigator.of(widget.ccontext).pop();
                    print(Consts.Is_user_login);
                  if (!Consts.Is_user_login) {
                    Navigator.of(widget.ccontext).pushNamed(
                        LoginPage.routeName,  arguments: new RouteArgument(id: MyAccountPage.routeName));
                  } else{
                    Navigator.of(context).pushNamed(LoginPage.routeName,  arguments: new RouteArgument(id: MyAccountPage.routeName ));

                  }*/
                },
                child: Container(
                  height: 90,
//              height: MediaQuery.of(context).size.height * 0.08,
                  color: Consts.app_primary_color,
//                decoration: BoxDecoration(
//                  image: DecorationImage(
//                    image: AssetImage('assets/side_menu/sidemenu_bg.png'),
//                    fit: BoxFit.fill,
//                  ),
////                  image: AssetImage('assets/side_menu/sidemenu_bg.png')
//                ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 23, 0, 0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
//                    Consts.Is_user_login ? Container() :
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: Icon(
                            Icons.home, color: Colors.white, size: 23.0,),),
//                      Image(
//                        image: AssetImage('assets/side_menu/side_menu_horce_icon.png'),
//                        height: 40,
//                        color: Colors.white,
//                        width: 40,
//                      ),

                        Expanded(
                          child: Text(
                            Consts.Is_user_login ? Consts.current_username!=null?Consts.current_username:Consts.current_phonenumber :"Login",
//                        customer_name.toUpperCase(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),

//                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
//                            child: CommonWidget.getIconImgeWithCustomSize('assets/images/side_meni_top_icon.jpg', 35),),
                      ],
                    ),
                  ),
//                child: Center(
//                  child:  Image(
//                    image: AssetImage('assets/side_menu/tirthtravels_logo.png'),
//                    height: 140,
//                    color: Colors.white,
//                    width: MediaQuery.of(context).size.width * 0.5,
//                  ),
//                ),
                ),
              ),
              SizedBox(
                height: 5,
              ),

              buildListTilewithBg('All Categories', Icons.category, () {
                Navigator.of(widget.ccontext)
                    .pushNamed(AllCategoriesPage.routeName);
              }),

              divider(),


              CommonWidget.customdividerwithCustomColor(
                  context, 1, Colors.grey[300]),
              divider(),
//
//          buildListTilewithBg('All ProductList', Icons.category, () {
//            Navigator.of(widget.ccontext)
//                .pushReplacementNamed(AllProductsPage.routeName);
//          }),

//          divider(),
//        SizedBox(height: 5,),
//          SizedBox(height: 5,),
              divider(),

              buildListTilewithBg('My Orders', Icons.star_border, () {
                Navigator.of(widget.ccontext)
                    .pushNamed(MyOrdersPage.routeName);
              }),

              divider(),

              buildListTilewithBg('My Cart', Icons.shopping_cart, () {
                Navigator.of(widget.ccontext).pushNamed(
                    MyCartListPage.routeName);
              }),

              divider(),
              buildListTilewithBg('My Wishlist', Icons.favorite, () {

                if(Consts.Is_user_login){
                  Navigator.of(widget.ccontext).pushNamed(WishListPage.routeName);
                } else{
                  Navigator.of(context).pushNamed(LoginPage.routeName,  arguments: new RouteArgument(id: WishListPage.routeName ));
                }
              }),

              divider(),
              buildListTilewithBg('My Account', Icons.account_box_outlined, () {
                if(Consts.Is_user_login){
                  Navigator.of(widget.ccontext).pushNamed(MyAccountPage.routeName);
                } else{
                  Navigator.of(context).pushNamed(LoginPage.routeName,  arguments: new RouteArgument(id: MyAccountPage.routeName ));
                }
              }),

              divider(),
              CommonWidget.customdividerwithCustomColor(
                  context, 1, Colors.grey[300]),
              divider(),
              divider(),
//              ----------
              buildListTilewithBg('About Asia Online', Icons.policy, () {
                Navigator.of(widget.ccontext).pushNamed(AbountPocketusePage.routeName);
              }),

              divider(),
              buildListTilewithBg('Privacy Policy', Icons.policy, () {
                Navigator.of(widget.ccontext).pushNamed(
                    PrivacyPolicyPage.routeName);
              }),

              divider(),
              buildListTilewithBg('Terms Of Use', Icons.policy_rounded, () {
                Navigator.of(widget.ccontext).pushNamed(
                    TermsOfUsePage.routeName);
              }),

              divider(),
              buildListTilewithBg('Returns Policy', Icons.policy_sharp, () {
                Navigator.of(widget.ccontext).pushNamed(
                    ReturnPolicyPage.routeName);
              }),

              divider(),
              buildListTilewithBg('Seller Policy', Icons.policy, () {
                Navigator.of(widget.ccontext).pushNamed(
                    SellerPolicyPage.routeName);
              }),

              divider(),
              CommonWidget.customdividerwithCustomColor(
                  context, 1, Colors.grey[300]),
              divider(),
              divider(),

              buildListTilewithBg('Sell on Asia Online', Icons.shopping_bag, () {
                Navigator.of(widget.ccontext).pop();
                _launchInBrowser("https://seller.asiaonline.co.in/login");
              }),

              divider(),
//              ------
              Consts.Is_user_login ?
              buildListTilewithBg('Logout', Icons.logout, () {
                Navigator.of(widget.ccontext).pop();
                logoutdialog(context);
              }) :
              buildListTilewithBg('Login', Icons.login_outlined, () {
                Navigator.of(widget.ccontext).pop();

                if (!Consts.Is_user_login) {
                  Navigator.of(widget.ccontext).pushNamed(LoginPage.routeName, arguments: new RouteArgument(id: MyAccountPage.routeName));
                }
              }),
//
//          divider(),

//          buildListTilewithBg('Razor payment', Icons.account_box_outlined, () {
//            Navigator.of(widget.ccontext).pushNamed(razorPaymentDemo.routeName);
//          }),

//          divider(),
//          buildListTilewithBg('GoKart', Icons.account_box_outlined, () {
//            Navigator.of(widget.ccontext).pushNamed(MyHomePage.routeName);
//          }),

              divider(),
            ],
          )),
    );
  }

  void logoutdialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(Consts.app_name),
          content: new Text('Are you sure you want to logout?'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new MaterialButton(
              child: new Text('CANCEL'),
              textColor: Colors.red[700],
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            new MaterialButton(
              child: new Text('SIGN OUT'),
              textColor: Colors.red[700],
              onPressed: () async {
                Navigator.of(context).pop();
                logout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }

  Future<void> logout() async {
    Consts.Is_user_login = false;
    Consts.api_authentication_token = '';
    Consts.current_username = '';
    Consts.current_phonenumber = '';
    Consts.current_userid = '';

    MyPreferenceManager _myPreferenceManager = await MyPreferenceManager
        .getInstance();
    _myPreferenceManager.clearData();

    Navigator.pop(context);
//    Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.routeName, (Route<dynamic> route) => false);
  }

  Future<void> updateCustomerName() async {
    MyPreferenceManager _myPreferenceManager =
    await MyPreferenceManager.getInstance();
    String name =
    _myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_NAME);

    if (name.isEmpty) {
      name = 'Login';
    }

    setState(() {
      customer_name = name;
    });
  }
}
