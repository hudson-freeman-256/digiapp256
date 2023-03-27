class RentDayError{
  List<String>? days;

  RentDayError({this.days});

  RentDayError.fromJson(Map<String, dynamic> json) {
    days = json['days'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days'] = this.days;
    return data;
  }
}