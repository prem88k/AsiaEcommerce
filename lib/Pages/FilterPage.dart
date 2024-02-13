import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/model/CommanModal.dart';
import 'package:pocketuse/model/filterlistApi/filterList.dart';
import 'package:http/http.dart' as http;
import 'package:pocketuse/model/filterlistApi/values.dart';
import 'package:pocketuse/model/productlist_route_argument_temp/attributes.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';

class CallbackOfFilterDialog {
  void filteredData(List<Attributes> attributes) {}
}

class FilterPage extends StatefulWidget {
  CallbackOfFilterDialog _callbackOfFilterDialog;
  String category ;
  String subcategory;
  String childcategory;
  String term;

  List<Attributes> selectedattributes =null;

  FilterPage(this._callbackOfFilterDialog, this.category, this.subcategory, this.childcategory, this.term, this.selectedattributes);

  @override
  FilterPageState createState() {
    return FilterPageState();
  }
}

class FilterPageState extends State<FilterPage> {
  List<FilterList> FilterListdata = <FilterList>[];

  @override
  void initState() {
    super.initState();

    getfilterlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CommonWidget.ActionBarBg(),
        title: CommonWidget.getActionBarTitleText('Filter'),
        centerTitle: true,
        actions: [
          Center(
            child: InkWell(
              child: Padding(child: Text('CLEAR'),
              padding: EdgeInsets.fromLTRB(5, 3, 10, 3),),
              onTap: (){
                print('clear calllllll=============');
                setState(() {
                  if(widget.selectedattributes != null){
                    widget.selectedattributes.clear();
                  }

                  for(int i=0; i<FilterListdata.length; i++){
                    List<Values> valueslist = FilterListdata[i].values;

                    for(int j=0; j< valueslist.length; j++){
                      if(valueslist[j].IsCheck){
                        valueslist[j].IsCheck = false;
                      }
                    }
                  }
                });
              },
            ),
          )
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 62),
              child: ListView.builder(
//                  shrinkWrap: true,
                  itemCount: FilterListdata.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(FilterListdata[index].label, style: TextStyle(fontWeight: FontWeight.w500),),
                                ),
                                Icon(
                                  FilterListdata[index].isExpand
                                      ? Icons.arrow_drop_down
                                      : Icons.arrow_drop_up,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            if (FilterListdata[index].isExpand) {
                              setState(() {
                                FilterListdata[index].isExpand = false;
                              });
                            } else {
                              setState(() {

                                for(int i=0; i< FilterListdata.length ; i++){
                                  if(i ==index){
                                    FilterListdata[index].isExpand = true;

                                  } else{
                                    FilterListdata[i].isExpand = false;

                                  }
                                }
                              });
                            }
                          },
                        ),

                        Visibility(
                          visible: FilterListdata[index].isExpand,
                          child: Column(
                              children: FilterListdata[index]
                                  .values
                                  .map<Widget>((word) => Container(
                                      child: checkbox(word)
//                                      word.label != null
//                                          ? checkbox(word.label, word.IsCheck)
//                                          : checkbox(word.value.toString(), word.IsCheck)
                              )
                              )
                                  .toList()),
                        ),
                        Divider(
                          height: 1.0,
                        ),
                      ],
                    );
                  })),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonWidget.customdividerwithCustomColor(
                    context, 1, Colors.grey[300]),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        child: Text('CANCEL'),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      )),
                      SizedBox(
                        width: 150,
                        child: MaterialButton(
                          onPressed: () {
                            List<Attributes> attributes = [];

                            for(int i=0; i<FilterListdata.length; i++){

                              List<String> selectedValues = [];
                              List<Values> valueslist = FilterListdata[i].values;

                              for(int j=0; j< valueslist.length; j++){
                                if(valueslist[j].IsCheck){
                                  selectedValues.add(valueslist[j].id.toString());
                                }
                              }

                              if(selectedValues.length != 0){
                                attributes.add(new Attributes(FilterListdata[i].code, selectedValues));
                              }
                            }

                            widget._callbackOfFilterDialog.filteredData(attributes);

                            Navigator.of(context).pop();
//                        Navigator.of(context).pushReplacementNamed(OtpVerificationPage.routeName,
//                            arguments: new RouteArgument(id: phonenumberController.text.toString() ));
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange[400],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                            child: new Text('Apply',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget checkbox(Values word) {
//  Widget checkbox(String title, bool boolValue) {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.start,
//      children: <Widget>[
//        Checkbox(
//          value: word.IsCheck,
//          activeColor: Theme.of(context).primaryColor,
//          onChanged: (bool value) {
//            setState(() {
//              word.IsCheck= value;
//            });
//          },
//        ),
//        Text(word.label != null ? word.label : word.value),
//      ],
//    );

    return  CheckboxListTile(
      title: Text(word.label != null ? word.label : word.value, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),),
      value: word.IsCheck,
      onChanged: (newValue) {
        setState(() {
          word.IsCheck= newValue;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
    );
  }

  Future<List<FilterList>> getfilterlist() async {

//    if (category_id == null || category_id.isEmpty) {
//      url = '${GlobalConfiguration().getString('api_base_url')}filter';
//    } else {
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/front/filter?category_id='+widget.category+'&subcategory='+widget.subcategory+
        '&childcategory='+widget.childcategory+'&term='+widget.term);

    print('url $url');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];

      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (CommanModal_obj.status) {
        List<Object> resultList = data;

        List<FilterList> mycategoriesList = new List(resultList.length);

        for (int i = 0; i < resultList.length; i++) {
          Object obj = resultList[i];
          FilterList g = new FilterList.fromJsonMap(obj);

          if(i==0){
            g.isExpand = true;
          }

         if(widget.selectedattributes != null && widget.selectedattributes.isNotEmpty){

           for(int y= 0; y<widget.selectedattributes.length; y++){
             if(widget.selectedattributes[y].code == g.code){

                 List<Values> temp = g.values;
                 for(int valueList =0; valueList<temp.length; valueList++){
                    if(widget.selectedattributes[y].values.contains(temp[valueList].id.toString())){
                      g.values[valueList].IsCheck = true;
                    } else{
                      g.values[valueList].IsCheck = false;
                    }
                 }

             }
           }

         }
          mycategoriesList[i] = g;
        }

        setState(() {
          FilterListdata.addAll(mycategoriesList);
        });
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);

        return new List<FilterList>();
      }
    } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);

      return new List<FilterList>();
    }
  }
}
