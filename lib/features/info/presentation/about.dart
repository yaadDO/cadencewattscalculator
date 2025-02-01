import 'package:flutter/material.dart';

import '../../../responsive/constrained_scaffold.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('This app is published by: Once Software'),
            Text('App release date: TBD'),
            Text('Version Name: Beta'),
            Text('Version Number: 1.0'),
          ],
        ),
      )
    );
  }
}
