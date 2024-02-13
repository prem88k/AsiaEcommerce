import 'package:pocketuse/model/SubCategory.dart';

class CommanModal {

  bool status;
  List<Object> data;
  List<Object> error;

	CommanModal.fromJsonMap(Map<String, dynamic> map):
		status = map["status"],
    data = map['data'],
		error = map["error"];
}

//		data = List<SubCategory>.from(map["data"].map((it) => SubCategory.fromJsonMap(it))),
//		data = List<SubCategory>.from(map["data"].map((it) => SubCategory.fromJsonMap(it))),