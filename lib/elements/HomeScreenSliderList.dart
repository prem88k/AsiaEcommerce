import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/controllers/home_controller.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';

import 'CircularLoadingWidget.dart';

class HomeScreenSliderList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenSliderListState();
  }
}

class HomeScreenSliderListState extends StateMVC<HomeScreenSliderList>{
  HomeController _con;

  HomeScreenSliderListState() : super(HomeController()) {
    _con = controller;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForSlider();
  }

  int _current = 0;
  @override
    Widget build(BuildContext context) {
      return  _con.SliderList .isEmpty
      ? CircularLoadingWidget(height: 100) :
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Align(
            child: Container(
              height: 140,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(autoPlay: true,
//                    height : 200,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }
                  ),
                  items: _con.SliderList.map((item) => Container(
                    child: Center(
                        child: Image.network(item.image, fit: BoxFit.cover,
                          height: 140,
                          width: MediaQuery.of(context).size.width,
                          loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return CommonWidget.getloadingBulder(loadingProgress);
                          },
                        )
                    ),
                  )).toList(),
                )
            ),
            alignment: Alignment.bottomCenter,
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _con.SliderList.map((url) {
              int index = _con.SliderList.indexOf(url);
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
