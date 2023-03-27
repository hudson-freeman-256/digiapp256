class User {

  final String? first_name;
  final String? last_name;
  final String? email;
  final String? phone;
  final String? image_url;
  final String? token;
  final int? is_verified;



  User({this.first_name,this.last_name,this.email,this.phone,this.image_url,this.token,this.is_verified });

  factory User.fromJson(Map<dynamic, dynamic> parsedJson) {
    return new User(
        first_name: parsedJson['first_name'] ?? "",
        last_name: parsedJson['last_name'] ?? "",
        is_verified: parsedJson['is_verified'] ?? "",
        email: parsedJson['email'] ?? "",
        phone: parsedJson['phone'] ?? "",
        image_url: parsedJson['image_url'] ?? "",
        token: parsedJson['token'] ?? "",);
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name": this.first_name,
      "last_name": this.last_name,
      "email": this.email,
      "phone": this.phone,
      "is_verified":this.is_verified,
      "image_url": this.image_url,
      "token": this.token,
    };
  }
}