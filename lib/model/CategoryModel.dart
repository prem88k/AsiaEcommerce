
class CategoryModel {

  int id;
  String name;
  String image;
  String main_image;


	CategoryModel();

	CategoryModel.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"],
		image = map["image"],
	main_image = map["main_image"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['image'] = image;
		data['main_image'] = main_image;
		return data;
	}
}
