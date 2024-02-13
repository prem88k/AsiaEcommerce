
class Images {

  int id;
  String image;

	Images(this.id, this.image);

	Images.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		image = map["image"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['image'] = image;
		return data;
	}
}
