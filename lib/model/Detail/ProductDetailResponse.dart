import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/model/Detail/attributes.dart';
import 'package:pocketuse/model/Detail/images.dart';
import 'package:pocketuse/model/Detail/variations_data.dart';
import 'package:pocketuse/model/Detail/related_products.dart';
import 'package:pocketuse/model/Detail/shop.dart';
import 'package:pocketuse/model/Detail/created_at.dart';
import 'package:pocketuse/model/Detail/updated_at.dart';
import 'package:pocketuse/model/temp/groupObj.dart';

import 'ReviewObj.dart';

class ProductDetailResponse {

  int id;
  int in_wishlist;
  String title;
  String type;
//  Attributes attributes;
	List<GroupObj> attributes;
	String thumbnail;
  String first_image;
  List<Images> images;
  String rating;
  String current_price;
  String previous_price;
  String discount_percent;
  int stock;
  int has_multiple_options;
  Variations_data variations_data;
  Object video;
  Object estimated_shipping_time;
  String details;
  String policy;
  int total_reviews;
  List<ReviewObj> reviews;
  List<String> available_offers;
  List<Object> comments;
  List<Related_products> related_products;
  Shop shop;
  Created_at created_at;
//  Updated_at updated_at;

	ProductDetailResponse.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"] ,
				in_wishlist = map["in_wishlist"],
		title = map["title"],
		type = map["type"],
//		attributes = Attributes.fromJsonMap(map["attributes"]),
		thumbnail = map["thumbnail"],
		first_image = map["first_image"],
		images = List<Images>.from(map["images"].map((it) => Images.fromJsonMap(it))),
				available_offers = List<String>.from(map["available_offers"].map((it) => it)),
//				available_offers = map["available_offers"],
				attributes =map["attributes"] == null ? [] : List<GroupObj>.from(map["attributes"].map((it) => GroupObj.fromJsonMap(it))),
		rating = map["rating"],
		current_price = map["current_price"],
		previous_price = map["previous_price"],
				discount_percent = map["discount_percent"],
		stock = map["stock"],
		has_multiple_options = map["has_multiple_options"],
		variations_data = Variations_data.fromJsonMap(map["variations_data"]),
		video = map["video"],
		estimated_shipping_time = map["estimated_shipping_time"],
		details = map["details"],
//			reviews = Attributes.fromJsonMap(map["attributes"]),
				total_reviews = map["total_reviews"],
			policy = map["policy"],
				reviews = List<ReviewObj>.from(map["reviews"].map((it) => ReviewObj.fromJsonMap(it))),
//			reviews = map["reviews"],
		comments = map["comments"],
		related_products = List<Related_products>.from(map["related_products"].map((it) => Related_products.fromJsonMap(it))),
		shop = Shop.fromJsonMap(map["shop"]),
		created_at = Created_at.fromJsonMap(map["created_at"]);
//		updated_at = Updated_at.fromJsonMap(map["updated_at"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['in_wishlist'] = in_wishlist;
		data['title'] = title;
		data['type'] = type;
//		data['attributes'] = attributes == null ? null : attributes.toJson();
		data['thumbnail'] = thumbnail;
		data['first_image'] = first_image;
		data['images'] = images != null ? 
			this.images.map((v) => v.toJson()).toList()
			: null;
		data['attributes'] = attributes != null ?
			this.attributes.map((v) => v.toJson()).toList()
			: null;
		data['rating'] = rating;
		data['current_price'] = current_price;
		data['previous_price'] = previous_price;
		data['discount_percent'] = discount_percent;
		data['stock'] = stock;
		data['has_multiple_options'] = has_multiple_options;
		data['variations_data'] = variations_data == null ? null : variations_data.toJson();
		data['video'] = video;
		data['estimated_shipping_time'] = estimated_shipping_time;
		data['details'] = details;
		data['total_reviews'] = total_reviews;
		data['policy'] = policy;
//		data['reviews'] = reviews;
		data['reviews'] = reviews != null ? this.reviews.map((v) => v.toJson()).toList() : null;
		data['comments'] = comments;
		data['related_products'] = related_products != null ?	this.related_products.map((v) => v.toJson()).toList() : null;
		data['shop'] = shop == null ? null : shop.toJson();
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
