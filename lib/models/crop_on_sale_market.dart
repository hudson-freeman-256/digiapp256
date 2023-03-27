class CropOnSaleMarket {
  int? id;
  int? quantity;
  String? name;
  String? image;
  int? sellingPrice;
  String? quantityUnit;
  String? priceUnit;
  String? description;
  String? location;
  bool? isSold;
  int? cropId;
  int? userId;
  String? createdAt;
  String? updatedAt;

  CropOnSaleMarket(
      {this.id,
        this.quantity,
        this.name,
        this.image,
        this.sellingPrice,
        this.quantityUnit,
        this.priceUnit,
        this.description,
        this.location,
        this.isSold,
        this.cropId,
        this.userId,
        this.createdAt,
        this.updatedAt});

  CropOnSaleMarket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    name = json['name'];
    image = json['image'];
    sellingPrice = json['selling_price'];
    quantityUnit = json['quantity_unit'];
    priceUnit = json['price_unit'];
    description = json['description'];
    location = json['location'];
    isSold = json['is_sold'];
    cropId = json['crop_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['image'] = this.image;
    data['selling_price'] = this.sellingPrice;
    data['quantity_unit'] = this.quantityUnit;
    data['price_unit'] = this.priceUnit;
    data['description'] = this.description;
    data['location'] = this.location;
    data['is_sold'] = this.isSold;
    data['crop_id'] = this.cropId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}