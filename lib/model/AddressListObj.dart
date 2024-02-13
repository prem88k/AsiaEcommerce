
class AddressListObj {

  int id;
  String fullname;
  String phone;
  String alter_phone;
  String house_building_name;
  String address;
  int state;
  String state_name;
  String city;
  int pincode;
  int address_type;
  String address_type_name;

  bool ISSelected = false;

	AddressListObj.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		fullname = map["fullname"],
		phone = map["phone"],
		alter_phone = map["alter_phone"],
		house_building_name = map["house_building_name"],
		address = map["address"],
		state = map["state"],
		state_name = map["state_name"],
		city = map["city"],
		pincode = map["pincode"],
		address_type = map["address_type"],
		address_type_name = map["address_type_name"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['fullname'] = fullname;
		data['phone'] = phone;
		data['alter_phone'] = alter_phone;
		data['house_building_name'] = house_building_name;
		data['address'] = address;
		data['state'] = state;
		data['state_name'] = state_name;
		data['city'] = city;
		data['pincode'] = pincode;
		data['address_type'] = address_type;
		data['address_type_name'] = address_type_name;
		return data;
	}
}
