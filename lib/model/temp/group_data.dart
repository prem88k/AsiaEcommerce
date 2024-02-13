
class Group_data {

  String label;
  String label_value;

	Group_data.fromJsonMap(Map<String, dynamic> map): 
		label = map["label"],
		label_value = map["label_value"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['label'] = label;
		data['label_value'] = label_value;
		return data;
	}
}
