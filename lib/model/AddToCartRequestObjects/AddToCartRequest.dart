
import 'attributes.dart';

class AddToCartRequest {

  String refrence_id;
  int user_id;
  int id;
  int qty;
  List<Attributes> attributes;

	AddToCartRequest(this.refrence_id,this.user_id , this.id, this.qty, this.attributes);

	AddToCartRequest.fromJsonMap(Map<String, dynamic> map): 
		refrence_id = map["refrence_id"],
		user_id = map["user_id"],
		id = map["id"],
		qty = map["qty"],
		attributes = List<Attributes>.from(map["attributes"].map((it) => Attributes.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['refrence_id'] = refrence_id;
		data['user_id'] = user_id;
		data['id'] = id;
		data['qty'] = qty;
		data['attributes'] = attributes != null ? 
			this.attributes.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
