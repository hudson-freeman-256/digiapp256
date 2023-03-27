class Task {
  int? id;
  String? name;
  String? taskDate;
  String? plot;
  String? farm;
  String? createdAt;

  Task(
      {this.id,
        this.name,
        this.taskDate,
        this.plot,
        this.farm,
        this.createdAt});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    taskDate = json['task_date'];
    plot = json['plot'];
    farm = json['farm'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['task_date'] = this.taskDate;
    data['plot'] = this.plot;
    data['farm'] = this.farm;
    data['created_at'] = this.createdAt;
    return data;
  }
}
