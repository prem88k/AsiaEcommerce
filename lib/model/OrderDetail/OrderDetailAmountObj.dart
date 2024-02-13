
class OrderDetailAmountObj {

  String label;
  int amount;

	OrderDetailAmountObj.fromJsonMap(Map<String, dynamic> map): 
		label = map["label"],
		amount = map["amount"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['label'] = label;
		data['amount'] = amount;
		return data;
	}
}
