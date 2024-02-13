
import 'attributes.dart';

class productlist_route_argument_temp {

  String term;
  int category;
  int subcategory;
  int childcategory;
  List<Attributes> attributes;
  int paginate;
  int page;

	productlist_route_argument_temp.fromJsonMap(Map<String, dynamic> map):
		term = map["term"],
		category = map["category"],
		subcategory = map["subcategory"],
		childcategory = map["childcategory"],
		attributes = List<Attributes>.from(map["attributes"].map((it) => Attributes.fromJsonMap(it))),
		paginate = map["paginate"],
		page = map["page"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['term'] = term;
		data['category'] = category;
		data['subcategory'] = subcategory;
		data['childcategory'] = childcategory;
		data['attributes'] = attributes != null ? 
			this.attributes.map((v) => v.toJson()).toList()
			: null;
		data['paginate'] = paginate;
		data['page'] = page;
		return data;
	}
}
