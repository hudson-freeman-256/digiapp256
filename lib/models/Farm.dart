
class Farm{
  int? id;
  String? name;
  String? owner;
  int? fieldArea;
  String? sizeUnit;
  String? createdAt;
  String? updatedAt;
  int? addressId;
  Address? address;

  Farm(
      {this.id,
        this.name,
        this.owner,
        this.fieldArea,
        this.sizeUnit,
        this.createdAt,
        this.updatedAt,
        this.addressId,
        this.address});

  Farm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    owner = json['owner'];
    fieldArea = json['field_area'];
    sizeUnit = json['size_unit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    addressId = json['address_id'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['field_area'] = this.fieldArea;
    data['size_unit'] = this.sizeUnit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['address_id'] = this.addressId;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  int? id;
  String? districtName;
  String? addressName;
  int? userId;
  int? districtId;
  String? createdAt;
  String? updatedAt;

  Address(
      {this.id,
        this.districtName,
        this.addressName,
        this.userId,
        this.districtId,
        this.createdAt,
        this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtName = json['district_name'];
    addressName = json['address_name'];
    userId = json['user_id'];
    districtId = json['district_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['district_name'] = this.districtName;
    data['address_name'] = this.addressName;
    data['user_id'] = this.userId;
    data['district_id'] = this.districtId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
