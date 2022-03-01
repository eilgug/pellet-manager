import 'package:flutter/material.dart';

class ConsumoMedio extends StatelessWidget {
  final double average;
  const ConsumoMedio({Key? key, required this.average}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
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
              onPressed: () {},
              child: Text('Nuovo carico'),
            ),
          ]),
        ),
      ),
    );
  }
}
