
class UpdateQuantityRequest {

  String refrence_id;
  int user_id;
  int id;
  int qty;

	UpdateQuantityRequest(this.refrence_id,this.user_id , this.id , this.qty);

	UpdateQuantityRequest.fromJsonMap(Map<String, dynamic> map): 
		refrence_id = map["refrence_id"],
		user_id = map["user_id"],
		id = map["id"],
		qty = map["qty"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['refrence_id'] = refrence_id;
		data['user_id'] = user_id;
		data['id'] = id;
		data['qty'] = qty;
		return data;
	}
}
