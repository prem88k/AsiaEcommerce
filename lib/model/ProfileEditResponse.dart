
class ProfileEditResponse {

  int id;
  String full_name;
  String phone;
  String email;
  Object fax;
  String propic;
  Object zip_code;
  Object city;
  Object country;
  Object address;
  int balance;
  String email_verified;
  Object affilate_code;
  int affilate_income;
  int ban;

	ProfileEditResponse.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		full_name = map["full_name"],
		phone = map["phone"],
		email = map["email"],
		fax = map["fax"],
		propic = map["propic"],
		zip_code = map["zip_code"],
		city = map["city"],
		country = map["country"],
		address = map["address"],
		balance = map["balance"],
		email_verified = map["email_verified"],
		affilate_code = map["affilate_code"],
		affilate_income = map["affilate_income"],
		ban = map["ban"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['full_name'] = full_name;
		data['phone'] = phone;
		data['email'] = email;
		data['fax'] = fax;
		data['propic'] = propic;
		data['zip_code'] = zip_code;
		data['city'] = city;
		data['country'] = country;
		data['address'] = address;
		data['balance'] = balance;
		data['email_verified'] = email_verified;
		data['affilate_code'] = affilate_code;
		data['affilate_income'] = affilate_income;
		data['ban'] = ban;
		return data;
	}
}
