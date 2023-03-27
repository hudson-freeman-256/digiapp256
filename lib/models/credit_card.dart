
import 'dart:ui';

import 'package:digifarmer/models/transaction.dart';


class CreditCard {
  List<Color> colors;
  String bank;
  String name;
  String ccNumber;
  String ccDate;

  late List<Transaction> listTransactions;

  CreditCard(this.colors, this.bank, this.name, this.ccNumber, this.ccDate) {
    listTransactions = <Transaction>[];
  }

  void addTransaction(Transaction transaction) {
    this.listTransactions.add(transaction);
  }

  List<Transaction> getTransactions() {
    return listTransactions;
  }
}