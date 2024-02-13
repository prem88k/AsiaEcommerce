import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/model/CardList/variations.dart';
import 'package:pocketuse/model/CardList/item.dart';

class Products {

  int id;
  int cart_id;
  int product_id;
  int has_multiple_options;
  String variation_key;
  int quantity;
  String item_price;
	String price;
	String previous_price;
	String discount;
  Object created_at;
  String updated_at;
  List<Variations> variations;
  Item item;

	Products.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		cart_id = map["cart_id"],
		product_id = map["product_id"],
		has_multiple_options = map["has_multiple_options"],
		variation_key = map["variation_key"],
		quantity = map["quantity"],
		item_price = map["item_price"],
		price = map["price"],
				previous_price = map["previous_price"],
				discount = map["discount"],
		created_at = map["created_at"],
		updated_at = map["updated_at"],
		variations = List<Variations>.from(map["variations"].map((it) => Variations.fromJsonMap(it))),
		item = Item.fromJsonMap(map["item"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['cart_id'] = cart_id;
		data['product_id'] = product_id;
		data['has_multiple_options'] = has_multiple_options;
		data['variation_key'] = variation_key;
		data['quantity'] = quantity;
		data['item_price'] = item_price;
		data['price'] = price;
		data['previous_price'] = previous_price;
		data['discount'] = discount;
		data['created_at'] = created_at;
		data['updated_at'] = updated_at;
		data['variations'] = variations != null ? 
			this.variations.map((v) => v.toJson()).toList()
			: null;
		data['item'] = item == null ? null : item.toJson();
		return data;
	}


	String getprevious_price() {
		if(previous_price == null ||  previous_price.isEmpty ||  previous_price =="0"){
			return "";
		}


		return Consts.currencySymbolWithoutSpace + previous_price.toString();
	}
}
