
class Animal {
  int? id;
  int? total;
  String? animalCategory;
  String? plot;
  String? farm;
  String? createdAt;

  Animal(
      {this.id,
        this.total,
        this.animalCategory,
        this.plot,
        this.farm,
        this.createdAt});

  Animal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    animalCategory = json['animal_category'];
    plot = json['plot'];
    farm = json['farm'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['animal_category'] = this.animalCategory;
    data['plot'] = this.plot;
    data['farm'] = this.farm;
    data['created_at'] = this.createdAt;
    return data;
  }
}
