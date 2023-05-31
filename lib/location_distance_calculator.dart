import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class LocationDistanceCalculator {
  @visibleForTesting
  LocationDistanceCalculator.private(this._channel);
  static LocationDistanceCalculator? _instance;
  final MethodChannel _channel;

  factory LocationDistanceCalculator() {
    if (_instance == null) {
      const MethodChannel channel =
          MethodChannel('location_distance_calculator');
      _instance = LocationDistanceCalculator.private(channel);
    }
    return _instance!;
  }

  /// Returns the distance between the supplied coordinates in meters.
  Future<double> distanceBetween(double startLatitude, double startLongitude,
          double endLatitude, double endLongitude) =>
      _channel.invokeMethod('distanceBetween', <String, double>{
        "startLatitude": startLatitude,
        "startLongitude": startLongitude,
        "endLatitude": endLatitude,
        "endLongitude": endLongitude
      }).then<double>((dynamic result) => result);
}
