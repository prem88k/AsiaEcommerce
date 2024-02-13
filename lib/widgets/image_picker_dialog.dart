import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketuse/Utils/MyColors.dart';

import 'CommonWidget.dart';
import 'image_picker_handler.dart';


class ImagePickerDialog extends StatelessWidget {

  ImagePickerHandler _listener;
  AnimationController _controller;
  BuildContext context;

  ImagePickerDialog(this._listener, this._controller);

  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;

  void initState() {
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = new Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  getImage(BuildContext context) {
    if (_controller == null ||
        _drawerDetailsPosition == null ||
        _drawerContentsOpacity == null) {
      return;
    }
    _controller.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => new SlideTransition(
        position: _drawerDetailsPosition,
        child: new FadeTransition(
          opacity: new ReverseAnimation(_drawerContentsOpacity),
          child: this,
        ),
      ),
    );
  }

  void dispose() {
    _controller.dispose();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 200);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  dismissDialog() {
    _controller.reverse();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Material(
        type: MaterialType.transparency,
        child: new Opacity(
          opacity: 1.0,
          child: new Container(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new GestureDetector(
                  onTap: () => _listener.openCamera(),
                  child: roundedButton2(
                      "Camera",
                      EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
                      const Color(0xFFFFFFFF),
                      ),
                ),
                CommonWidget.customdivider(context, 1),
//               Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//               child:  ,),
                new GestureDetector(
                  onTap: () => _listener.openGallery(),
                  child: roundedButton3(
                      "Gallery",
                      EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      const Color(0xFFFFFFFF),
                      ),
                ),
                const SizedBox(height: 10.0),
                new GestureDetector(
                  onTap: () => dismissDialog(),
                  child: new Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    child: roundedButton(
                        "Cancel",
                        EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        const Color(0xFFFFFFFF),
                       ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget roundedButton(
      String buttonLabel, EdgeInsets margin, Color bgColor) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(15.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: MyColors.app_primary_color, fontSize: 14.0, fontWeight: FontWeight.w500),
      ),
    );


    return loginBtn;
  }
  Widget roundedButton2(
      String buttonLabel, EdgeInsets margin, Color bgColor) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.only(topLeft : const Radius.circular(15.0), topRight : const Radius.circular(15.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: MyColors.brownishGrey, fontSize: 14.0, fontWeight: FontWeight.w500),
      ),
    );


    return loginBtn;
  }

  Widget roundedButton3(
      String buttonLabel, EdgeInsets margin, Color bgColor) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.only(bottomLeft : const Radius.circular(15.0), bottomRight : const Radius.circular(15.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: MyColors.brownishGrey, fontSize: 14.0, fontWeight: FontWeight.w500),
      ),
    );


    return loginBtn;
  }
}
