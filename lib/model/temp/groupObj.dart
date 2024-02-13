import 'package:pocketuse/model/temp/group_data.dart';

class GroupObj {

  String group_code;
  String group_name;
  List<Group_data> group_data;

	GroupObj.fromJsonMap(Map<String, dynamic> map): 
		group_code = map["group_code"],
		group_name = map["group_name"],
		group_data = List<Group_data>.from(map["group_data"].map((it) => Group_data.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['group_code'] = group_code;
		data['group_name'] = group_name;
		data['group_data'] = group_data != null ? 
			this.group_data.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
