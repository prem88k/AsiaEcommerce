
class SliderObj {

  int id;
  String subtitle;
  String title;
  String small_text;
  String image;
  String redirect_url;
  Object created_at;
  Object updated_at;

	SliderObj.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		subtitle = map["subtitle"],
		title = map["title"],
		small_text = map["small_text"],
		image = map["image"],
		redirect_url = map["redirect_url"],
		created_at = map["created_at"],
		updated_at = map["updated_at"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['subtitle'] = subtitle;
		data['title'] = title;
		data['small_text'] = small_text;
		data['image'] = image;
		data['redirect_url'] = redirect_url;
		data['created_at'] = created_at;
		data['updated_at'] = updated_at;
		return data;
	}
}
