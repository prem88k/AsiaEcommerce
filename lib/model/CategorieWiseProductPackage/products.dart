import 'package:pocketuse/model/CategorieWiseProductPackage/updated_at.dart';


import 'created_at.dart';

class Products {

  int id;
	int total_reviews;
  String title;
  String thumbnail;
  String rating;
  String current_price;
  String previous_price;
  String discount_percent;
  String sale_end_date;
  Created_at created_at;
//  Updated_at updated_at;

	Products.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
				total_reviews = map["total_reviews"],
			title = map["title"],
		thumbnail = map["thumbnail"],
		rating = map["rating"],
		current_price = map["current_price"],
		previous_price = map["previous_price"],
				discount_percent = map["discount_percent"],
		sale_end_date = map["sale_end_date"],
		created_at = Created_at.fromJsonMap(map["created_at"]);
//		updated_at = Updated_at.fromJsonMap(map["updated_at"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['total_reviews'] = total_reviews;
		data['title'] = title;
		data['thumbnail'] = thumbnail;
		data['rating'] = rating;
		data['current_price'] = current_price;
		data['previous_price'] = previous_price;
		data['discount_percent'] = discount_percent;
		data['sale_end_date'] = sale_end_date;
		data['created_at'] = created_at == null ? null : created_at.toJson();
//		data['updated_at'] = updated_at == null ? null : updated_at.toJson();
		return data;
	}
}
