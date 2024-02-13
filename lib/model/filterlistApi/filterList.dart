import 'package:pocketuse/model/filterlistApi/values.dart';

class FilterList {

  String label;
  String code;
  List<Values> values;

  bool isExpand = false;

	FilterList.fromJsonMap(Map<String, dynamic> map): 
		label = map["label"],
		code = map["code"],
		values = List<Values>.from(map["values"].map((it) => Values.fromJsonMap(it)));

//	Map<String, dynamic> toJson() {
//		final Map<String, dynamic> data = new Map<String, dynamic>();
//		data['label'] = label;
//		data['code'] = code;
//		data['values'] = values != null ?
//			this.values.map((v) => v.toJson()).toList()
//			: null;
//		return data;
//	}
}
