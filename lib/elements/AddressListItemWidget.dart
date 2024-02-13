import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/model/AddressListObj.dart';
import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:http/http.dart' as http;

class UpdateList{
  onRemoveItem(){}
  onEditItem(AddressListObj id){}
  onUpdateUi(String id){}
}
class AddressListItemWidget extends StatefulWidget{
  AddressListObj category;
  UpdateList updateList;
  String Selectedid;

  AddressListItemWidget({Key key, this.category, this.updateList, this.Selectedid}) : super(key: key);

  @override
  OrderListItemWidgetState createState() {
     return OrderListItemWidgetState();
  }

}

class OrderListItemWidgetState extends State<AddressListItemWidget>{
  @override
  Widget build(BuildContext context) {
     return
//       Card(child:
       Column(
         children: [
           InkWell(
             child: Container(
               child: Padding(
                 padding: const EdgeInsets.fromLTRB(18, 3, 16, 25),
                 child:  Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     SizedBox(height: 8,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             Text(CommonWidget.replaceNullWithEmpty(widget.category.fullname),
                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black87),),
                             Padding(
                               padding: EdgeInsets.fromLTRB(8, 6, 0, 0),
                               child: Container(
                                 padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                 child: Center(
                                   child: Padding(
                                     padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                     child: Text(CommonWidget.replaceNullWithEmpty(widget.category.address_type_name),
                                       style: TextStyle(fontSize: 8, fontWeight: FontWeight.w500, color: Colors.black45),),
                                   ),
                                 ),
                                 color: Consts.divider_or_bgcolor,
                               ),
                             )
                           ],
                         ),
                         Row(
                           children: [
                             InkWell(
                               child:  Padding(padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                                 child: Icon(Icons.delete,color: Colors.black45, size: 20,),),
                               onTap: (){
                                 deleteApiCAll(widget.category.id.toString());
                               },
                             ),

                             SizedBox(width: 1,),

                             InkWell(
                               child:  Padding(padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                                 child: Icon(Icons.edit,color: Colors.black45, size: 20,),),
                               onTap: (){
                                 widget.updateList.onEditItem(widget.category);
                               },
                             )


                           ],
                         )
                       ],
                     ),

                     SizedBox(height: 8,),
                     Text(CommonWidget.replaceNullWithEmpty(widget.category.house_building_name)+ " "+
                         CommonWidget.replaceNullWithEmpty(widget.category.address)+ " "+
                         CommonWidget.replaceNullWithEmpty(widget.category.state_name)+ " "+
                         CommonWidget.replaceNullWithEmpty(widget.category.city)+ " "+
                         CommonWidget.replaceNullIntWithEmpty(widget.category.pincode).toString(),
                       style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black87),),
                     SizedBox(height: 8,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(CommonWidget.replaceNullWithEmpty(widget.category.phone),style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black87),),
                         Visibility(child: Text("DEFAULT ADDRESS",style:
                         TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.green),),
                         visible: widget.Selectedid == widget.category.id.toString() ,)

                       ],
                     )
                   ],
                 ),
               ),
               color: widget.Selectedid == widget.category.id.toString() ? Colors.lime[50] : Colors.white,
             ),
             onTap: (){
               print(widget.category.id.toString()+"=======");
               widget.updateList.onUpdateUi(widget.category.id.toString());
             },
           ),
           CommonWidget.customdividerwithCustomColor(
               context, 1, Colors.grey[400]),
           Container(
             color: Colors.grey[200],
             height: 7,
             width: MediaQuery.of(context).size.width,
           ),
           SizedBox(
             height: 8,
           ),
         ],
       );
//     );
  }

  Future<void> deleteApiCAll(String id) async {
    print('***********');
    var url = Uri.https(GlobalConfiguration().getString('url'),'/api/user/addresses/remove/'+id);
//        '?highlight''=$highlight&limit=$limit&type=$type&product_type=$product_type&paginate=$paginate';

    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader:
      'Bearer ' + Consts.api_authentication_token
    };

    print('url $url');

    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);

//      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (userMap["status"]) {
        Object data = userMap["data"];
//        if (data.containsKey('message')) {

        var error = userMap["error"];

        if(error != null  && error is String ){
          Fluttertoast.showToast(
            msg: error.toString(),
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        }

        var message = userMap["message"];
        if(message != null  && message is String ){
          Fluttertoast.showToast(
            msg: error.toString(),
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        }



//        }
        widget.updateList.onRemoveItem();

//        Navigator.pop(context);
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