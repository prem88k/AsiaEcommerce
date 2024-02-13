import 'package:flutter/material.dart';
import 'package:pocketuse/model/Detail/ProductDetailResponse.dart';
import 'package:share/share.dart';

class ShareWidget extends StatefulWidget{
  ProductDetailResponse productDetail;

  ShareWidget(this.productDetail);

  @override
  ShareWidgetState createState() {
    return ShareWidgetState();
  }
}

class ShareWidgetState extends State<ShareWidget>{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:  Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Container(
          margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 3),
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(0.6),
                spreadRadius: 0.5,
                blurRadius: 1,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Icon(Icons.share,color: Colors.grey[400],size: 20,),
        ),
      ),
      onTap: (){
        final RenderBox box = context.findRenderObject();
        Share.share(widget.productDetail.title +"\n Price: "+ widget.productDetail.current_price,
            subject: widget.productDetail.title,
            sharePositionOrigin:
            box.localToGlobal(Offset.zero) &
            box.size);
      },
    );
  }

}