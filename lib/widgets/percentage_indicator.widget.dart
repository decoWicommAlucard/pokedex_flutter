import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class PercentageIndicator extends StatelessWidget {
  final String name;
  final int value;
  final Color color;

  const PercentageIndicator({
    super.key,
    required this.name,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(name.toUpperCase())),
          SizedBox(width: 20),
          Expanded(
            flex: 8,
            child: LinearPercentIndicator(
              lineHeight: 25,
              percent: value.toDouble() / 100,
              progressColor: color,
              animation: true,
              barRadius: const Radius.circular(20),
              backgroundColor: Colors.grey,

              center: Text("${value.toDouble()} %"),
            ),
          ),
        ],
      ),
    );
  }
}
