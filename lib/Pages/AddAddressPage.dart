import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/controllers/CategoryController.dart';
import 'package:pocketuse/model/AddAddressRequestObj.dart';
import 'package:pocketuse/model/AddressListObj.dart';
import 'package:pocketuse/model/EditAddressRequest.dart';
import 'package:pocketuse/model/StateObj.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:http/http.dart' as http;

class AddAddressPage extends StatefulWidget {
  static const routeName = '/AddAddressPage';

  AddressListObj addressListObj;

  AddAddressPage({Key key, this.addressListObj}) : super(key: key);

  @override
  AddAddressPageState createState() {
    return AddAddressPageState();
  }
}

class AddAddressPageState extends StateMVC<AddAddressPage> {
  CategoryController _con;

  AddAddressPageState() : super(CategoryController()) {
    _con = controller;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController phonealternativenumberController =
      TextEditingController();
  final TextEditingController buildingNumerController = TextEditingController();
  final TextEditingController roadAreaNameController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  int state_id = null;

  bool IsAddressHome = true;
  List<StateObj> stateList = null;

  @override
  void initState() {
    super.initState();
    getState();

    if(widget.addressListObj != null ){
      nameController.text = widget.addressListObj.fullname;
      phonenumberController.text = widget.addressListObj.phone;
      phonealternativenumberController.text = widget.addressListObj.alter_phone;
      buildingNumerController.text = widget.addressListObj.house_building_name;
      roadAreaNameController.text = widget.addressListObj.address;
      state_id = widget.addressListObj.state;
      stateController.text = widget.addressListObj.state_name;
      cityController.text = widget.addressListObj.city;
      pincodeController.text = widget.addressListObj.pincode.toString();

      if(widget.addressListObj.address_type == 1){
        IsAddressHome =false;

      } else{
        IsAddressHome =true;
      }
    }
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
              Navigator.pop(context);
            },
          ),
          title: CommonWidget.getActionBarTitleText(widget.addressListObj == null ? 'Add delivery address' :  'Edit delivery address'),
          flexibleSpace: CommonWidget.ActionBarBg(),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 25),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Full Name(Required)*",
                  hintText: "",
                  contentPadding: EdgeInsets.fromLTRB(10.0, 1, 10, 1),
                  labelStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
                controller: nameController,
              ),
              divider(),
              TextField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Phone number(Required)*",
                  hintText: "",
                  contentPadding: EdgeInsets.fromLTRB(10.0, 1, 10, 1),
                  labelStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
                controller: phonenumberController,
              ),
              divider(),
              TextField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Alternate Phone number",
                  hintText: "",
                  contentPadding: EdgeInsets.fromLTRB(10.0, 1, 10, 1),
                  labelStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
                controller: phonealternativenumberController,
              ),
              divider(),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "House No., Building Name(Required)*",
                  hintText: "",
                  contentPadding: EdgeInsets.fromLTRB(10.0, 1, 10, 1),
                  labelStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
                controller: buildingNumerController,
              ),
              divider(),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Road Name, Area, Colony(Required)*",
                  hintText: "",
//                  suffixIcon: Icon(
//                    Icons.search,
//                    size: 16,
//                  ),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 1, 10, 1),
                  labelStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
                controller: roadAreaNameController,
              ),
              divider(),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: TextField(
                        enabled: false,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "State(Required)*",
                          hintText: "",
                          contentPadding: EdgeInsets.fromLTRB(10.0, 1, 10, 1),
                          labelStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 14),
                        ),
                        controller: stateController,
                        autofocus: false,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('State List'),
                                  content: openStateSelectionDialog(),
//                                actions: [
//                                  MaterialButton(
//                                    child: Text("OK"),
//                                    onPressed: () {
//                                      Navigator.pop(context);
//                                    },
//                                  ),
//                                ],
                                );
                              });
                        },
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('State List'),
                                content: openStateSelectionDialog(),
//                                actions: [
//                                  MaterialButton(
//                                    child: Text("OK"),
//                                    onPressed: () {
//                                      Navigator.pop(context);
//                                    },
//                                  ),
//                                ],
                              );
                            });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "City(Required)*",
                        hintText: "",
