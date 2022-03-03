import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Autonomia extends StatelessWidget {
  final double ggRestanti;

  const Autonomia({
    Key? key,
    required this.ggRestanti,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'AUTONOMIA',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade900),
              ),
              Row(
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    ggRestanti.isInfinite || ggRestanti.isNaN
                        ? '...'
                        : ggRestanti.toStringAsFixed(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                    ),
                  ),
                  Text(
                    ggRestanti.isInfinite || ggRestanti.isNaN ? '' : 'gg',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(''),
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    enableFeedback: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
