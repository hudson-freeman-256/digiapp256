class Plot {
  int? id;
  String? name;
  String? crop;
  String? farm;
  int? size;
  String? sizeUnit;
  String? location;
  String? createdAt;

  Plot(
      {this.id,
        this.name,
        this.crop,
        this.farm,
        this.size,
        this.sizeUnit,
        this.location,
        this.createdAt});

  Plot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    crop = json['crop'];
    farm = json['farm'];
    size = json['size'];
    sizeUnit = json['size_unit'];
    location = json['location'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['crop'] = this.crop;
    data['farm'] = this.farm;
    data['size'] = this.size;
    data['size_unit'] = this.sizeUnit;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    return data;
  }
}