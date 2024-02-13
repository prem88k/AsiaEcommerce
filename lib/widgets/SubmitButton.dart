import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget{

  String textOfBtn = '';
  VoidCallback onChanged;
  double paddingg;

  SubmitButton(this.textOfBtn, this.onChanged, this.paddingg);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingg, 0, paddingg, 0),
      child:  Center(
        child: SizedBox(
          width: double.infinity,
          child: MaterialButton(
            onPressed: () {
//        Navigator.pushNamed(context, '/DashboardPage');
              onChanged();
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                 color: Colors.grey,
                  borderRadius:
                  BorderRadius.all(Radius.circular(5.0))
              ),
              padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
              child: new Text(textOfBtn, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400 ),
                  textAlign: TextAlign.center),
            ),),
        ),
      ),
    );
  }


}