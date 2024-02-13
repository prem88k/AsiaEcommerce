import 'package:pocketuse/model/OrderListResponse/orders_data.dart';

class OrderListResponse {

  List<Orders_data> orders_data;
  int total_records;
  int previous_page;
  String current_page;
  int next_page;
  int total_pages;

	OrderListResponse.fromJsonMap(Map<String, dynamic> map): 
		orders_data = List<Orders_data>.from(map["orders_data"].map((it) => Orders_data.fromJsonMap(it))),
		total_records = map["total_records"],
		previous_page = map["previous_page"],
		current_page = map["current_page"],
		next_page = map["next_page"],
		total_pages = map["total_pages"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['orders_data'] = orders_data != null ? 
			this.orders_data.map((v) => v.toJson()).toList()
			: null;
		data['total_records'] = total_records;
		data['previous_page'] = previous_page;
		data['current_page'] = current_page;
		data['next_page'] = next_page;
		data['total_pages'] = total_pages;
		return data;
	}
}
