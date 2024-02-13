
class Optopns {

  int id;
  int order_product_id;
  int order_id;
  int product_id;
  String attribute_code;
  String attribute_name;
  String created_at;
  String updated_at;
  String option_name;

	Optopns.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		order_product_id = map["order_product_id"],
		order_id = map["order_id"],
		product_id = map["product_id"],
		attribute_code = map["attribute_code"],
		attribute_name = map["attribute_name"],
		created_at = map["created_at"],
		updated_at = map["updated_at"],
		option_name = map["option_name"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['order_product_id'] = order_product_id;
		data['order_id'] = order_id;
		data['product_id'] = product_id;
		data['attribute_code'] = attribute_code;
		data['attribute_name'] = attribute_name;
		data['created_at'] = created_at;
		data['updated_at'] = updated_at;
		data['option_name'] = option_name;
		return data;
	}
}
