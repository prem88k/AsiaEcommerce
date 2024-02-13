class CommanModalWithObj {
  Object data  = null;
  List<Object> error;
  bool status;

  CommanModalWithObj.fromJson(Map<String, dynamic> json):
        data = json['data'],
        error = json["error"],
        status = json["status"];
}

