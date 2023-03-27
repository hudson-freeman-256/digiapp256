class Insuarance {
  int? id;
  String? name;
  String? image;
  String? terms;
  bool? isVerified;
  String? description;
  String? location;
  int? userId;
  int? vendorCategoryId;
  String? createdAt;
  String? updatedAt;

  Insuarance(
      {this.id,
        this.name,
        this.image,
        this.terms,
        this.isVerified,
        this.description,
        this.location,
        this.userId,
        this.vendorCategoryId,
        this.createdAt,
        this.updatedAt});

  Insuarance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    terms = json['terms'];
    isVerified = json['is_verified'];
    description = json['description'];
    location = json['location'];
    userId = json['user_id'];
    vendorCategoryId = json['vendor_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['terms'] = this.terms;
    data['is_verified'] = this.isVerified;
    data['description'] = this.description;
    data['location'] = this.location;
    data['user_id'] = this.userId;
    data['vendor_category_id'] = this.vendorCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


