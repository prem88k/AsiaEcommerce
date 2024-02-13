
class RatingResponse {

  int id;
  String user_image;
  String user_id;
  String name;
  String review;
  String rating;
  String review_date;
	RatingResponse();

	RatingResponse.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		user_image = map["user_image"],
		user_id = map["user_id"],
		name = map["name"],
		review = map["review"],
		rating = map["rating"],
		review_date = map["review_date"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['user_image'] = user_image;
		data['user_id'] = user_id;
		data['name'] = name;
		data['review'] = review;
		data['rating'] = rating;
		data['review_date'] = review_date;
		return data;
	}
}
