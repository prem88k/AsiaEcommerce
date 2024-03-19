class GetStoreData {
  bool status;
  Data data;

  GetStoreData({this.status, this.data});

  GetStoreData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }

    return data;
  }
}

class Data {
  Vendor vendor;
  List<Products> products;

  Data({this.vendor, this.products});

  Data.fromJson(Map<String, dynamic> json) {
    vendor =
    json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;

    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vendor != null) {
      data['vendor'] = this.vendor.toJson();
    }

    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vendor {
  int id;
  String fullName;
  String phone;
  String email;
  Null fax;
  String propic;
  String zipCode;
  String city;
  String country;
  String address;
  int balance;
  String emailVerified;
  String affilateCode;
  int affilateIncome;
  String shopName;
  Null ownerName;
  Null shopNumber;
  Null shopAddress;
  Null shopMessage;
  Null shopDetails;
  String shopImage;
  Facebook facebook;
  Google google;
  Google twitter;
  Google linkedin;
  int ban;

  Vendor(
      {this.id,
        this.fullName,
        this.phone,
        this.email,
        this.fax,
        this.propic,
        this.zipCode,
        this.city,
        this.country,
        this.address,
        this.balance,
        this.emailVerified,
        this.affilateCode,
        this.affilateIncome,
        this.shopName,
        this.ownerName,
        this.shopNumber,
        this.shopAddress,
        this.shopMessage,
        this.shopDetails,
        this.shopImage,
        this.facebook,
        this.google,
        this.twitter,
        this.linkedin,
        this.ban});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phone = json['phone'];
    email = json['email'];
    fax = json['fax'];
    propic = json['propic'];
    zipCode = json['zip_code'];
    city = json['city'];
    country = json['country'];
    address = json['address'];
    balance = json['balance'];
    emailVerified = json['email_verified'];
    affilateCode = json['affilate_code'];
    affilateIncome = json['affilate_income'];
    shopName = json['shop_name'];
    ownerName = json['owner_name'];
    shopNumber = json['shop_number'];
    shopAddress = json['shop_address'];
    shopMessage = json['shop_message'];
    shopDetails = json['shop_details'];
    shopImage = json['shop_image'];
  /*  facebook = json['facebook'] != null
         new Facebook.fromJson(json['facebook'])
        : null;
    google =
    json['google'] != null  new Google.fromJson(json['google']) : null;
    twitter =
    json['twitter'] != null  new Google.fromJson(json['twitter']) : null;
    linkedin =
    json['linkedin'] != null  new Google.fromJson(json['linkedin']) : null;*/
    ban = json['ban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['fax'] = this.fax;
    data['propic'] = this.propic;
    data['zip_code'] = this.zipCode;
    data['city'] = this.city;
    data['country'] = this.country;
    data['address'] = this.address;
    data['balance'] = this.balance;
    data['email_verified'] = this.emailVerified;
    data['affilate_code'] = this.affilateCode;
    data['affilate_income'] = this.affilateIncome;
    data['shop_name'] = this.shopName;
    data['owner_name'] = this.ownerName;
    data['shop_number'] = this.shopNumber;
    data['shop_address'] = this.shopAddress;
    data['shop_message'] = this.shopMessage;
    data['shop_details'] = this.shopDetails;
    data['shop_image'] = this.shopImage;

    data['ban'] = this.ban;
    return data;
  }
}

class Facebook {
  Null url;
  int visibility;

  Facebook({this.url, this.visibility});

  Facebook.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    visibility = json['visibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['visibility'] = this.visibility;
    return data;
  }
}

class Google {
  Null url;
  int status;

  Google({this.url, this.status});

  Google.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['status'] = this.status;
    return data;
  }
}

class Products {
  int id;
  String title;
  String thumbnail;
  String rating;
  String currentPrice;
  String previousPrice;
  String discountPercent;
  int inWishlist;
  CreatedAt createdAt;
  CreatedAt updatedAt;

  Products(
      {this.id,
        this.title,
        this.thumbnail,
        this.rating,
        this.currentPrice,
        this.previousPrice,
        this.discountPercent,
        this.inWishlist,
        this.createdAt,
        this.updatedAt});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    rating = json['rating'];
    currentPrice = json['current_price'];
    previousPrice = json['previous_price'];
    discountPercent = json['discount_percent'];
    inWishlist = json['in_wishlist'];
    createdAt = json['created_at'] != null?
         new CreatedAt.fromJson(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null?
         new CreatedAt.fromJson(json['updated_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['rating'] = this.rating;
    data['current_price'] = this.currentPrice;
    data['previous_price'] = this.previousPrice;
    data['discount_percent'] = this.discountPercent;
    data['in_wishlist'] = this.inWishlist;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt.toJson();
    }
    return data;
  }
}

class CreatedAt {
  String date;
  int timezoneType;
  String timezone;

  CreatedAt({this.date, this.timezoneType, this.timezone});

  CreatedAt.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}
