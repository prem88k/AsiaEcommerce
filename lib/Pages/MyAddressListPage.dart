import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/elements/AddressListItemWidget.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/model/AddressListObj.dart';
import 'package:pocketuse/model/addressListArgument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:http/http.dart' as http;

import 'AddAddressPage.dart';

class MyAddressListPage extends StatefulWidget{
  static const routeName = '/MyAddressListPage';

  String SelectedAddress = '';
  addressListArgument addresslistargs;

  MyAddressListPage({Key key, this.addresslistargs}) : super(key: key);

  @override
  MyAddressListPageState createState() {
    return MyAddressListPageState();
  }
}

class MyAddressListPageState extends StateMVC<MyAddressListPage> implements UpdateList{
  List<AddressListObj> addressList = null;

  @override
  void initState() {
    getAddress();
    super.initState();
    widget.SelectedAddress = widget.addresslistargs.selectedAddressid;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
              if(widget.addresslistargs.IsSelectionEnable){
                if(addressList != null && addressList.length != 0){
                  for(int k =0;k<addressList.length; k++){
                    if(addressList[k].id.toString() == widget.SelectedAddress){
                      Navigator.pop(context, addressList[k]);
                    }
                  }
                } else{
                 //please add shipping address
                  Fluttertoast.showToast(
                    msg: "please add shipping address",
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                  );
                }

              } else{
                Navigator.pop(context);
              }
//            _awaitGoToAddAddressPage();
            },
          ),
          title: CommonWidget.getActionBarTitleText('My Addresses'),
          flexibleSpace: CommonWidget.ActionBarBg(),
        ),
        body: ListView(
//        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              direction : Axis.vertical,
              children: [
                Padding(padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
                  child: InkWell(
                    onTap: (){
                      _awaitGoToAddAddressPage();
//              Navigator.of(context).pushNamed( AddAddressPage.routeName);
                    },
                    child: Row(
                      children: [
//                Icon(Icons.add, color: Consts.app_primary_color, size: 15, ),
//                SizedBox(width: 5,),
                        Text('+  Add a new address', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Consts.app_primary_color),)
                      ],
                    ),
                  ),),
                CommonWidget.customdividerwithCustomColor(context, 2, Colors.grey[300]),
                Container(
                  width:  MediaQuery.of(context).size.width,
                  color: Consts.divider_or_bgcolor,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 5),
                    child: Text(addressList != null ?addressList.length.toString()+' SAVED ADDRESSES':' SAVED ADDRESSES',
                      style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600, color: Colors.grey[700]),),
                  ),
                ),
              ],
            ),
            getAddistView(),


          ],
        ),
      ),
      onWillPop: _onWillPop,
    );
  }
  Future<bool> _onWillPop() async {
    if(widget.addresslistargs.IsSelectionEnable){
      if(addressList != null && addressList.length != 0){
        for(int k =0;k<addressList.length; k++){
          if(addressList[k].id.toString() == widget.SelectedAddress){
            Navigator.pop(context, addressList[k]);
          }
        }
      } else{
        //please add shipping address
        Fluttertoast.showToast(msg: "please add shipping address", backgroundColor: Colors.black, textColor: Colors.white,);
      }

    } else{
      Navigator.pop(context);
    }
    return true;
  }
  Future<void> getAddress() async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/addresses');

    print('url $url');
    print('api_authentication_token== '+Consts.api_authentication_token);

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: 'Bearer '+ Consts.api_authentication_token
    };

    var response = await http.get(url, headers: requestHeaders);
    print('statusCode1== '+response.statusCode.toString());

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap["status"]) {
        List<Object> resultList = data['data'];

        List<AddressListObj> mycategoriesList = new List(resultList.length);

        for (int i = 0; i < resultList.length; i++) {
          Object obj = resultList[i];
          AddressListObj g = new AddressListObj.fromJsonMap(obj);


          if(widget.addresslistargs.IsSelectionEnable){

            if(resultList.length ==1){
              g.ISSelected = true;
              widget.SelectedAddress = g.id.toString();
            }
          }

          mycategoriesList[i] = g;
        }

        setState(() {
          addressList = mycategoriesList;
        });

      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
        setState(() {
          addressList = <AddressListObj>[];
        });
      }
    } else {
      setState(() {
        addressList = <AddressListObj>[];
      });
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);
    }
  }
  Widget getAddistView() {
    if(addressList == null){
      return CircularLoadingWidget(
          height: MediaQuery.of(context).size.height * 0.75);

    } else if(addressList.isEmpty){

      return Container(
        height: MediaQuery.of(context).size.height * 0.65,
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
      return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: this.addressList.length,
        itemBuilder: (context, index) {
          return AddressListItemWidget(
            category: this.addressList.elementAt(index),
              updateList: this,
              Selectedid: widget.SelectedAddress
          );
        },
      );
//      return Container(
////            margin: EdgeInsetsDirectional.only(top: 10),
//        color: Consts.divider_or_bgcolor,
//        child:   ,
//
//      );
    }
  }
  void _awaitGoToAddAddressPage() async{
      await Navigator.of(context).pushNamed(AddAddressPage.routeName ,arguments: null);

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      getAddress();

//      widget.product.in_wishlist = result;
    });

  }

  @override
  onRemoveItem() {
    getAddress();
  }

  @override
  onEditItem(AddressListObj addressListObj) async {
    await Navigator.of(context).pushNamed(AddAddressPage.routeName, arguments: addressListObj);

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      getAddress();

//      widget.product.in_wishlist = result;
    });
  }

  @override
  onUpdateUi(String id) {
    if(widget.addresslistargs.IsSelectionEnable){
      setState(() {
        widget.SelectedAddress = id;
      });
    }

  }
}