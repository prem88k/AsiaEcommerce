
class FeaturedBanner {

  int id;
  String link;
  String photo;

	FeaturedBanner.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		link = map["link"],
		photo = map["photo"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['link'] = link;
		data['photo'] = photo;
		return data;
	}
}
