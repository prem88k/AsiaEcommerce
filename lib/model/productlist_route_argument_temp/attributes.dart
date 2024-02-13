
class Attributes {

  String code;
  List<String> values;

	Attributes( this.code,  this.values);
	
	Attributes.fromJsonMap(Map<String, dynamic> map): 
		code = map["code"],
		values = List<String>.from(map["values"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = code;
		data['values'] = values;
		return data;
	}
}
