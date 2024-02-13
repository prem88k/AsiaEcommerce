
class StateObj {

  int state_id;
  String state_name;
  int country_id;

	StateObj.fromJsonMap(Map<String, dynamic> map): 
		state_id = map["state_id"],
		state_name = map["state_name"],
		country_id = map["country_id"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['state_id'] = state_id;
		data['state_name'] = state_name;
		data['country_id'] = country_id;
		return data;
	}
}
