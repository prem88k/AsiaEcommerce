import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pocketuse/Pages/ImageZoomPage.dart';
import 'package:pocketuse/model/Detail/images.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';

import 'CircularLoadingWidget.dart';

class DetailPageItemsSliderList extends StatefulWidget {
  List<Images> images = <Images>[];

  DetailPageItemsSliderList(this.images);

  @override
  DetailPageItemsSliderListState createState() {
    return DetailPageItemsSliderListState();
  }
}

class DetailPageItemsSliderListState extends State<DetailPageItemsSliderList>{

  @override
  void initState() {
    super.initState();
  }

  int _current = 0;
  @override
    Widget build(BuildContext context) {
   double  current_height = MediaQuery.of(context).size.height;
   double  current_width = MediaQuery.of(context).size.width;

   Size current_widthsize = Size(current_width, current_height* 0.9);

    var _progress = null;

    return  widget.images.isEmpty
      ? CircularLoadingWidget(height: 100) :
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Align(
            child: Container(
//                color: Colors.purple,
                child: CarouselSlider(
                  options: CarouselOptions(
                      autoPlay:  widget.images.length == 1 ? false : true,
                      enableInfiniteScroll:  widget.images.length == 1 ? false : true,
                      viewportFraction: 1,
                      height : (current_height * 0.60),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }
                  ),
                  items: widget.images.map((item) => Container(
                    padding: EdgeInsets.all(10.0),
//                    color: Colors.white,
//                    height: current_height * 0.60,
//                    child: Center(
////                        child: Image.network(item.image, fit: BoxFit.contain,
//////                          height: 160,
////                          width: MediaQuery.of(context).size.width,
////                        )
//                      child: PhotoView(
//                        imageProvider: NetworkImage(
//                          item.image,
//
//                        ),
//                        backgroundDecoration : BoxDecoration(color: Colors.transparent),
//                        // Contained = the smallest possible size to fit one dimension of the screen
////                        minScale: PhotoViewComputedScale.contained * 0.1,
////                        // Covered = the smallest possible size to fit the whole screen
////                        maxScale: PhotoViewComputedScale.covered,
//                        enableRotation: true,
////                          customSize : current_widthsize
//                        // Set the background color to the "classic white"
////                        backgroundDecoration: BoxDecoration(
////                          color: Theme.of(context).canvasColor,
////                        ),
////        loadingBuilder: Center(
////          child: CircularProgressIndicator(),
////        ),
//                      ),
//                    ),
//..........................................................................................................................
//                  child: PhotoView(
//                      imageProvider: NetworkImage(item.image,),
//                      backgroundDecoration: BoxDecoration(color: Colors.transparent),
////                      gaplessPlayback: false,
////                      customSize: MediaQuery.of(context).size,
//
////                      scaleStateChangedCallback: this.onScaleStateChanged,
//                      enableRotation: true,
////                      controller:  controller,
////                      minScale: PhotoViewComputedScale.contained * 0.8,
////                      maxScale: PhotoViewComputedScale.covered * 1.8,
//                      initialScale: PhotoViewComputedScale.contained,
//                      basePosition: Alignment.center,
//
////                      scaleStateCycle: scaleStateCycle
//                  ),

                  child:  InkWell(
                    child: Image.network(item.image,
                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return CommonWidget.getloadingBulder(loadingProgress);
                      },),
                    onTap: (){
                      Navigator.of(context).pushNamed(ImageZoomPage.routeName,
                          arguments: new RouteArgument(
                              id: item.image,  ));
                    },
                  ))).toList(),
                )
            ),
            alignment: Alignment.bottomCenter,
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.images.map((url) {
              int index = widget.images.indexOf(url);
              return Container(
                width: 6.0,
                height: 6.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),)
        ],
      );
  }

}
