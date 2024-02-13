
class General {

  int InBox;
  int ModelNo;

	General.fromJsonMap(Map<String, dynamic> map): 
		InBox = map["In Box"],
		ModelNo = map["Model No"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['In Box'] = InBox;
		data['Model No'] = ModelNo;
		return data;
	}
}
