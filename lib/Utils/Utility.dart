import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';

import 'Consts.dart';

class Utility {
  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static String convertdateFormat(String dateStr) {
    var dateFormat = DateFormat(
        "yyyy-MM-dd HH:mm:ss","en"
//        "yyyy-MM-dd HH:mm:ss","fr"
    ); //en_US fr_FR
    DateTime dateTime = null;
    try{
       dateTime = dateFormat.parse(dateStr);
    }catch(e){

    }


   // DateTime dateTime = dateFormat.parse(dateStr);

    var timeFormat = DateFormat("dd MMM yyyy hh:mm a", "en");
//    var timeFormat = DateFormat("dd MMM yyyy hh:mm a", "fr");
//    var timeFormat = DateFormat("MMM dd,yyyy hh:mm a", "fr");
    var finalDate = timeFormat.format(dateTime);

    return finalDate;
  }


  static String getDirectionsUrl(String origin,String dest){
    /*String str_origin = "origin="+origin.latitude.toString()+","+origin.longitude.toString();
    String str_dest = "destination="+dest.latitude.toString()+","+dest.longitude.toString();
    String sensor = "sensor=false";
    String parameters = str_origin+"&"+str_dest+"&"+sensor;
    String output = "json";
    String url = "https://maps.googleapis.com/maps/api/directions/"+output+"?"+parameters;*/
    String url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins="+origin+"&destinations="+dest+"&key=";
//    +
//        Consts.googleMapApiKEY;
  //  String url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins="+origin+"&destinations="+dest+"&mode=transit&language=en&key="+Consts.googleMapApiKEY;

    return url;
  }
}