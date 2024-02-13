
import 'package:pocketuse/model/productlist_route_argument_temp/attributes.dart';

class Productlist_route_argument {

  String user_id;
  String term;
  String sort;
  int category = 0;
  int subcategory= 0;
  int childcategory =0;
  List<Attributes> attributes=[];
  int paginate = 0;
  int page = 0;

  Productlist_route_argument({this.user_id , this.term,this.sort, this.category, this.subcategory, this.childcategory,
    this.attributes,
    this.paginate, this.page});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = user_id;
    data['term'] = term;
    data['sort'] = sort;
    data['category'] = category;
    data['subcategory'] = subcategory;
    data['childcategory'] = childcategory;
    data['attributes'] = attributes != null ?
    this.attributes.map((v) => v.toJson()).toList()
        : null;
    data['paginate'] = paginate;
    data['page'] = page;
    return data;
  }

//  @override
//  String toString() {
//    return '{term: $term, category:${category.toString()}}';
//  }
}
