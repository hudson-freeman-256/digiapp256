class Rent{
  int? id;
  String? name;
  String? location;
  int? charge;
  int? quantity;
  String? status;
  int? isVerified;
  String? chargeUnit;
  String? chargeFrequency;
  String? description;
  String? image;
  int? userId;
  int? rentVendorSubCategoryId;
  int? vendorCategoryId;
  String? createdAt;
  String? updatedAt;

  Rent(
      {this.id,
        this.name,
        this.location,
        this.charge,
        this.quantity,
        this.status,
        this.isVerified,
        this.chargeUnit,
        this.chargeFrequency,
        this.description,
        this.image,
        this.userId,
        this.rentVendorSubCategoryId,
        this.vendorCategoryId,
        this.createdAt,
        this.updatedAt});

  Rent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    charge = json['charge'];
    quantity = json['quantity'];
    status = json['status'];
    isVerified = json['is_verified'];
    chargeUnit = json['charge_unit'];
    chargeFrequency = json['charge_frequency'];
    description = json['description'];
    image = json['image'];
    userId = json['user_id'];
    rentVendorSubCategoryId = json['rent_vendor_sub_category_id'];
    vendorCategoryId = json['vendor_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['charge'] = this.charge;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['is_verified'] = this.isVerified;
    data['charge_unit'] = this.chargeUnit;
    data['charge_frequency'] = this.chargeFrequency;
    data['description'] = this.description;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    data['rent_vendor_sub_category_id'] = this.rentVendorSubCategoryId;
    data['vendor_category_id'] = this.vendorCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}