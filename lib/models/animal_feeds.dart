class AnimalFeed{
  int? id;
  String? name;
  int? price;
  String? priceUnit;
  int? weight;
  int? stockAmount;
  String? location;
  String? image;
  String? weightUnit;
  String? description;
  String? status;
  bool? isVerified;
  int? userId;
  int? animalFeedCategoryId;
  int? vendorCategoryId;
  String? createdAt;
  String? updatedAt;
  Category? category;

  AnimalFeed(
      {this.id,
        this.name,
        this.price,
        this.priceUnit,
        this.weight,
        this.stockAmount,
        this.location,
        this.image,
        this.weightUnit,
        this.description,
        this.status,
        this.isVerified,
        this.userId,
        this.animalFeedCategoryId,
        this.vendorCategoryId,
        this.createdAt,
        this.updatedAt,
        this.category});

  AnimalFeed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    priceUnit = json['price_unit'];
    weight = json['weight'];
    stockAmount = json['stock_amount'];
    location = json['location'];
    image = json['image'];
    weightUnit = json['weight_unit'];
    description = json['description'];
    status = json['status'];
    isVerified = json['is_verified'];
    userId = json['user_id'];
    animalFeedCategoryId = json['animal_feed_category_id'];
    vendorCategoryId = json['vendor_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['price_unit'] = this.priceUnit;
    data['weight'] = this.weight;
    data['stock_amount'] = this.stockAmount;
    data['location'] = this.location;
    data['image'] = this.image;
    data['weight_unit'] = this.weightUnit;
    data['description'] = this.description;
    data['status'] = this.status;
    data['is_verified'] = this.isVerified;
    data['user_id'] = this.userId;
    data['animal_feed_category_id'] = this.animalFeedCategoryId;
    data['vendor_category_id'] = this.vendorCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  Null? image;
  int? animalCategoryId;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
        this.name,
        this.image,
        this.animalCategoryId,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    animalCategoryId = json['animal_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['animal_category_id'] = this.animalCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



