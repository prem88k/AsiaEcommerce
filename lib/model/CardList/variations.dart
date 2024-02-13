
class Variations {

  int id;
  int cart_id;
  int cart_product_id;
  int product_id;
  String attribute_code;
  String attribute_name;
  String option_name;

	Variations.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		cart_id = map["cart_id"],
		cart_product_id = map["cart_product_id"],
		product_id = map["product_id"],
		attribute_code = map["attribute_code"],
		attribute_name = map["attribute_name"],
		option_name = map["option_name"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['cart_id'] = cart_id;
		data['cart_product_id'] = cart_product_id;
		data['product_id'] = product_id;
		data['attribute_code'] = attribute_code;
		data['attribute_name'] = attribute_name;
		data['option_name'] = option_name;
		return data;
	}
}
