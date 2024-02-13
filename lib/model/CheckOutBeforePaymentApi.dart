class CheckOutBeforePaymentApi{
  int user_id = 0;
  int address_id = 0;
  String payment_method = "";

  CheckOutBeforePaymentApi({this.user_id,this.address_id,this.payment_method});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = user_id;
    data['address_id'] = address_id;
    data['payment_method'] = payment_method;
    return data;
  }

}