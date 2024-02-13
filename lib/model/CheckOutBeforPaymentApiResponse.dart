
class CheckOutBeforPaymentApiResponse {

  String customer_state;
  String shipping_state;
  int user_id;
  int totalQty;
  dynamic pay_amount;
  String method;
  String shipping;
  String pickup_location;
  String customer_email;
  String customer_name;
  String shipping_cost;
  int packing_cost;
  String shipping_title;
  String packing_title;
  int tax;
  String customer_phone;
  String order_number;
  String customer_address;
  String customer_country;
  String customer_city;
  int customer_zip;
  String shipping_email;
  String shipping_name;
  String shipping_phone;
  String shipping_address;
  String shipping_country;
  String shipping_city;
  int shipping_zip;
  String order_note;
  String coupon_code;
  int coupon_discount;
  int dp;
  String payment_status;
  String currency_sign;
  int currency_value;
  String txnid;
  int vendor_shipping_id;
  int vendor_packing_id;
  int wallet_price;
  String updated_at;
  String created_at;
  dynamic razorpay_order_id;
  int id;

	CheckOutBeforPaymentApiResponse.fromJsonMap(Map<String, dynamic> map): 
		customer_state = map["customer_state"],
		shipping_state = map["shipping_state"],
		user_id = map["user_id"],
		totalQty = map["totalQty"],
		pay_amount = map["pay_amount"],
		method = map["method"],
		shipping = map["shipping"],
		pickup_location = map["pickup_location"],
		customer_email = map["customer_email"],
		customer_name = map["customer_name"],
		shipping_cost = map["shipping_cost"],
		packing_cost = map["packing_cost"],
		shipping_title = map["shipping_title"],
		packing_title = map["packing_title"],
		tax = map["tax"],
		customer_phone = map["customer_phone"],
		order_number = map["order_number"],
		customer_address = map["customer_address"],
		customer_country = map["customer_country"],
		customer_city = map["customer_city"],
		customer_zip = map["customer_zip"],
		shipping_email = map["shipping_email"],
		shipping_name = map["shipping_name"],
		shipping_phone = map["shipping_phone"],
		shipping_address = map["shipping_address"],
		shipping_country = map["shipping_country"],
		shipping_city = map["shipping_city"],
		shipping_zip = map["shipping_zip"],
		order_note = map["order_note"],
		coupon_code = map["coupon_code"],
		coupon_discount = map["coupon_discount"],
		dp = map["dp"],
		payment_status = map["payment_status"],
		currency_sign = map["currency_sign"],
		currency_value = map["currency_value"],
		txnid = map["txnid"],
		vendor_shipping_id = map["vendor_shipping_id"],
		vendor_packing_id = map["vendor_packing_id"],
		wallet_price = map["wallet_price"],
		updated_at = map["updated_at"],
		created_at = map["created_at"],
				razorpay_order_id = map["razorpay_order_id"],
		id = map["id"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['customer_state'] = customer_state;
		data['shipping_state'] = shipping_state;
		data['user_id'] = user_id;
		data['totalQty'] = totalQty;
		data['pay_amount'] = pay_amount;
		data['method'] = method;
		data['shipping'] = shipping;
		data['pickup_location'] = pickup_location;
		data['customer_email'] = customer_email;
		data['customer_name'] = customer_name;
		data['shipping_cost'] = shipping_cost;
		data['packing_cost'] = packing_cost;
		data['shipping_title'] = shipping_title;
		data['packing_title'] = packing_title;
		data['tax'] = tax;
		data['customer_phone'] = customer_phone;
		data['order_number'] = order_number;
		data['customer_address'] = customer_address;
		data['customer_country'] = customer_country;
		data['customer_city'] = customer_city;
		data['customer_zip'] = customer_zip;
		data['shipping_email'] = shipping_email;
		data['shipping_name'] = shipping_name;
		data['shipping_phone'] = shipping_phone;
		data['shipping_address'] = shipping_address;
		data['shipping_country'] = shipping_country;
		data['shipping_city'] = shipping_city;
		data['shipping_zip'] = shipping_zip;
		data['order_note'] = order_note;
		data['coupon_code'] = coupon_code;
		data['coupon_discount'] = coupon_discount;
		data['dp'] = dp;
		data['payment_status'] = payment_status;
		data['currency_sign'] = currency_sign;
		data['currency_value'] = currency_value;
		data['txnid'] = txnid;
		data['vendor_shipping_id'] = vendor_shipping_id;
		data['vendor_packing_id'] = vendor_packing_id;
		data['wallet_price'] = wallet_price;
		data['updated_at'] = updated_at;
		data['created_at'] = created_at;
		data['razorpay_order_id'] = razorpay_order_id;
		data['id'] = id;
		return data;
	}
}
