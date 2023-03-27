
class Agronomist {
  int? id;
  String? name;
  String? expertise;
  int? charge;
  bool? isVerified;
  String? location;
  String? chargeUnit;
  String? availability;
  String? description;
  Null? zoomDetails;
  String? image;
  int? userId;
  int? vendorCategoryId;
  String? createdAt;
  String? updatedAt;

  Agronomist(
      {this.id,
        this.name,
        this.expertise,
        this.charge,
        this.isVerified,
        this.location,
        this.chargeUnit,
        this.availability,
        this.description,
        this.zoomDetails,
        this.image,
        this.userId,
        this.vendorCategoryId,
        this.createdAt,
        this.updatedAt});

  Agronomist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    expertise = json['expertise'];
    charge = json['charge'];
    isVerified = json['is_verified'];
    location = json['location'];
    chargeUnit = json['charge_unit'];
    availability = json['availability'];
    description = json['description'];
    zoomDetails = json['zoom_details'];
    image = json['image'];
    userId = json['user_id'];
    vendorCategoryId = json['vendor_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['expertise'] = this.expertise;
    data['charge'] = this.charge;
    data['is_verified'] = this.isVerified;
    data['location'] = this.location;
    data['charge_unit'] = this.chargeUnit;
    data['availability'] = this.availability;
    data['description'] = this.description;
    data['zoom_details'] = this.zoomDetails;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    data['vendor_category_id'] = this.vendorCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}