
class Combinations {

  String sku;
  int price;
  int quantity;
  int status;
	List<String> options;

	Combinations.fromJsonMap(Map<String, dynamic> map): 
		sku = map["sku"],
		price = map["price"],
		quantity = map["quantity"],
		status = map["status"],
				options = List<String>.from(map["options"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sku'] = sku;
		data['price'] = price;
		data['quantity'] = quantity;
		data['status'] = status;
		data['options'] = options;
		return data;
	}
}
