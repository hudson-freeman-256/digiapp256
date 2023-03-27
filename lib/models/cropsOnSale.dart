class CropsOnSale{
  int? id;
  String? name;
  String? image;
  int? sellingPrice;
  int? quantity;
  String? quantityUnit;
  String? priceUnit;
  String? description;
  String? location;
  bool? isSold;
  String? createdAt;

  CropsOnSale(
      {this.id,
        this.name,
        this.image,
        this.sellingPrice,
        this.quantity,
        this.quantityUnit,
        this.priceUnit,
        this.description,
        this.location,
        this.isSold,
        this.createdAt});

  CropsOnSale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    sellingPrice = json['selling_price'];
    quantity = json['quantity'];
    quantityUnit = json['quantity_unit'];
    priceUnit = json['price_unit'];
    description = json['description'];
    location = json['location'];
    isSold = json['is_sold'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['selling_price'] = this.sellingPrice;
    data['quantity'] = this.quantity;
    data['quantity_unit'] = this.quantityUnit;
    data['price_unit'] = this.priceUnit;
    data['description'] = this.description;
    data['location'] = this.location;
    data['is_sold'] = this.isSold;
    data['created_at'] = this.createdAt;
    return data;
  }
}