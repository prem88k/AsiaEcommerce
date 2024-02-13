

import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/model/CategorieWiseProductPackage/updated_at.dart';

import 'created_at.dart';

class Product {

  int id;
  int in_wishlist;
	int total_reviews;
	String title;
  String thumbnail;
  String rating;
  String current_price;
	String previous_price;
	String discount_percent;
  Created_at created_at;
  Updated_at updated_at;

	Product.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
				in_wishlist = map["in_wishlist"],
				total_reviews = map["total_reviews"],
			title = map["title"],
		thumbnail = map["thumbnail"],
		rating = map["rating"],
		current_price = map["current_price"],
				discount_percent = map["discount_percent"],
		previous_price = map["previous_price"],
		created_at = Created_at.fromJsonMap(map["created_at"]);
//		updated_at = Updated_at.fromJsonMap(map["updated_at"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['in_wishlist'] = in_wishlist;
		data['total_reviews'] = total_reviews;
		data['title'] = title;
		data['thumbnail'] = thumbnail;
		data['rating'] = rating;
		data['current_price'] = current_price;
		data['discount_percent'] = discount_percent;
		data['previous_price'] = previous_price;
		data['created_at'] = created_at == null ? null : created_at.toJson();
//		data['updated_at'] = updated_at == null ? null : updated_at.toJson();
		return data;
	}


	String getpreviousprice(){
		if(previous_price ==null || previous_price.isEmpty || previous_price == "0" || previous_price == "0.0"){
			return "";
		} else{
			return Consts.currencySymbol + previous_price;
		}
	}
}
