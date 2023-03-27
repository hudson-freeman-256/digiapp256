class SearchModel {
  int? id;
  String? name;
  String? description;
  String? image;

  SearchModel (
      {this.id,
        this.name,
        this.description,
        this.image,
     });

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;



    return data;
  }
}