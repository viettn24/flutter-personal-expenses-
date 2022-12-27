import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double percentOfTotal;

  const ChartBar(this.label, this.spendingAmount, this.percentOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child:
              FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
          height: 20,
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10)),
                // color: Color.fromRGBO(220, 220, 220, 1),
              ),
              FractionallySizedBox(
                heightFactor: percentOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}
