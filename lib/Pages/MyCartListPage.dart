import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/Pages/LoginPage.dart';
import 'package:pocketuse/Providers/CartCountProvider.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/elements/MycartItemWidget.dart';
import 'package:pocketuse/elements/SortingBottomSheetDialog.dart';
import 'package:pocketuse/model/CardList/CardsViewRequest.dart';
import 'package:pocketuse/model/CardList/products.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'OrderSummaryPage.dart';

class MyCartListPage extends StatefulWidget {
  static const routeName = '/MyCartListPage';

  @override
  MyCartListPageState createState() {
    return MyCartListPageState();
  }
}

class MyCartListPageState extends StateMVC<MyCartListPage>
    implements CAllBackOfSortingSelection, UpdateTotal {

  List<Products> products = null;
  String sub_total ='';
  String total_amount ='';
  String delivery ='';
  String discount ='';

  bool IsIndicatorShow = false;

  @override
  void initState() {
    super.initState();
    getMyCardList();
  }

  CartCountProvider appState = null;
  @override
  Widget build(BuildContext context) {
    var linewidth = MediaQuery.of(context).size.width *0.20;
    appState = Provider.of<CartCountProvider>(context);


   return Scaffold(
     appBar: AppBar(
       automaticallyImplyLeading: true,
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
 //            Navigator.of(context).pushNamedAndRemoveUntil(
//                HomePage.routeName, (Route<dynamic> route) => false);
           Navigator.pop(context);
         },
       ),
       title: CommonWidget.getActionBarTitleText('My Cart'),
       flexibleSpace: CommonWidget.ActionBarBg(),
     ),
     body: Container(
       color: Colors.white70,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Visibility(child: CommonWidget.getPAymentTopView(0, context),
           visible: (products != null && products.isNotEmpty),),
           getProductListView(),
//           CommonWidget.customdividerwithCustomColor(
//               context, 1, Colors.grey[400]),

//           CommonWidget.customdivider(context, 2),
           Container(
             decoration: CommonWidget.containerShadow(),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 (products != null && products.isNotEmpty)? Padding(
                   padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                   child: Wrap(
                     direction: Axis.vertical,
                     children: [
                       Text(
                         Consts.currencySymbolWithoutSpace+total_amount,
                         style: TextStyle(
                             color: Colors.black,
                             fontSize: 18,
                             fontWeight: FontWeight.w600),
                       ),
//                       Text(
//                         'View price details',
//                         style: TextStyle(
//                             color: Consts.app_primary_color,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500),
//                       ),
                     ],
                   ),
                 ) : Container(),

                 Visibility(child: Padding(
                   padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
                   child: Center(
                     child: SizedBox(
                       width: MediaQuery.of(context).size.width * 0.40,
                       child: MaterialButton(
                         onPressed: () {


                           if(Consts.Is_user_login){

                             if(total_amount.length == 0 || total_amount =="0.00"){
                               Fluttertoast.showToast(
                                 msg: 'Please add item to cart',
                                 backgroundColor: Colors.black,
                                 textColor: Colors.white,);
                             }else{
                               Navigator.of(context).pushNamed(OrderSummaryPage.routeName);
//                               Navigator.of(context).pushNamed(OrderSummaryPage.routeName);
                             }

                           } else{
                             Navigator.of(context).pushNamed(LoginPage.routeName,  arguments: new RouteArgument(id: OrderSummaryPage.routeName ));
                           }
                         },
                         textColor: Colors.white,
                         padding: const EdgeInsets.all(0.0),
                         child: Container(
                           width: double.infinity,
                           decoration: BoxDecoration(
                               color:  Consts.orange_Button ,
                               borderRadius:
                               BorderRadius.all(Radius.circular(2.0))
                           ),
                           padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                           child: new Text('Place Order', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800 ),
                               textAlign: TextAlign.center),
                         ),),
                     ),
                   ),
                 ),
                   visible: (products != null && products.isNotEmpty),),
               ],
             ),
           ),
           CommonWidget.customdivider(context, 3),
         ],
       ),
     ),
   );
  }

  getPriceLayout(String s, String value) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(s),
          Text(Consts.currencySymbol + value),
        ],
      ),
    );
  }

  getPriceLayoutgreen(String s, String value) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(s),
          Text(
            Consts.currencySymbol + value,
            style: TextStyle(color: Colors.lightGreen),
          ),
        ],
      ),
    );
  }

  @override
  void sortingType(String sType) {}

  Future<void> getMyCardList() async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/carts/view');

    print('url $url');
    var card = new CardsViewRequest();
//    card.refrence_id = Consts.device_rendom_number;
//    card.user_id =CommonWidget.StringConvertintiInt(Consts.current_userid);

    card.refrence_id = Consts.device_rendom_number;
    card.user_id = CommonWidget.StringConvertintiInt(Consts.current_userid);

    print(card.toJson());
    const headers = {'Content-Type': 'application/json'};

    ProgressIndicator(true);
    var response =
        await http.post(url, headers: headers, body: json.encode(card));
    ProgressIndicator(false);

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap.containsKey("products")) {
        List<Object> resultList = userMap['products'];

        List<Products> mycategoriesList = new List(resultList.length);

        for (int i = 0; i < resultList.length; i++) {
          Object obj = resultList[i];
          Products g = new Products.fromJsonMap(obj);
          mycategoriesList[i] = g;
        }

        setState(() {
          products = mycategoriesList;
          sub_total = userMap['sub_total'];
          total_amount = userMap['total_amount'];
          discount = userMap['discount'];
          delivery = userMap['delivery'];

          if(appState != null){
            appState.setDisplayText(products.length);
          }
        });
      }else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
        setState(() {
          products = <Products>[];
          if(appState != null){
            appState.setDisplayText(products.length);
          }
        });
      }
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
        setState(() {
          products = <Products>[];
          if(appState != null){
            appState.setDisplayText(products.length);
          }
        });
      }
    }


  @override
  void onUpdateTotal(String total) {
    setState(() {
      total_amount = total;
    });

    getMyCardList(); // refresh list
  }

  @override
  void refresh() {
    getMyCardList(); // refresh list
  }

  Widget getProductListView() {
    if(products == null || IsIndicatorShow){
      return CircularLoadingWidget(
          height: MediaQuery.of(context).size.height * 0.65);
    } else if(products.isEmpty){
      return Expanded(
//        height: MediaQuery.of(context).size.height * 0.65,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/no_record_found_small_img.png'),
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              SizedBox(height: 20),
              Text(
                "No product found.",
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
      return Expanded(
          child: ListView(
            children: [
              Container(
//                margin: EdgeInsetsDirectional.only(top: 10),
                color: Colors.white70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: products.map((data) {
                      return MycartItemWidget(
                          products: data,
                          updateTotal: this
                      );
                    }).toList()),
              ),
              Container(
                color: Colors.grey[200],
                height: 6,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 13, 15, 13),
                child: Text(
                  'PRICE DETAILS',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              CommonWidget.customdivider(context, 2),
              SizedBox(
                height: 5,
              ),
              getPriceLayout("Price (1 item)",sub_total),
              getPriceLayoutgreen("Discount ",discount),
              getPriceLayout("Delivery Charges", delivery),
              SizedBox(
                height: 5,
              ),
            ],
          ));
    }

  }

  @override
  void ProgressIndicator(bool b) {
    setState(() {
      if(b){
        IsIndicatorShow = true;
      } else{
        IsIndicatorShow = false;
      }
    });
  }
}
