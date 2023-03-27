class BuyerRequest {
  bool? success;
  Data? data;
  String? message;

  BuyerRequest({this.success, this.data, this.message});

  BuyerRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<BuyersRequests>? buyersRequests;

  Data({this.buyersRequests});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['buyers-requests'] != null) {
      buyersRequests = <BuyersRequests>[];
      json['buyers-requests'].forEach((v) {
        buyersRequests!.add(new BuyersRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.buyersRequests != null) {
      data['buyers-requests'] =
          this.buyersRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BuyersRequests {
  Null? image;
  Null? name;
  Null? quantity;
  Null? quantityUnit;
  Null? location;
  Null? priceUnit;
  Null? sellingPrice;
  Null? description;
  int? buyingPrice;
  String? buyerLocation;
  int? isAccepted;
  String? username;

  BuyersRequests(
      {this.image,
        this.name,
        this.quantity,
        this.quantityUnit,
        this.location,
        this.priceUnit,
        this.sellingPrice,
        this.description,
        this.buyingPrice,
        this.buyerLocation,
        this.isAccepted,
        this.username});

  BuyersRequests.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    quantity = json['quantity'];
    quantityUnit = json['quantity_unit'];
    location = json['location'];
    priceUnit = json['price_unit'];
    sellingPrice = json['selling_price'];
    description = json['description'];
    buyingPrice = json['buying_price'];
    buyerLocation = json['buyer-location'];
    isAccepted = json['is_accepted'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['quantity_unit'] = this.quantityUnit;
    data['location'] = this.location;
    data['price_unit'] = this.priceUnit;
    data['selling_price'] = this.sellingPrice;
    data['description'] = this.description;
    data['buying_price'] = this.buyingPrice;
    data['buyer-location'] = this.buyerLocation;
    data['is_accepted'] = this.isAccepted;
    data['username'] = this.username;
    return data;
  }
}