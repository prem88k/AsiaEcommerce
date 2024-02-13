

import 'package:pocketuse/model/CategorieWiseProductPackage/products.dart';

class HomePageCategoriWiseProducts {

  int id;
  String name;
  String background_image;
  String color_code;
  String image;
  List<Products> products;
  String subcategories;

	HomePageCategoriWiseProducts.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		background_image = map["background_image"],
		color_code = map["color_code"],
		image = map["image"],
		products = List<Products>.from(map["products"].map((it) => Products.fromJsonMap(it))),
		subcategories = map["subcategories"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['background_image'] = background_image;
		data['color_code'] = color_code;
		data['image'] = image;
		data['products'] = products != null ? 
			this.products.map((v) => v.toJson()).toList()
			: null;
		data['subcategories'] = subcategories;
		return data;
	}
}
