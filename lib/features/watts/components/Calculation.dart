import 'dart:math';

/// A function to calculate power (watts) based on the provided input parameters.
double calculatePower({
  required double speed,
  required double slope,
  required double weight,
  required double bikeWeight,
  required double altitude,
  required double wind,
  required double rR,
  required double cda,
  required double loss,
}) {
  double ap = 1.225 * exp(-0.00011856 * altitude); // Air density
  double ms = speed / 3.6; // Speed in m/s
  double finalSlope = slope / 100; // Slope as a fraction
  double finalLoss = loss / 100; // Loss as a fraction

  double fG = 9.80665 * sin(atan(finalSlope)) * (weight + bikeWeight); // Gravitational force
  double fR = 9.80665 * cos(atan(finalSlope)) * (weight + bikeWeight) * rR; // Rolling resistance
  double fA = 0.5 * cda * ap * pow((ms + (wind/10)), 2); // Aerodynamic drag

  double finalVelocity = ms / finalLoss; // Adjusted velocity
  double power = (fG + fR + fA) * finalVelocity; // Total power in watts

  return double.parse(power.toStringAsFixed(1)); // Format to one decimal place
}