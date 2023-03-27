class CartData {
  int? id;
  int? sellerProductId;
  String? name;
  int? quantity;
  int? totalCost;
  int? price;
  String? priceUnit;
  int? stockAmount;
  String? image;
  String? type;

  CartData(
      {this.id,
        this.sellerProductId,
        this.name,
        this.quantity,
        this.totalCost,
        this.price,
        this.priceUnit,
        this.stockAmount,
        this.image,
        this.type});

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerProductId = json['seller_product_id'];
    name = json['name'];
    quantity = json['quantity'];
    totalCost = json['total_cost'];
    price = json['price'];
    priceUnit = json['price_unit'];
    stockAmount = json['stock_amount'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_product_id'] = this.sellerProductId;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['total_cost'] = this.totalCost;
    data['price'] = this.price;
    data['price_unit'] = this.priceUnit;
    data['stock_amount'] = this.stockAmount;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}