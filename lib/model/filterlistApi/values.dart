
class Values {

	dynamic id;
	dynamic from;
	dynamic to;
  String label;
	dynamic	value;

	bool IsCheck = false;

	Values.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		from = map["from"],
		to = map["to"],
				value = map["value"],
		label = map["label"];

//	Map<String, dynamic> toJson() {
//		final Map<String, dynamic> data = new Map<String, dynamic>();
//		data['id'] = id;
//		data['from'] = from;
//		data['to'] = to;
//		data['label'] = label;
//		return data;
//	}
}
