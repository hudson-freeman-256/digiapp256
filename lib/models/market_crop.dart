
class MarketCrop {
  int? id;
  String? name;
  int? standardPrice;
  int? categoryId;
  String? priceUnit;
  String? image;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  MarketCrop(
      {this.id,
        this.name,
        this.standardPrice,
        this.categoryId,
        this.priceUnit,
        this.image,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  MarketCrop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    standardPrice = json['standard_price'];
    categoryId = json['category_id'];
    priceUnit = json['price_unit'];
    image = json['image'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['standard_price'] = this.standardPrice;
    data['category_id'] = this.categoryId;
    data['price_unit'] = this.priceUnit;
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}