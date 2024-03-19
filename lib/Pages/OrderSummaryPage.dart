import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/Providers/CartCountProvider.dart';
import 'package:pocketuse/Utils/Api_constant.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/Utils/MyPreferenceManager.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/elements/CircularLoadingWidgetWithdarkbg.dart';
import 'package:pocketuse/elements/MycartItemWidgetForOrderSummery.dart';
import 'package:pocketuse/elements/SortingBottomSheetDialog.dart';
import 'package:pocketuse/model/AfterPaymentApi.dart';
import 'package:pocketuse/model/CardList/CardsViewRequest.dart';
import 'package:pocketuse/model/CardList/products.dart';
import 'package:pocketuse/model/CheckOutBeforPaymentApiResponse.dart';
import 'package:pocketuse/model/CheckOutBeforePaymentApi.dart';
import 'package:pocketuse/model/addressListArgument.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:pocketuse/model/AddressListObj.dart';
import 'package:provider/provider.dart';

//import 'package:flutter_razorpay_sdk/flutter_razorpay_sdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'LoginPage.dart';
import 'MyAddressListPage.dart';
import 'MyOrdersPage.dart';

class OrderSummaryPage extends StatefulWidget {
  static const routeName = '/OrderSummaryPage';

  @override
  OrderSummaryPageState createState() {
    return OrderSummaryPageState();
  }
}

class OrderSummaryPageState extends State<OrderSummaryPage>
    implements CAllBackOfSortingSelection {
  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;
  String customer_number = '';
  String customer_email = '';

  List<Products> products = null;
  String cart_id = "";

  String sub_total = '';
  String total_amount = '';
  String delivery = '';
  String discount = '';
  Products g;
  String address_title = '';
  String address_description = '';
  String address_phone = '';
  String address_id = '';

  bool IsIndicatorShow = false;
  bool IsProgressShow = false;
  bool Iscash_on_delivery = false;
  int _radioValue = 0;

  CheckOutBeforPaymentApiResponse _checkOutBeforPaymentApiResponse = null;
  String razorpay_order_id = "";

  Future<void> updateCustomerNumber() async {
    MyPreferenceManager _myPreferenceManager =
        await MyPreferenceManager.getInstance();
    String number = _myPreferenceManager
        .getString(MyPreferenceManager.LOGIN_USER_PHONE_NUBER);
    String email =
        _myPreferenceManager.getString(MyPreferenceManager.LOGIN_USER_EMAIL);

    setState(() {
      customer_number = CommonWidget.replaceNullWithEmpty(number);
      customer_email = CommonWidget.replaceNullWithEmpty(email);
    });
  }

  @override
  void initState() {
    super.initState();
    getMyCardList();
    updateCustomerNumber();
    getAddress();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  CartCountProvider appState = null;

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<CartCountProvider>(context);
    var linewidth = MediaQuery.of(context).size.width * 0.20;

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
        title: CommonWidget.getActionBarTitleText('Order Summary'),
        flexibleSpace: CommonWidget.ActionBarBg(),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white70,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getProductListView(),
                CommonWidget.customdivider(context, 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            Consts.currencySymbolWithoutSpace + total_amount,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'View price details',
                            style: TextStyle(
                                color: Consts.app_primary_color,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.32,
                          child: MaterialButton(
                            onPressed: () {
                              if (Consts.Is_user_login) {
                                if (address_id.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: 'Please Choose adress befor continue',
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                } else {
                                  checkoutApiCAllBeforPayment();
                                }
                              } else {
                                Navigator.of(context).pushNamed(
                                    LoginPage.routeName,
                                    arguments: new RouteArgument(id: ""));
                              }
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.32,
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange[400],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0))),
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: new Text('CONTINUE',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                CommonWidget.customdivider(context, 3),
              ],
            ),
          ),
          IsProgressShow
              ? CircularLoadingWidget(
                  height: MediaQuery.of(context).size.height * 0.95)
              : Container()
        ],
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

//        '?highlight''=$highlight&limit=$limit&type=$type&product_type=$product_type&paginate=$paginate';

    print('url $url');
    var card = new CardsViewRequest();
//    card.refrence_id = Consts.device_rendom_number;
//    card.user_id =CommonWidget.StringConvertintiInt(Consts.current_userid);

    card.refrence_id = Consts.device_rendom_number;
    card.user_id = CommonWidget.StringConvertintiInt(Consts.current_userid);

    print(card.toJson());
    const headers = {'Content-Type': 'application/json'};

    var response =
        await http.post(url, headers: headers, body: json.encode(card));

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

      if (userMap.containsKey("is_cash_on_delivery_enable")) {
        var is_cash_on_delivery_enable = userMap['is_cash_on_delivery_enable'];
        if (is_cash_on_delivery_enable != null &&
            is_cash_on_delivery_enable == 1) {
          setState(() {
            Iscash_on_delivery = true;
          });
        }
      }
