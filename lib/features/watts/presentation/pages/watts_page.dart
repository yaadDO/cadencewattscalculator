import 'package:cadenceandwattscalc/features/drawer/drawer.dart';
import 'package:flutter/material.dart';
import '../../components/watt_repo.dart';

class WattsPage extends StatefulWidget {
  const WattsPage({super.key});

  @override
  State<WattsPage> createState() => _WattsPageState();
}

class _WattsPageState extends State<WattsPage> {
  final PowerCalculationHelper calculator = PowerCalculationHelper();
  String result = "0";

  final List<double> rRValues = [0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008];
  final List<double> lossValues = [92, 93, 94, 95, 96, 97, 98, 99];
  final List<double> CDAValues = [0.10, 0.12, 0.14, 0.16, 0.18, 0.20, 0.22, 0.24, 0.26, 0.28, 0.30, 0.32, 0.34, 0.36, 0.38, 0.40, 0.42, 0.44];

  double selectedRR = 0.004; // Default rolling resistance
  double selectedLoss = 99;
  double selectedCDA = 0.26;

  // Function to validate input fields
  bool validateFields() {
    if (calculator.speedController.text.isEmpty ||
        calculator.slopeController.text.isEmpty ||
        calculator.weightController.text.isEmpty ||
        calculator.bikeWeightController.text.isEmpty ||
        calculator.altitudeController.text.isEmpty ||
        calculator.windController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void calculateWatts() {
    if (validateFields()) {
      calculator.rRController.text = selectedRR.toString();
      calculator.lossController.text = selectedLoss.toString();
      calculator.cdaController.text = selectedCDA.toString();

      double power = calculator.calculateWatts();
      setState(() {
        result = "$power ";
      });
    } else {
      // Show error dialog if any field is empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("ERROR"),
            content: const Text("Please fill in all the fields before calculating."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Watts:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            Text(
              result,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [

                const Expanded(
                  child: Text("Speed:"),
                ),
                Expanded(
                  child: TextField(
                    controller: calculator.speedController,
                    decoration: const InputDecoration(labelText: 'km/h'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                const Expanded(
                  child: Text("Gradient"),
                ),
                Expanded(
                  child: TextField(
                    controller: calculator.slopeController,
                    decoration: const InputDecoration(labelText: '%'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                const Expanded(
                  child: Text("Weight:"),
                ),
                Expanded(
                  child: TextField(
                    controller: calculator.weightController,
                    decoration: const InputDecoration(labelText: 'kg'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                const Expanded(
                  child: Text("Bike Weight:"),
                ),
                Expanded(
                  child: TextField(
                    controller: calculator.bikeWeightController,
                    decoration: const InputDecoration(labelText: 'kg'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                const Expanded(
                  child: Text("Altitude:"),
                ),
                Expanded(
                  child: TextField(
                    controller: calculator.altitudeController,
                    decoration: const InputDecoration(labelText: 'm'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                const Expanded(
                  child: Text("Wind speed:"),
                ),
                Expanded(
                  child: TextField(
                    controller: calculator.windController,
                    decoration: const InputDecoration(labelText: 'km/h'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Expanded(
                  child: Text("Rolling Resistance:"),
                ),
                Expanded(
                  child: DropdownButton<double>(
                    value: selectedRR,
                    items: rRValues
                        .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value.toString()),
                    ))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedRR = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Expanded(
                  child: Text("Drivetrain Efficiency:"),
                ),
                Expanded(
                  child: DropdownButton<double>(
                    value: selectedLoss,
                    items: lossValues
                        .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text((value).toStringAsFixed(0) + "%"),
                    ))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedLoss = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Expanded(
                  child: Text("CDA"),
                ),
                Expanded(
                  child: DropdownButton<double>(
                    value: selectedCDA,
                    items: CDAValues.map((value) => DropdownMenuItem(
                      value: value,
                      child: Text((value * 100).toStringAsFixed(0) + "%"),
                    )).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedCDA = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: calculateWatts, // Your function
        backgroundColor: Colors.blueGrey, // Optional: Change background color
        child: const Icon(
          Icons.electric_bolt,
          color: Colors.white, // Optional: Change icon color
        ),
      ),
    );
  }
}
