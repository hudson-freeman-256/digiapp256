
class  Country {
  int? id;
  String? name;
  String? shortCode;
  String? countryCode;

  Country({this.id, this.name, this.shortCode, this.countryCode});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortCode = json['short_code'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['short_code'] = this.shortCode;
    data['country_code'] = this.countryCode;
    return data;
  }
}