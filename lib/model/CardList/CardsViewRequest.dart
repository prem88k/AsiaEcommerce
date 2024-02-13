class CardsViewRequest{
  String refrence_id;
  int user_id = 0;

  CardsViewRequest({this.refrence_id,this.user_id});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refrence_id'] = refrence_id;
    data['user_id'] = user_id;
    return data;
  }

}