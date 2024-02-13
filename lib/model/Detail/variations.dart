
class Variations {

  String attribute_code;
  String attribute_name;
  List<String> attribute_options;

	Variations.fromJsonMap(Map<String, dynamic> map): 
		attribute_code = map["attribute_code"],
		attribute_name = map["attribute_name"],
		attribute_options = List<String>.from(map["attribute_options"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['attribute_code'] = attribute_code;
		data['attribute_name'] = attribute_name;
		data['attribute_options'] = attribute_options;
		return data;
	}
}
