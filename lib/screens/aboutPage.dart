import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                height: size.width / 3,
                child: Image.asset(
                  'assets/images/logo_capelli.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Text('© Eilgug')
            ],
          ),
        ],
      ),
    );
  }
}
