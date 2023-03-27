class UserAnimalFeed {
  bool? success;
  Data? data;
  String? message;

  UserAnimalFeed({this.success, this.data, this.message});

  UserAnimalFeed.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? name;
  String? price;
  String? weight;
  String? description;
  String? location;
  String? status;
  String? vendor;
  String? image;
  String? animalFeedCategory;
  String? animalCategory;
  String? createdAt;
  String? timeSince;

  Data(
      {this.name,
        this.price,
        this.weight,
        this.description,
        this.location,
        this.status,
        this.vendor,
        this.image,
        this.animalFeedCategory,
        this.animalCategory,
        this.createdAt,
        this.timeSince});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    weight = json['weight'];
    description = json['description'];
    location = json['location'];
    status = json['status'];
    vendor = json['vendor'];
    image = json['image'];
    animalFeedCategory = json['animal_feed_category'];
    animalCategory = json['animal_category'];
    createdAt = json['created_at'];
    timeSince = json['time_since'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['description'] = this.description;
    data['location'] = this.location;
    data['status'] = this.status;
    data['vendor'] = this.vendor;
    data['image'] = this.image;
    data['animal_feed_category'] = this.animalFeedCategory;
    data['animal_category'] = this.animalCategory;
    data['created_at'] = this.createdAt;
    data['time_since'] = this.timeSince;
    return data;
  }
}