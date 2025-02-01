import 'package:flutter/material.dart';

import '../../../../responsive/constrained_scaffold.dart';
import '../../../cadence/presentation/pages/cadence_page.dart';
import '../../../watts/presentation/pages/watts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _pages() {
    return [
      const CadencePage(),
      const WattsPage(),
    ];
  }

  // List of colors for the BottomNavigationBar background
  final List<Color> _backgroundColors = [
    const Color.fromRGBO(134, 187, 229, 1), // Color for 'Home'
    Colors.blueGrey, // Color for 'Search'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _pages()[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
        backgroundColor: _backgroundColors[_currentIndex], // Set background color
        selectedItemColor: Colors.white, // Highlight selected item
        unselectedItemColor: Colors.grey.shade200, // Dim unselected items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Cadence',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.electric_bolt),
            label: 'Watts',
          ),
        ],
      ),
    );
  }
}
