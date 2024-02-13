
class Attributes {

  String attr_code;
  String attr_option;

	Attributes(this.attr_code,this.attr_option );

	Attributes.fromJsonMap(Map<String, dynamic> map): 
		attr_code = map["attr_code"],
		attr_option = map["attr_option"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['attr_code'] = attr_code;
		data['attr_option'] = attr_option;
		return data;
	}
}
