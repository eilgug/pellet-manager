import 'package:flutter/material.dart';

class ConsumoMedio extends StatelessWidget {
  final double average;
  final Function() newLoad;
  const ConsumoMedio({Key? key, required this.average, required this.newLoad})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(
              'MEDIA',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade900),
            ),
            Text(
              average.toStringAsFixed(1),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                  color: Colors.grey.shade900),
            ),
            TextButton(
              onPressed: newLoad,
              child: const Text('Nuovo carico'),
            ),
          ]),
        ),
      ),
    );
  }
}
