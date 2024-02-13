import 'package:pocketuse/model/CardList/products.dart';

class CardListResponse {

  int total_products;
  int total_products_quantity;
  String total_amount;
  List<Products> products;

	CardListResponse.fromJsonMap(Map<String, dynamic> map): 
		total_products = map["total_products"],
		total_products_quantity = map["total_products_quantity"],
		total_amount = map["total_amount"],
		products = List<Products>.from(map["products"].map((it) => Products.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total_products'] = total_products;
		data['total_products_quantity'] = total_products_quantity;
		data['total_amount'] = total_amount;
		data['products'] = products != null ? 
			this.products.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
