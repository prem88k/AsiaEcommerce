
class Shop {

  Object id;
  String name;
  String items;

	Shop.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		items = map["items"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['items'] = items;
		return data;
	}
}
