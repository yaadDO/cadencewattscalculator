import 'dart:async';
import 'package:flutter/material.dart';
import '../../../drawer/drawer.dart';
import '../components/calculation.dart';

class CadencePage extends StatefulWidget {
  const CadencePage({super.key});

  @override
  State<CadencePage> createState() => _CadencePageState();
}

class _CadencePageState extends State<CadencePage> {
  // Controllers for the input fields
  final TextEditingController _speedController = TextEditingController();
  final TextEditingController _frontGearController = TextEditingController();
  final TextEditingController _rearGearController = TextEditingController();
  final TextEditingController _wheelDiameterController = TextEditingController();

  // StreamController to manage cadence updates
  final StreamController<double> _cadenceStreamController = StreamController<double>();


  @override
  void dispose() {
    _speedController.dispose();
    _frontGearController.dispose();
    _rearGearController.dispose();
    _wheelDiameterController.dispose();
    _cadenceStreamController.close();
    super.dispose();
  }


  /// Updates the cadence based on current input values
  void _updateCadence() {
    try {
      double speed = double.tryParse(_speedController.text) ?? 0.0;
      double wheelDiameter = double.tryParse(_wheelDiameterController.text) ?? 680.0; // Default to 700 mm
      int frontGear = int.tryParse(_frontGearController.text) ?? 53; // Default to 53 teeth
      int rearGear = int.tryParse(_rearGearController.text) ?? 12; // Default to 12 teeth

      double cadence = calculateCadence(
        speedKmPerHour: speed,
        rearGearTeeth: rearGear,
        frontGearTeeth: frontGear,
        wheelDiameterMm: wheelDiameter,
      );
      _cadenceStreamController.add(cadence);
    } catch (e) {
      _cadenceStreamController.add(0.0); // Handle invalid inputs gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      drawer: const NavBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10,10),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Cadence:',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight:
                  FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,),
            ),
            StreamBuilder<double>(
              stream: _cadenceStreamController.stream,
              initialData: 0.0,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data!.toStringAsFixed(0),
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _speedController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Speed (km/h)',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _updateCadence(),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _wheelDiameterController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Wheel Diameter (mm)',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _updateCadence(),
            ),
            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _frontGearController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Front Gear',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => _updateCadence(),
                  ),
                ),
                const SizedBox(width: 16), // Add some spacing between the two text fields
                Expanded(
                  child: TextField(
                    controller: _rearGearController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Rear Gear',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => _updateCadence(),
                  ),
                ),
              ],
            ),
              ],
            ),
      ),
    );
  }
}
