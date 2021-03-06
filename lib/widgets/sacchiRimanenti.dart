import 'package:flutter/material.dart';

class SacchiRimanenti extends StatelessWidget {
  final int stock;
  final double average;
  final Function() newOrder;

  const SacchiRimanenti(
      {Key? key,
      required this.stock,
      required this.average,
      required this.newOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(
              'SCORTA',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade900),
            ),
            Text(
              stock.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                  color: stock > (average * 2)
                      ? Colors.grey.shade900
                      : Colors.red.shade900),
            ),
            TextButton(
              onPressed: newOrder,
              child: const Text('Nuovo ordine'),
            ),
          ]),
        ),
      ),
    );
  }
}
