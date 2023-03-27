class FarmEquipment {
  int? id;
  String? name;
  String? image;
  int? price;
  String? status;
  String? priceUnit;
  String? description;
  int? sellerProductCategoryId;
  int? vendorCategoryId;
  int? userId;
  String? location;
  String? createdAt;
  String? updatedAt;

  FarmEquipment(
      {this.id,
        this.name,
        this.image,
        this.price,
        this.status,
        this.priceUnit,
        this.description,
        this.sellerProductCategoryId,
        this.vendorCategoryId,
        this.userId,
        this.location,
        this.createdAt,
        this.updatedAt});

  FarmEquipment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    status = json['status'];
    priceUnit = json['price_unit'];
    description = json['description'];
    sellerProductCategoryId = json['seller_product_category_id'];
    vendorCategoryId = json['vendor_category_id'];
    userId = json['user_id'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['status'] = this.status;
    data['price_unit'] = this.priceUnit;
    data['description'] = this.description;
    data['seller_product_category_id'] = this.sellerProductCategoryId;
    data['vendor_category_id'] = this.vendorCategoryId;
    data['user_id'] = this.userId;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
