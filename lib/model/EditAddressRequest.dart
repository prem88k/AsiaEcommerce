
class EditAddressRequest {

  String address_id;
  String fullname;
  String phone;
  int alter_phone;
  String house_building_name;
  String address;
  int state;
  String city;
  int pincode;
  int address_type;

	EditAddressRequest({this.address_id ,this.fullname , this.phone, this.alter_phone, this.house_building_name, this.address, this.state,
		this.city,
		this.pincode, this.address_type});

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['address_id'] = address_id;
		data['fullname'] = fullname;
		data['phone'] = phone;
		data['alter_phone'] = alter_phone;
		data['house_building_name'] = house_building_name;
		data['address'] = address;
		data['state'] = state;
		data['city'] = city;
		data['pincode'] = pincode;
		data['address_type'] = address_type;
		return data;
	}
}
