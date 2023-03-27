class CropHarvests {
  int? id;
  String? quantity;
  String? plot;
  String? createdAt;

  CropHarvests({this.id, this.quantity, this.plot, this.createdAt});

  CropHarvests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    plot = json['plot'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['plot'] = this.plot;
    data['created_at'] = this.createdAt;
    return data;
  }
}