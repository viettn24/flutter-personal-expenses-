import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;
  Chart(this.transactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var sumAmount = 0.0;

      for (var i = 0; i < transactions.length; i++) {
        var currElement = transactions[i];
        if (currElement.date.day == weekDay.day &&
            currElement.date.month == weekDay.month &&
            currElement.date.year == weekDay.year) {
          sumAmount += currElement.amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': sumAmount};
    }).reversed.toList();
  }

  double get sumTotalAmount {
    return groupedTransactions
        .map((e) => e['amount'] as double)
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactions);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tx) {
            return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    tx['day'] as String,
                    tx['amount'] as double,
                    sumTotalAmount == 0.0
                        ? 0.0
                        : ((tx['amount'] as double) / sumTotalAmount)));
          }).toList(),
        ),
      ),
    );
  }
}
