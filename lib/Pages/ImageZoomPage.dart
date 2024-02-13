import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pocketuse/model/route_argument.dart';

class ImageZoomPage extends StatefulWidget{

  static const routeName = '/ImageZoomPage';

  RouteArgument routeArgument;

  ImageZoomPage({Key key, this.routeArgument}) : super(key: key);


  @override
  ImageZoomPageState createState() {
    return ImageZoomPageState();
  }

}

class ImageZoomPageState extends State<ImageZoomPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
              color: Colors.black,
              child: PhotoView(
                imageProvider: NetworkImage(widget.routeArgument.id),
                backgroundDecoration: BoxDecoration(color: Colors.transparent),
              )
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 20, 0),
            child: InkWell(
              child:  Container(
                margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 3),
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400].withOpacity(0.6),
                      spreadRadius: 0.5,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Icon(Icons.close,color: Colors.grey[800],size: 20,),
//            color: Colors.grey[400],
//            size: 20,
              ),
              onTap: (){
                Navigator.pop(context);
              },
            )
          ),
//
        ],
      ),
    );
  }

}