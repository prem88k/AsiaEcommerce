
class RemoveCartRequest {

  String refrence_id;
  int user_id;
  int id;
	RemoveCartRequest(this.refrence_id,this.user_id , this.id);

	RemoveCartRequest.fromJsonMap(Map<String, dynamic> map):
		refrence_id = map["refrence_id"],
		user_id = map["user_id"],
		id = map["id"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['refrence_id'] = refrence_id;
		data['user_id'] = user_id;
		data['id'] = id;
		return data;
	}
}
