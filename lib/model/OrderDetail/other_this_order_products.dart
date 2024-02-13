
class Other_this_order_products {

  int id;
  int order_id;
  String order_number;
  int product_id;
  String product_name;
  int has_multiple_options;
  int item_price;
  int quantity;
  int price;
  int vendor_id;
  String status;
  String created_at;
  String updated_at;
  String slug;
  String thumbnail;
  List<Object> optopns;

	Other_this_order_products.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		order_id = map["order_id"],
		order_number = map["order_number"],
		product_id = map["product_id"],
		product_name = map["product_name"],
		has_multiple_options = map["has_multiple_options"],
		item_price = map["item_price"],
		quantity = map["quantity"],
		price = map["price"],
		vendor_id = map["vendor_id"],
		status = map["status"],
		created_at = map["created_at"],
		updated_at = map["updated_at"],
		slug = map["slug"],
		thumbnail = map["thumbnail"],
		optopns = map["optopns"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['order_id'] = order_id;
		data['order_number'] = order_number;
		data['product_id'] = product_id;
		data['product_name'] = product_name;
		data['has_multiple_options'] = has_multiple_options;
		data['item_price'] = item_price;
		data['quantity'] = quantity;
		data['price'] = price;
		data['vendor_id'] = vendor_id;
		data['status'] = status;
		data['created_at'] = created_at;
		data['updated_at'] = updated_at;
		data['slug'] = slug;
		data['thumbnail'] = thumbnail;
		data['optopns'] = optopns;
		return data;
	}
}
