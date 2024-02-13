
class SearchSuggetionListObj {

  String keyword;
  String suggestion;
  String image;
  int category_id;
  int subcategory_id;
  int childcategory_id;

	SearchSuggetionListObj.fromJsonMap(Map<String, dynamic> map): 
		keyword = map["keyword"],
		suggestion = map["suggestion"],
		image = map["image"],
		category_id = map["category_id"],
		subcategory_id = map["subcategory_id"],
		childcategory_id = map["childcategory_id"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['keyword'] = keyword;
		data['suggestion'] = suggestion;
		data['image'] = image;
		data['category_id'] = category_id;
		data['subcategory_id'] = subcategory_id;
		data['childcategory_id'] = childcategory_id;
		return data;
	}
}
