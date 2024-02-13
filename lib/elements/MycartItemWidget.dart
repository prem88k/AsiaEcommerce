import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/Pages/LoginPage.dart';
import 'package:pocketuse/Pages/MyCartListPage.dart';
import 'package:pocketuse/Pages/ProductDetailPage.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/model/RemoveCartRequest.dart';
import 'package:pocketuse/model/UpdateQuantityRequest.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:pocketuse/model/CardList/products.dart';
import 'package:http/http.dart' as http;

class UpdateTotal {
  void onUpdateTotal(String total) {}

  void refresh() {}

  void ProgressIndicator(bool b) {}
}

class MycartItemWidget extends StatefulWidget {
  Products products;
  UpdateTotal updateTotal;

  MycartItemWidget({Key key, this.products, this.updateTotal})
      : super(key: key);

  @override
  MycartItemWidgetState createState() {
    return MycartItemWidgetState();
  }
}

class MycartItemWidgetState extends State<MycartItemWidget> {
  double current_width;

  List<DropdownMenuItem<String>> dropdownlist = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    current_width = MediaQuery.of(context).size.width;
    QtyValue = widget.products.quantity.toString();

    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 120, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
//                direction: Axis.vertical,
                children: [

                  InkWell(child: Text(
                    widget.products.item.name,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),onTap: (){
                    Navigator.of(context).pushNamed(ProductDetailPage.routeName,
                        arguments: new RouteArgument(
                            id: widget.products.product_id.toString(), heroTag: widget.products.item.name));
                  },),
                  SizedBox(
                    height: 8,
                  ),

                  widget.products.variations.length>0 ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  widget.products.variations.map((data) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.attribute_name+": ",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400),
                              ),
                               Text(
                                data.option_name,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        );
                      }).toList()) : Container(),

                  SizedBox(
                    height: 12,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
//                style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: Consts.currencySymbolWithoutSpace +
                              widget.products.price.toString() +
                              "  ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: widget.products.getprevious_price(),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
//                        TextSpan(
//                          text: "  " + '00% off',
//                          style: TextStyle(
//                              color: Colors.lightGreen,
//                              fontSize: 12,
//                              fontWeight: FontWeight.w500),
//                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Visibility(
                    visible: CommonWidget.IsdiscountVisible(
                        widget.products.item.discount_percentage),
                    child: Text(
                      " " + widget.products.item.getdiscount() + '% off',
//                  Text(CommonWidget.replaceNullWithEmpty(widget.products.discount)+ '% off',
//                    '3 offers applied  . 2 offers available',
                      style: CommonWidget.getDiscountTextStyle(),
                    ),
                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  Text(
//                    'Delivery by Mon MMM DD | ' + Consts.currencySymbol + '00',
//                    style: TextStyle(
//                        fontSize: 12,
//                        color: Colors.black54,
//                        fontWeight: FontWeight.w400),
//                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            CommonWidget.customdivider(context, 1),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if (Consts.api_authentication_token.isEmpty) {
                        Navigator.of(context).pushNamed(LoginPage.routeName,
                            arguments: new RouteArgument(
                                id: MyCartListPage.routeName));
                      } else {
                        favApiCAll(
                            widget.products.id, widget.products.product_id);
                      }
                    },
                    child: Container(
                      width: current_width * 0.40,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save_alt,
                              size: 18,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Save for later',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 1,
                      height: 42,
                      color: Colors.grey[200],
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: current_width * 0.40,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              size: 18,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Remove',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      RemoveItemFromCart(widget.products.id);
                    },
                  ),
                ],
              ),
            ),

            Container(
              color: Colors.grey[200],
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
//            Container(
//              color: Colors.grey[200],
//              height: 6,
//              width: MediaQuery.of(context).size.width,
//            )
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: Column(
            children: [
              InkWell(
                child: Image.network(
                  widget.products.item.photo,
//                "http://18.191.233.163/assets/images/thumbnails/1568026368CzWwfWLG.jpg",
                  width: 55,
                  height: 75,
                  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CommonWidget.getloadingBulder(loadingProgress);
                  },
                ),
                onTap: (){
                  Navigator.of(context).pushNamed(ProductDetailPage.routeName,
                      arguments: new RouteArgument(
                          id: widget.products.product_id.toString(), heroTag: widget.products.item.name));
                },
              ),
              InkWell(
                child: Container(
                  width: 100,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    border: new Border.all(
                      color: Colors.grey[400],
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Qty: ' + QtyValue,
//                              +widget.products.quantity.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black87),
                        ),
                        getQuantityDropDown(),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 14,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> favApiCAll(int id, int productid) async {
    print('url ' + Consts.api_authentication_token);
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/wishlist/add');
    print('url $url');

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader:
          'Bearer ' + Consts.api_authentication_token
    };
    var map = new Map<String, dynamic>();
    map['product_id'] = productid.toString();
    print('url $map');
    print(Consts.api_authentication_token + "===");

    widget.updateTotal.ProgressIndicator(true);

    var response = await http.post(url, headers: requestHeaders, body: map);

    widget.updateTotal.ProgressIndicator(false);

    print(response.body + "..............");

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap["status"]) {
        Fluttertoast.showToast(
          msg: 'Add To Wishlist Successfully',
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        RemoveItemFromCart(id);
//        widget.updateTotal.refresh();

      } else {
        Map error = userMap["error"];
        if (error != null && error.containsKey('message')) {
          Fluttertoast.showToast(
            msg: error['message'],
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        }
      }
    } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);

    }
  }

  void changedDropDownItem(String selectedCity) {
    print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
//      _currentCity = selectedCity;
    });
  }

  Future<void> RemoveItemFromCart(int id) async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/removecart');