//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap.containsKey("products")) {
        List<Object> resultList = userMap['products'];

        List<Products> mycategoriesList = new List(resultList.length);

        for (int i = 0; i < resultList.length; i++) {
          Object obj = resultList[i];
          g = new Products.fromJsonMap(obj);
          mycategoriesList[i] = g;
        }

        setState(() {
          products = mycategoriesList;
          cart_id=userMap['products'][0]['cart_id'].toString();
          sub_total = userMap['sub_total'];
          total_amount = userMap['total_amount'];
          discount = userMap['discount'];
          delivery = userMap['delivery'];
        });
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
        setState(() {
          products = <Products>[];
        });
      }
    } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
      setState(() {
        products = <Products>[];
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
    if (products == null || IsIndicatorShow) {
      return CircularLoadingWidget(
          height: MediaQuery.of(context).size.height * 0.8);
    } else if (products.isEmpty) {
      return Expanded(
//        height: MediaQuery.of(context).size.height * 0.65,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image(
                image:
                    AssetImage('assets/images/no_record_found_small_img.png'),
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
    } else {
      return Expanded(
          child: ListView(
        children: [
          CommonWidget.getPAymentTopView(1, context),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CommonWidget.replaceNullWithEmpty(address_title),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 7,
                ),
                Text((address_description == null ||
                        address_description.isEmpty)
                    ? "No address"
                    : CommonWidget.replaceNullWithEmpty(address_description)),
                SizedBox(
                  height: 7,
                ),
                Text(address_phone),
                SizedBox(
                  height: 14,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.orange[50],
                      border:
                          new Border.all(color: Colors.orange[200], width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
                  child: new Text(
                      'Please check if the address is suitable for collecting delivery',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                      textAlign: TextAlign.left),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        _awaitGoToAddressList();
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Consts.app_primary_color,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                        child: new Text('Change or Add Address',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CommonWidget.customdividerwithCustomColor(
              context, 1, Colors.grey[400]),
          Container(
            color: Colors.grey[200],
            height: 7,
            width: MediaQuery.of(context).size.width,
          ),
//          SizedBox(
//            height: 2,
//          ),
          Container(
            margin: EdgeInsetsDirectional.only(top: 10),
            color: Colors.white70,
            child: Column(
                children: products.map((data) {
              return MycartItemWidgetForOrderSummery(
                products: data,
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
          getPriceLayout("Price (1 item)", sub_total),
          getPriceLayoutgreen("Discount ", discount),
          getPriceLayout("Delivery Charges", delivery),
          SizedBox(
            height: 5,
          ),
          Visibility(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey[200],
                height: 6,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 13, 15, 5),
                child: Text(
                  'CHOOSE PAYMENT TYPE',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(value: 0, activeColor : Consts.app_primary_color,
                            groupValue: _radioValue, onChanged: _handleRadioValueChange1,),
                          Text('Cash', style: new TextStyle(fontSize: 16.0, ),),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(value: 1, activeColor : Consts.app_primary_color, groupValue: _radioValue, onChanged: _handleRadioValueChange1,),
                          Text('Online      ', style: new TextStyle(fontSize: 16.0,   ),
                          ),
                        ],
                      )
                    ],
                  )),
//              CommonWidget.customdivider(context, 2),
              SizedBox(
                height: 5,
              ),
            ],
          ),visible: Iscash_on_delivery,)
        ],
      ));
    }
  }
  void _handleRadioValueChange1(Object value) {
    setState(() {
      switch (_radioValue) {
        case 0:
        //ship
          _radioValue =1;
          break;
        case 1:
        //collect

          _radioValue =0;
          break;
      }
    });
  }
  int getPrice() {
    String temp =_checkOutBeforPaymentApiResponse.pay_amount.toString();
    double finalprice = double.parse(temp) *
        double.parse('100');
//    double finalprice = double.parse(total_amount) * double.parse('100');
    return finalprice.toInt();
  }

  void openCheckout() async {
    print(razorpay_order_id);
    print("razorpay_order_id===================2");
    if (_checkOutBeforPaymentApiResponse == null) {
      return;
    }

    var options = {
      'key': 'rzp_test_ZFZ2yyCIffZ723',
      //pocketuse client
      'amount': getPrice(),
//      'amount': 2000,
//      'name': '',
//      'description': '',
//      'order_id': _checkOutBeforPaymentApiResponse.order_number, // Generate order_id using Orders API
      'order_id': razorpay_order_id,
      // Generate order_id using Orders API
//      'name': 'Acme Corp.',
//      'description': 'Fine T-Shirt',
      'prefill': {
        'contact': _checkOutBeforPaymentApiResponse.customer_phone,
        'email': _checkOutBeforPaymentApiResponse.customer_email
      },
//      'prefill': {'contact': customer_number, 'email': customer_email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
      msg: "SUCCESS: " + response.paymentId,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );

    print("=======================================1");
    print(response.paymentId);
    print("=======================================2");
    print(response.orderId);
    print("=======================================3");
    print(response.signature);
    print("=======================================4");

    checkoutUpdateApiCAllAfterPayment(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + response.walletName,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  @override
  void ProgressIndicator(bool b) {
    setState(() {
      if (b) {
        IsIndicatorShow = true;
      } else {
        IsIndicatorShow = false;
      }
    });
  }

  Future<void> checkoutApiCAllBeforPayment() async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/checkout');

    print('url $url');
    var card = new CheckOutBeforePaymentApi();
    card.address_id = address_id.isNotEmpty ? int.parse(address_id) : 0;
    card.user_id = CommonWidget.StringConvertintiInt(Consts.current_userid);
    card.cart_id = cart_id;

    if(Iscash_on_delivery && _radioValue == 0){
      card.payment_method = "cash_on_delivery" ;
    } else{
      card.payment_method =   "online";
    }

    print(card.toJson());
    const headers = {'Content-Type': 'application/json'};

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader:
          'Bearer ' + Consts.api_authentication_token,
      'Content-Type': 'application/json'
    };

    setState(() {
      IsProgressShow = true;
    });

    var response =
        await http.post(url, headers: requestHeaders, body: json.encode(card));

    setState(() {
      IsProgressShow = false;
    });

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap.containsKey("data")) {
        if(Iscash_on_delivery && _radioValue == 0){
          Object obj = userMap['data'];
          _checkOutBeforPaymentApiResponse = new CheckOutBeforPaymentApiResponse.fromJsonMap(obj);
          checkoutUpdateApiCAllAfterPayment(null);

        } else{
          Object obj = userMap['data'];
          _checkOutBeforPaymentApiResponse = new CheckOutBeforPaymentApiResponse.fromJsonMap(obj);
          razorpay_order_id = CommonWidget.replaceNullWithEmpty(_checkOutBeforPaymentApiResponse.razorpay_order_id);
          print(razorpay_order_id);
          print("razorpay_order_id===================1");
          openCheckout();
        }


      } else {
        Fluttertoast.showToast(
          msg: Api_constant.something_went_wrong,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: Api_constant.something_went_wrong,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  Future<void> checkoutUpdateApiCAllAfterPayment(
      PaymentSuccessResponse rresponse) async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/checkout/update/');

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader:
          'Bearer ' + Consts.api_authentication_token,
//      'Content-Type': 'application/json'
    };

    var map = new Map<String, dynamic>();
    map['order_id'] = razorpay_order_id; //processing
    map['payment_status'] = "completed"; //processing
    map['track_text'] = "You have successfully paid amount RS. " +
        getPrice().toString(); //rresponse.paymentId;

    if(rresponse == null ){
      map['txnid'] ="";

    }else{
      map['txnid'] = rresponse.paymentId;

    }

    print(map);
    print(url);
//    const headers = {'Content-Type': 'application/json'};

    setState(() {
      IsProgressShow = true;
    });

    var response = await http.post(url, headers: requestHeaders, body: map);

    setState(() {
      IsProgressShow = false;
    });

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

      if (userMap.containsKey("status") && userMap["status"]) {
        var data = userMap['data'];
        var CommanModal_obj =
            new AfterPaymentApi.fromJsonMap(data) as AfterPaymentApi;

        updateCartItemCount();

        Fluttertoast.showToast(
          msg: CommanModal_obj.text,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

//        Navigator.of(context)
//            .pushNamedAndRemoveUntil(MyOrdersPage.routeName, (Route<dynamic> route) => false);
        Navigator.pop(context);
        Navigator.of(context).pushReplacementNamed(MyOrdersPage.routeName);
      } else {
        Fluttertoast.showToast(
          msg: Api_constant.something_went_wrong,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: Api_constant.something_went_wrong,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  Future<void> getAddress() async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/addresses');
    print('url $url');
    print('api_authentication_token== ' + Consts.api_authentication_token);

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader:
          'Bearer ' + Consts.api_authentication_token
    };

    var response = await http.get(url, headers: requestHeaders);
    print('statusCode== ' + response.statusCode.toString());

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap["status"]) {
        List<Object> resultList = data['data'];

        Object obj = resultList[0];
        AddressListObj g = new AddressListObj.fromJsonMap(obj);

        setState(() {
          address_title = g.fullname;
          address_description = g.address;
          address_phone = g.phone;
          address_id = g.id.toString();
        });
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
      }
    } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);
    }
  }

  void _awaitGoToAddressList() async {
    var obj = await Navigator.of(context).pushNamed(MyAddressListPage.routeName,
        arguments: new addressListArgument(
            IsSelectionEnable: true, selectedAddressid: address_id));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      if (obj != null) {
        obj as AddressListObj;
        address_title = (obj as AddressListObj).fullname;
        address_description = (obj as AddressListObj).address;
        address_phone = (obj as AddressListObj).phone;
        address_id = (obj as AddressListObj).id.toString();
      }
    });
  }

  Future<void> updateCartItemCount() async {
    MyPreferenceManager _myPreferenceManager =
        await MyPreferenceManager.getInstance();
    _myPreferenceManager.setInt(MyPreferenceManager.CART_COUNT, 0);

    if (appState != null) {
      appState.setDisplayText(0);
    }
  }
}
