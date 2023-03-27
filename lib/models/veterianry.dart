

class VetServices {
  int? id;
  String? name;
  String? expertise;
  int? charge;
  int? isVerified;
  String? chargeUnit;
  String? availability;
  String? description;
  String? location;
  String? image;
  int? userId;



  VetServices(
      {this.id,
        this.name,
        this.expertise,
        this.charge,
        this.isVerified,
        this.chargeUnit,
        this.availability,
        this.description,
        this.location,
        this.image,
        this.userId,

      });

  VetServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    expertise = json['expertise'];
    charge = json['charge'];
    isVerified = json['is_verified'];
    chargeUnit = json['charge_unit'];
    availability = json['availability'];
    description = json['description'];
    location = json['location'];
    image = json['image'];
    userId = json['user_id'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['expertise'] = this.expertise;
    data['charge'] = this.charge;
    data['is_verified'] = this.isVerified;
    data['charge_unit'] = this.chargeUnit;
    data['availability'] = this.availability;
    data['description'] = this.description;
    data['location'] = this.location;
    data['image'] = this.image;
    data['user_id'] = this.userId;

    return data;
  }
}


