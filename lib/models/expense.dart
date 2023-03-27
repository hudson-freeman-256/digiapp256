
class Expense {
  int? id;
  int? amount;
  String? plot;
  String? farm;
  String? expenseCategory;
  String? createdAt;

  Expense(
      {this.id,
        this.amount,
        this.plot,
        this.farm,
        this.expenseCategory,
        this.createdAt});

  Expense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    plot = json['plot'];
    farm = json['farm'];
    expenseCategory = json['expense_category'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['plot'] = this.plot;
    data['farm'] = this.farm;
    data['expense_category'] = this.expenseCategory;
    data['created_at'] = this.createdAt;
    return data;
  }
}