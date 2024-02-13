import 'package:flutter/material.dart';
import 'package:pocketuse/Pages/OrderDetaiPage.dart';
import 'package:pocketuse/model/OrderListResponse/orders_data.dart';
 import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';

class OrderListItemWidget extends StatefulWidget{
  Orders_data orderResponse;

  OrderListItemWidget({Key key, this.orderResponse}) : super(key: key);

  @override
  OrderListItemWidgetState createState() {
     return OrderListItemWidgetState();
  }

}

class OrderListItemWidgetState extends State<OrderListItemWidget>{
  @override
  Widget build(BuildContext context) {
     return ListTile(
         leading : Image.network(
           widget.orderResponse.thumbnail,
//           "http://18.191.233.163/assets/images/thumbnails/1568026368CzWwfWLG.jpg",
                width: 50,
                height: 50,
           loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
             if (loadingProgress == null) return child;
             return CommonWidget.getloadingBulder(loadingProgress);
           },
         ),
       title: Padding(
         padding: const EdgeInsets.fromLTRB(0, 0, 0, 2,),
         child: Text(widget.orderResponse.product_name,  style:  TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 14),),
       ),
       subtitle: Padding(
         padding: const EdgeInsets.fromLTRB(0, 2, 0, 0,),
         child: Text(widget.orderResponse.status ,
           style:  TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[600], fontSize: 14),),
       ),
       trailing: Icon(Icons.arrow_forward_ios, size: 14,color: Colors.black87),
       onTap: (){
         Navigator.of(context).pushNamed(OrderDetaiPage.routeName,
             arguments: new RouteArgument(
                 id: widget.orderResponse.id.toString() ));
       },
     );
  }

}