//                        suffixIcon: Icon(
//                          Icons.search,
//                          size: 16,
//                        ),
                        contentPadding: EdgeInsets.fromLTRB(10.0, 1, 10, 1),
                        labelStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 14),
                      ),
                      controller: cityController,
                    ),
                  )
                ],
              ),
              divider(),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Pincode(Required)*",
                        hintText: "",
                        contentPadding: EdgeInsets.fromLTRB(10.0, 1, 10, 1),
                        labelStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 14),
                      ),
                      controller: pincodeController,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  )
                ],
              ),
              divider(),
              Text(
                'Type of address',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[500]),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        IsAddressHome = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            IsAddressHome ? Colors.grey[600] : Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        border: new Border.all(
                          color:
                              IsAddressHome ? Colors.white : Colors.grey[300],
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 5, 12, 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home,
                              size: 20,
                              color: IsAddressHome
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: IsAddressHome
                                      ? Colors.white
                                      : Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            !IsAddressHome ? Colors.grey[600] : Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        border: new Border.all(
                          color:
                              !IsAddressHome ? Colors.white : Colors.grey[300],
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 5, 12, 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.work,
                              size: 20,
                              color: !IsAddressHome
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Work',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: !IsAddressHome
                                      ? Colors.white
                                      : Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        IsAddressHome = false;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        if(widget.addressListObj != null ){
                          editAPiCall();
                        } else{
                          addAddressApiCAll();
                        }

                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.orange[700],
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                        child: new Text('Save Address',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

  Future<bool> _onWillPop() async {
    print("_onWillPop===========");
    Navigator.pop(context);
    return true;
  }

  Widget divider() {
    return SizedBox(
      height: 22,
    );
  }

  void showValidationMsg(){
    Fluttertoast.showToast(msg: 'Please provide the necessary details', backgroundColor: Colors.black, textColor: Colors.white,);
  }

  Future<void> addAddressApiCAll() async {
    print('***********');

    if(nameController.text.toString().isEmpty || phonenumberController.text.toString().isEmpty ||
        buildingNumerController.text.toString().isEmpty || roadAreaNameController.text.toString().isEmpty ||
        state_id == null || cityController.text.toString().isEmpty || pincodeController.text.toString().isEmpty){

      showValidationMsg();
      return;

    }

    AddAddressRequestObj addaddressrequestobj = new AddAddressRequestObj(
        fullname: nameController.text.toString(),
        phone: phonenumberController.text.toString(),
        alter_phone: phonealternativenumberController.text.toString().isNotEmpty
            ? int.parse(phonealternativenumberController.text.toString())
            : 0,
//        Int.value(phonealternativenumberController.text.toString()),
        house_building_name: buildingNumerController.text.toString(),
        address: buildingNumerController.text.toString() +
            roadAreaNameController.text.toString(),
        state: state_id,
        city: cityController.text.toString(),
        pincode: pincodeController.text.toString().isNotEmpty
            ? int.parse(pincodeController.text.toString())
            : 0,
        address_type: IsAddressHome ? 2 : 1);
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/addresses/add');

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader:
          'Bearer ' + Consts.api_authentication_token,
      'Content-Type': 'application/json'
    };

    print('url $url');
    print(addaddressrequestobj.toJson());

    var response = await http.post(url,
        headers: requestHeaders, body: json.encode(addaddressrequestobj));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      Map data = userMap["data"];

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap["status"]) {
        if (data.containsKey('message')) {
          Fluttertoast.showToast(
            msg: data['message'],
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        }

        Navigator.pop(context);
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
      }
    } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);
    }
  }
  Future<void> editAPiCall() async {
    print('***********editAPiCall');

    if(nameController.text.toString().isEmpty || phonenumberController.text.toString().isEmpty ||
        buildingNumerController.text.toString().isEmpty || roadAreaNameController.text.toString().isEmpty ||
        state_id == null || cityController.text.toString().isEmpty || pincodeController.text.toString().isEmpty){

      showValidationMsg();
      return;

    }

    EditAddressRequest Editaddressrequestobj = new EditAddressRequest(
        address_id: widget.addressListObj.id.toString(),
        fullname: nameController.text.toString(),
        phone: phonenumberController.text.toString(),
        alter_phone: phonealternativenumberController.text.toString().isNotEmpty
            ? int.parse(phonealternativenumberController.text.toString())
            : 0,
//        Int.value(phonealternativenumberController.text.toString()),
        house_building_name: buildingNumerController.text.toString(),
        address: buildingNumerController.text.toString() +
            roadAreaNameController.text.toString(),
        state: state_id,
        city: cityController.text.toString(),
        pincode: pincodeController.text.toString().isNotEmpty
            ? int.parse(pincodeController.text.toString())
            : 0,
        address_type: IsAddressHome ? 2 : 1);
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/addresses/edit');

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader:
      'Bearer ' + Consts.api_authentication_token,
      'Content-Type': 'application/json'
    };
//    const headers = {'Content-Type': 'application/json'};

    print('editAPiurl $url');
    print('editAPiParam');
    print(Editaddressrequestobj.toJson());

    var response = await http.post(url,
        headers: requestHeaders, body: json.encode(Editaddressrequestobj));

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      Map data = userMap["data"];

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap["status"]) {
        if (data.containsKey('message')) {
          Fluttertoast.showToast(
            msg: data['message'],
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        }

        Navigator.pop(context);
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);
      }
    } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);
    }
  }

  Future<void> getState() async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/states');
    print('url $url');

    var response = await http.get(url);
    print('statusCode== ' + response.statusCode.toString());

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      List<Object> resultList = jsonDecode(response_json_str);

      List<StateObj> mycategoriesList = new List(resultList.length);

      for (int i = 0; i < resultList.length; i++) {
        Object obj = resultList[i];
        StateObj g = new StateObj.fromJsonMap(obj);
        mycategoriesList[i] = g;
      }
//      if(widget.addressListObj != null ){
//        stateController.text = widget.addressListObj.state_name;
//      }
      setState(() {
        stateList = mycategoriesList;
      });
    } else {
      setState(() {
        stateList = <StateObj>[];
      });
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);
    }
  }

  Widget openStateSelectionDialog() {
    return Container(
      height: 500.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: stateList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 14, 8, 14),
              child: Text(
                stateList[index].state_name,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
            ),
            onTap: (){
              stateController.text = stateList[index].state_name;
              state_id = stateList[index].state_id;
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
