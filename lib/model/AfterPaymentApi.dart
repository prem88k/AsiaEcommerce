
class AfterPaymentApi {

  String order_id;
  String title;
  String text;
  String updated_at;
  String created_at;
  int id;

	AfterPaymentApi.fromJsonMap(Map<String, dynamic> map): 
		order_id = map["order_id"],
		title = map["title"],
		text = map["text"],
		updated_at = map["updated_at"],
		created_at = map["created_at"],
		id = map["id"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['order_id'] = order_id;
		data['title'] = title;
		data['text'] = text;
		data['updated_at'] = updated_at;
		data['created_at'] = created_at;
		data['id'] = id;
		return data;
	}
}
