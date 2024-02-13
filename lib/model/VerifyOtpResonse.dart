import 'package:pocketuse/model/user.dart';

class VerifyOtpResonse {

  String token;
  User user;

	VerifyOtpResonse.fromJsonMap(Map<String, dynamic> map): 
		token = map["token"],
		user = User.fromJsonMap(map["user"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['token'] = token;
		data['user'] = user == null ? null : user.toJson();
		return data;
	}
}
