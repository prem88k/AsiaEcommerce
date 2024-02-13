
class Item {

  int id;
  int user_id;
  String slug;
  String name;
  String photo;
	String price;
  String previous_price;
  int status;
  int stock;
  String type;
  String discount_percentage;
  int has_multiple_options;
  Object file;
  Object link;

	Item.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		user_id = map["user_id"],
		slug = map["slug"],
		name = map["name"],
		photo = map["photo"],
		price = map["price"],
				previous_price = map["previous_price"],
		status = map["status"],
		stock = map["stock"],
		type = map["type"],
				discount_percentage = map["discount_percentage"],
		has_multiple_options = map["has_multiple_options"],
		file = map["file"],
		link = map["link"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['user_id'] = user_id;
		data['slug'] = slug;
		data['name'] = name;
		data['photo'] = photo;
		data['price'] = price;
		data['previous_price'] = previous_price;
		data['status'] = status;
		data['stock'] = stock;
		data['type'] = type;
		data['discount_percentage'] = discount_percentage;
		data['has_multiple_options'] = has_multiple_options;
		data['file'] = file;
		data['link'] = link;
		return data;
	}

  String getdiscount() {
		if(discount_percentage == null){
			return "";
		}
    return discount_percentage;
//		double num2 = double.parse((discount_percentage).toStringAsFixed(2));
//	  return num2.toString();
	}
}
