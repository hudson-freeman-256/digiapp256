class Harvest {
  int? id;
  int? quantity;
  int? plot_id;
  int? quantity_unit;



  Harvest(
      {this.id,
        this.quantity,
        this.plot_id,
        this.quantity_unit,
      });

  Harvest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    plot_id = json['plot_id'];
    quantity_unit = json['quantity_unit'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['plot_id'] = this.plot_id;
    data['quantity_unit'] = this.quantity_unit;

    return data;
  }
}