import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_distance_calculator/location_distance_calculator.dart';

void main() {
  const MethodChannel channel = MethodChannel('location_distance_calculator');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 20;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getDistance', () async {
    final distance = LocationDistanceCalculator.private(channel);
    expect(
        distance.distanceBetween(48.8438543, -3.5232399, 48.8589507, 2.2770204),
        20);
  });
}
