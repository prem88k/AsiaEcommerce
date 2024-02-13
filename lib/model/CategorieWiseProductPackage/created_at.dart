
class Created_at {

	String date;
	int timezone_type;
	String timezone;

	Created_at.fromJsonMap(Map<String, dynamic> map):
				date = map["date"],
				timezone_type = map["timezone_type"],
				timezone = map["timezone"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['date'] = date;
		data['timezone_type'] = timezone_type;
		data['timezone'] = timezone;
		return data;
	}
}
