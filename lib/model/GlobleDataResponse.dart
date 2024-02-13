
class GlobleDataResponse {

  String logo;
  String favicon;
  String title;
  String header_email;
  String header_phone;
  String footer;

	GlobleDataResponse.fromJsonMap(Map<String, dynamic> map): 
		logo = map["logo"],
		favicon = map["favicon"],
		title = map["title"],
		header_email = map["header_email"],
		header_phone = map["header_phone"],
		footer = map["footer"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['logo'] = logo;
		data['favicon'] = favicon;
		data['title'] = title;
		data['header_email'] = header_email;
		data['header_phone'] = header_phone;
		data['footer'] = footer;
		return data;
	}
}
