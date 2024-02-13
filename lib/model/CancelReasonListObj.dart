
class CancelReasonListObj {

  int id;
  int reason_type;
  String title;
  int status;
	CancelReasonListObj(this.title);
	CancelReasonListObj.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		reason_type = map["reason_type"],
		title = map["title"],
		status = map["status"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['reason_type'] = reason_type;
		data['title'] = title;
		data['status'] = status;
		return data;
	}
}
