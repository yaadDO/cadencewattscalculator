import 'dart:math';
import 'package:flutter/material.dart';

import 'Calculation.dart';

class PowerCalculationHelper {
  final TextEditingController speedController = TextEditingController();
  final TextEditingController slopeController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController bikeWeightController = TextEditingController();
  final TextEditingController altitudeController = TextEditingController();
  final TextEditingController windController = TextEditingController();
  final TextEditingController rRController = TextEditingController();
  final TextEditingController cdaController = TextEditingController();
  final TextEditingController lossController = TextEditingController();

  double calculateWatts() {
    double speed = double.tryParse(speedController.text) ?? 0.0;
    double slope = double.tryParse(slopeController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double bikeWeight = double.tryParse(bikeWeightController.text) ?? 0.0;
    double altitude = double.tryParse(altitudeController.text) ?? 0.0;
    double wind = double.tryParse(windController.text) ?? 0.0;
    double rR = double.tryParse(rRController.text) ?? 0.0;
    double cda = double.tryParse(cdaController.text) ?? 0.0;
    double loss = double.tryParse(lossController.text) ?? 0.0;

    return calculatePower(
      speed: speed,
      slope: slope,
      weight: weight,
      bikeWeight: bikeWeight,
      altitude: altitude,
      wind: wind,
      rR: rR,
      cda: cda,
      loss: loss,
    );
  }
}