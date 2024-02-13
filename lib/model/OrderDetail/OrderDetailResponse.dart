import 'package:pocketuse/model/OrderDetail/optopns.dart';
import 'package:pocketuse/model/OrderDetail/other_this_order_products.dart';

import 'OrderDetailAmountObj.dart';

class OrderDetailResponse {

  int id;
  int product_id;
  int order_id;
  String product_name;
  int has_multiple_options;
  String status;
  String slug;
  String thumbnail;
  String order_number;
  String payment_status;
  int total;
  String order_status;
  String shipping_name;
  String shipping_email;
  String shipping_phone;
  String shipping_address;
  String shipping_zip;
  String shipping_city;
  String shipping_country;
  String customer_name;
  String customer_email;
  String customer_phone;
  String customer_address;
  String customer_zip;
  String customer_city;
  String customer_country;
  String shipping;
  int paid_amount;
  String payment_method;
  int shipping_cost;
  int packing_cost;
  Object charge_id;
  String transaction_id;
  List<Optopns> optopns;
  List<Object> tracking_informations;
  List<Other_this_order_products> other_this_order_products;
  List<OrderDetailAmountObj> order_amount_details;

  double rating = 0.0;

	OrderDetailResponse.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		product_id = map["product_id"],
		order_id = map["order_id"],
		product_name = map["product_name"],
		has_multiple_options = map["has_multiple_options"],
		status = map["status"],
		slug = map["slug"],
		thumbnail = map["thumbnail"],
		order_number = map["order_number"],
		payment_status = map["payment_status"],
		total = map["total"],
		order_status = map["order_status"],
		shipping_name = map["shipping_name"],
		shipping_email = map["shipping_email"],
		shipping_phone = map["shipping_phone"],
		shipping_address = map["shipping_address"],
		shipping_zip = map["shipping_zip"],
		shipping_city = map["shipping_city"],
		shipping_country = map["shipping_country"],
		customer_name = map["customer_name"],
		customer_email = map["customer_email"],
		customer_phone = map["customer_phone"],
		customer_address = map["customer_address"],
		customer_zip = map["customer_zip"],
		customer_city = map["customer_city"],
		customer_country = map["customer_country"],
		shipping = map["shipping"],
		paid_amount = map["paid_amount"],
		payment_method = map["payment_method"],
		shipping_cost = map["shipping_cost"],
		packing_cost = map["packing_cost"],
		charge_id = map["charge_id"],
		transaction_id = map["transaction_id"],
		optopns = List<Optopns>.from(map["optopns"].map((it) => Optopns.fromJsonMap(it))),
				order_amount_details = map["order_amount_details"] != null ?
				List<OrderDetailAmountObj>.from(map["order_amount_details"].map((it) => OrderDetailAmountObj.fromJsonMap(it)) ): null,
		tracking_informations = map["tracking_informations"],
		other_this_order_products = List<Other_this_order_products>.from(map["other_this_order_products"].map((it) => Other_this_order_products.fromJsonMap(it)));

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
		data['order_number'] = order_number;
		data['payment_status'] = payment_status;
		data['total'] = total;
		data['order_status'] = order_status;
		data['shipping_name'] = shipping_name;
		data['shipping_email'] = shipping_email;
		data['shipping_phone'] = shipping_phone;
		data['shipping_address'] = shipping_address;
		data['shipping_zip'] = shipping_zip;
		data['shipping_city'] = shipping_city;
		data['shipping_country'] = shipping_country;
		data['customer_name'] = customer_name;
		data['customer_email'] = customer_email;
		data['customer_phone'] = customer_phone;
		data['customer_address'] = customer_address;
		data['customer_zip'] = customer_zip;
		data['customer_city'] = customer_city;
		data['customer_country'] = customer_country;
		data['shipping'] = shipping;
		data['paid_amount'] = paid_amount;
		data['payment_method'] = payment_method;
		data['shipping_cost'] = shipping_cost;
		data['packing_cost'] = packing_cost;
		data['charge_id'] = charge_id;
		data['transaction_id'] = transaction_id;
		data['optopns'] = optopns != null ? 
			this.optopns.map((v) => v.toJson()).toList()
			: null;
		data['tracking_informations'] = tracking_informations;
		data['other_this_order_products'] = other_this_order_products != null ? 
			this.other_this_order_products.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