//        '?highlight''=$highlight&limit=$limit&type=$type&product_type=$product_type&paginate=$paginate';

    print('url $url');
    var removeCartRequest = new RemoveCartRequest(Consts.device_rendom_number,
        CommonWidget.StringConvertintiInt(Consts.current_userid), id);

    print(removeCartRequest.toJson());
    const headers = {'Content-Type': 'application/json'};

    widget.updateTotal.ProgressIndicator(true);

    var response = await http.post(url,
        headers: headers, body: json.encode(removeCartRequest));


    if (response.statusCode == 200) {
      //    widget.updateTotal.ProgressIndicator(false);
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

      if (userMap.containsKey('total_amount')) {
        widget.updateTotal.onUpdateTotal(userMap['total_amount']);
//        setState(() {
//
//        });
      }

      Fluttertoast.showToast(
        msg: userMap['msg'],
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      //refresh list handle response
//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
//      if (userMap["status"]) {

//      } else {
////        Toast.show(Api_constant.no_record_found, context,
////            gravity: Toast.CENTER);
//        setState(() {
//          products = <Products>[];
//        });
//      }
//    } else {
////    Toast.show(Api_constant.something_went_wrong, context,
////        gravity: Toast.CENTER);
//      setState(() {
//        products = <Products>[];
//      });
    } else{
          widget.updateTotal.ProgressIndicator(false);
    }
  }

  String MoreValue = 'more';
  String QtyValue = '';

  Widget getQuantityDropDown() {
    addValueInquantityDropDown();

    return Center(
      child: Container(
          width: 27,
          child: dropdownlist.isNotEmpty
              ? DropdownButton<String>(
                  items: dropdownlist,
                  onChanged: (String value) {
                    if (value == 'more') {
                      _showDialog();
                    } else {
                      setState(() {
                        QtyValue = value;
                      });
                      UpdateItemFromCart(widget.products.id, value);
                    }
                  },
                  hint: Text('Select Item'),
                  value: "",
                  elevation: 0,
                  underline: Container(),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 0,
                  ),
                  isDense: false,
                  isExpanded: true,
                )
              : Container()),
    );
  }

  void addValueInquantityDropDown() {
    if (widget.products.item.stock != null) {
      dropdownlist.clear();
      dropdownlist.add(
        DropdownMenuItem<String>(
          child: SizedBox(
            child: Text(
              '',
            ),
            width: current_width * 0.20,
          ),
          value: '',
        ),
      );

      if (widget.products.item.stock > 0) {
        dropdownlist.add(
          DropdownMenuItem<String>(
            child: SizedBox(
              child: Text(
                '1',
              ),
              width: current_width * 0.20,
            ),
            value: '1',
          ),
        );
      }

      if (widget.products.item.stock > 1) {
        dropdownlist.add(
          DropdownMenuItem<String>(
            child: SizedBox(
              child: Text(
                '2',
              ),
              width: current_width * 0.20,
            ),
            value: '2',
          ),
        );
      }

      if (widget.products.item.stock > 2) {
        dropdownlist.add(
          DropdownMenuItem<String>(
            child: SizedBox(
              child: Text(
                '3',
              ),
              width: current_width * 0.20,
            ),
            value: '3',
          ),
        );
      }
      if (widget.products.item.stock > 3) {
        dropdownlist.add(
          DropdownMenuItem<String>(
            child: SizedBox(
              child: Text(
                MoreValue,
                style: TextStyle(fontSize: 12),
              ),
              width: current_width * 0.40,
            ),
            value: MoreValue,
          ),
        );
      }
    }
  }

  final TextEditingController QutController = TextEditingController();

  _showDialog() async {
    await showDialog<String>(
      builder: (context) => Container(
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            'ENTER QUANTITY',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
//                  autofocus: true,
//                  decoration: new InputDecoration(
//                      labelText: 'Full Name', hintText: 'eg. John Smith'),
                  keyboardType: TextInputType.number,
                  controller: QutController,
                  onChanged: (value) {
//                    if(int.parse(value) > widget.products.quantity){
//                      Fluttertoast.showToast(
//                        msg: "We're sorry! Only "+ widget.products.quantity.toString()+" items available",
//                        backgroundColor: Colors.black,
//                        textColor: Colors.white,
//                      );
//                    } else{

//                      UpdateItemFromCart(widget.products.id, value);
//                    }
                  },
                ),
              )
            ],
          ),
          actions: <Widget>[
            new MaterialButton(
                child: const Text(
                  'CANCEL',
                  style: TextStyle(
                      color: Colors.black87,
                      wordSpacing: 0.4,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new MaterialButton(
                child: const Text('APPLY',
                    style: TextStyle(
                        color: Consts.app_primary_color,
                        wordSpacing: 0.4,
                        fontWeight: FontWeight.w400)),
                onPressed: () {
                  if (QutController.text.isNotEmpty) {
                    setState(() {
                      QtyValue = QutController.text;
                    });
                    UpdateItemFromCart(widget.products.id, QutController.text);
                  }

                  Navigator.pop(context);
                })
          ],
        ),
      ), context: context,
    );
  }

  Future<void> UpdateItemFromCart(int id, String value) async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/updatequantitycart');
