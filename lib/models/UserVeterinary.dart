class UserVetServices {
  int? id;
  String? name;
  String? expertise;
  int? charge;
  String? chargeUnit;
  String? availability;
  String? description;
  Null? zoomDetails;
  Null? location;
  String? image;
  int? userId;
  int? vendorCategoryId;
  String? createdAt;
  String? updatedAt;
  List<Null>? animalCategories;

  UserVetServices (
      {this.id,
        this.name,
        this.expertise,
        this.charge,
        this.chargeUnit,
        this.availability,
        this.description,
        this.zoomDetails,
        this.location,
        this.image,
        this.userId,
        this.vendorCategoryId,
        this.createdAt,
        this.updatedAt,
        this.animalCategories});

  UserVetServices .fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    expertise = json['expertise'];
    charge = json['charge'];
    chargeUnit = json['charge_unit'];
    availability = json['availability'];
    description = json['description'];
    zoomDetails = json['zoom_details'];
    location = json['location'];
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
    data['charge_unit'] = this.chargeUnit;
    data['availability'] = this.availability;
    data['description'] = this.description;
    data['zoom_details'] = this.zoomDetails;
    data['location'] = this.location;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    data['vendor_category_id'] = this.vendorCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}