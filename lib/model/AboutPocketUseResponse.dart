
class AboutPocketUseResponse {

  int id;
  String title;
  String slug;
  String details;
  Object meta_tag;
  Object meta_description;
  int header;
  int footer;

	AboutPocketUseResponse.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		title = map["title"],
		slug = map["slug"],
		details = map["details"],
		meta_tag = map["meta_tag"],
		meta_description = map["meta_description"],
		header = map["header"],
		footer = map["footer"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['title'] = title;
		data['slug'] = slug;
		data['details'] = details;
		data['meta_tag'] = meta_tag;
		data['meta_description'] = meta_description;
		data['header'] = header;
		data['footer'] = footer;
		return data;
	}
}
