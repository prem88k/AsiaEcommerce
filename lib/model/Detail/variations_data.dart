import 'package:pocketuse/model/Detail/variations.dart';
import 'package:pocketuse/model/Detail/combinations.dart';

class Variations_data {

  List<Variations> variations;
  List<Combinations> combinations;

	Variations_data.fromJsonMap(Map<String, dynamic> map): 
		variations = List<Variations>.from(map["variations"].map((it) => Variations.fromJsonMap(it))),
		combinations = List<Combinations>.from(map["combinations"].map((it) => Combinations.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['variations'] = variations != null ? 
			this.variations.map((v) => v.toJson()).toList()
			: null;
		data['combinations'] = combinations != null ? 
			this.combinations.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