//        '?highlight''=$highlight&limit=$limit&type=$type&product_type=$product_type&paginate=$paginate';

    print('url $url');
    var removeCartRequest = new UpdateQuantityRequest(
        Consts.device_rendom_number,
        CommonWidget.StringConvertintiInt(Consts.current_userid),
        id,
        int.parse(value));

    print(removeCartRequest.toJson());
    const headers = {'Content-Type': 'application/json'};

    widget.updateTotal.ProgressIndicator(true);

    var response = await http.post(url,
        headers: headers, body: json.encode(removeCartRequest));

    widget.updateTotal.ProgressIndicator(false);

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");

      Map userMap = jsonDecode(response_json_str);

      if (userMap.containsKey('error')) {
        if (userMap['error'] == 0) {
          widget.updateTotal.refresh();
        }
      }

      Fluttertoast.showToast(
        msg: userMap['msg'],
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );

      //refresh list handle response
//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
//      if (userMap["status"]) {

//      } else {
////        Toast.show(Api_constant.no_record_found, context,
////            gravity: Toast.CENTER);
//        setState(() {
//          products = <Products>[];
//        });
//      }
//    } else {
////    Toast.show(Api_constant.something_went_wrong, context,
////        gravity: Toast.CENTER);
//      setState(() {
//        products = <Products>[];
//      });
    }
  }
}
