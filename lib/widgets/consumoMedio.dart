import 'package:flutter/material.dart';

class ConsumoMedio extends StatelessWidget {
  const ConsumoMedio({Key? key}) : super(key: key);

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
              style: TextStyle(fontSize: 14),
            ),
            Text(
              '5',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
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
