import 'package:pocketuse/model/temp/groupObj.dart';
import 'package:pocketuse/model/temp/group_data.dart';

class Attributes {
	List<GroupObj> group_data;

	Attributes.fromJsonMap(Map<String, dynamic> map):
				group_data = List<GroupObj>.from(map["GroupObj"].map((it) => GroupObj.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['group_data'] = group_data != null ?
		this.group_data.map((v) => v.toJson()).toList()
				: null;
		return data;
	}

//  General general;
//
//	Attributes.fromJsonMap(Map<String, dynamic> map):
//		general = General.fromJsonMap(map["general"]);
//
//	Map<String, dynamic> toJson() {
//		final Map<String, dynamic> data = new Map<String, dynamic>();
//		data['general'] = general == null ? null : general.toJson();
//		return data;
//	}
}
