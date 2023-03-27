
class AddressUser {
  int? id;
  String? districtName;
  String? addressName;
  int? userId;
  int? countryId;
  String? createdAt;
  String? updatedAt;

  AddressUser(
      {this.id,
        this.districtName,
        this.addressName,
        this.userId,
        this.countryId,
        this.createdAt,
        this.updatedAt});

  AddressUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtName = json['district_name'];
    addressName = json['address_name'];
    userId = json['user_id'];
    countryId = json['country_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['district_name'] = this.districtName;
    data['address_name'] = this.addressName;
    data['user_id'] = this.userId;
    data['country_id'] = this.countryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}