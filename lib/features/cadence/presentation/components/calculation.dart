import 'package:flutter/material.dart';

double calculateCadence({
  required double speedKmPerHour,
  required int rearGearTeeth,
  required int frontGearTeeth,
  required double wheelDiameterMm,
}) {
  // Convert speed from km/h to m/s
  double speedMetersPerSecond = speedKmPerHour / 3.6;

  // Convert wheel diameter from mm to meters
  double wheelDiameterMeters = wheelDiameterMm / 1000;

  // Calculate cadence in RPM
  double cadence = (speedMetersPerSecond * 60 * rearGearTeeth) /
      (3.1416 * wheelDiameterMeters * frontGearTeeth);

  return cadence;
}