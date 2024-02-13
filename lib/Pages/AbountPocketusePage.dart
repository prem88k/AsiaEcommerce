import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/model/AboutPocketUseResponse.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:http/http.dart' as http;

class AbountPocketusePage extends StatefulWidget{
  static const routeName = '/AbountPocketusePage';

  @override
  AbountPocketusePageState createState() {
     return AbountPocketusePageState();
  }

}

class AbountPocketusePageState extends State<AbountPocketusePage>{

  String aboutContent="";
  String title="";
  bool displayIndicator = false;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(context);
          },
        ),
        title: CommonWidget.getActionBarTitleText(title.isEmpty ? 'About Asia Online': title),
        flexibleSpace: CommonWidget.ActionBarBg(),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child:displayIndicator ? CircularLoadingWidget(
                  height: MediaQuery.of(context).size.height * 0.75) : SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child:Html(
                          data:  aboutContent
                      )
                  )
              )
          )
        ],
      ),
    );
  }
  Future<void> getdata() async {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/page/about-asiaonline');


    print('url $url');

    setState(() {
      displayIndicator = true;
    });
    var response = await http.get(url );
    setState(() {
      displayIndicator = false;
    });
    print(response.body + "..............");

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

      if (userMap["status"]) {
        Object resultList = userMap["data"];
        var AboutPocketUseResponseObj = new AboutPocketUseResponse.fromJsonMap(resultList);
        setState(() {
          aboutContent = AboutPocketUseResponseObj.details;
          title = AboutPocketUseResponseObj.title;
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
}