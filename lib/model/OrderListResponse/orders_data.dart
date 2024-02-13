import 'package:pocketuse/model/OrderListResponse/optopns.dart';

class Orders_data {

  int id;
  int product_id;
  int order_id;
  String product_name;
  int has_multiple_options;
  String status;
  String slug;
  String thumbnail;
  List<Optopns> optopns;

	Orders_data.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		product_id = map["product_id"],
		order_id = map["order_id"],
		product_name = map["product_name"],
		has_multiple_options = map["has_multiple_options"],
		status = map["status"],
		slug = map["slug"],
		thumbnail = map["thumbnail"],
		optopns = List<Optopns>.from(map["optopns"].map((it) => Optopns.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['product_id'] = product_id;
		data['order_id'] = order_id;
		data['product_name'] = product_name;
		data['has_multiple_options'] = has_multiple_options;
		data['status'] = status;
		data['slug'] = slug;
		data['thumbnail'] = thumbnail;
		data['optopns'] = optopns != null ? 
			this.optopns.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
