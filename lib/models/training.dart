class TrainingVendor {
  int? id;
  String? name;
  int? charge;
  String? description;
  String? image;
  String? access;
  String? startingDate;
  String? endingDate;
  String? startingTime;
  String? endingTime;
  String? zoomDetails;
  String? location;
  int? vendorCategoryId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  Null? periodUnitId;
  VendorCategory? vendorCategory;

  TrainingVendor(
      {this.id,
        this.name,
        this.charge,
        this.description,
        this.image,
        this.access,
        this.startingDate,
        this.endingDate,
        this.startingTime,
        this.endingTime,
        this.zoomDetails,
        this.location,
        this.vendorCategoryId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.periodUnitId,
        this.vendorCategory});

  TrainingVendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    charge = json['charge'];
    description = json['description'];
    image = json['image'];
    access = json['access'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    startingTime = json['starting_time'];
    endingTime = json['ending_time'];
    zoomDetails = json['zoom_details'];
    location = json['location'];
    vendorCategoryId = json['vendor_category_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    periodUnitId = json['period_unit_id'];
    vendorCategory = json['vendor_category'] != null
        ? new VendorCategory.fromJson(json['vendor_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['charge'] = this.charge;
    data['description'] = this.description;
    data['image'] = this.image;
    data['access'] = this.access;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['starting_time'] = this.startingTime;
    data['ending_time'] = this.endingTime;
    data['zoom_details'] = this.zoomDetails;
    data['location'] = this.location;
    data['vendor_category_id'] = this.vendorCategoryId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['period_unit_id'] = this.periodUnitId;
    if (this.vendorCategory != null) {
      data['vendor_category'] = this.vendorCategory!.toJson();
    }
    return data;
  }
}

class VendorCategory {
  int? id;
  String? name;
  bool? enabled;
  String? image;
  String? createdAt;
  String? updatedAt;

  VendorCategory(
      {this.id,
        this.name,
        this.enabled,
        this.image,
        this.createdAt,
        this.updatedAt});

  VendorCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    enabled = json['enabled'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['enabled'] = this.enabled;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

