
class HomeBestSaleItem {

  int id;
  String image;
  String link;

	HomeBestSaleItem.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		image = map["image"],
		link = map["link"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['image'] = image;
		data['link'] = link;
		return data;
	}
}
