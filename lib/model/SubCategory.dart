
class SubCategory {

  int id;
  int category_id;
  String name;
  String image;

	SubCategory.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		category_id = map["category_id"],
		name = map["name"],
		image = map["image"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['category_id'] = category_id;
		data['name'] = name;
		data['image'] = image;
		return data;
	}
}
