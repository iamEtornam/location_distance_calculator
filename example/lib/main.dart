import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location_distance_calculator/location_distance_calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _distance = 0.0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    double distance;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      distance = await LocationDistanceCalculator()
          .distanceBetween(48.8438543, -3.5232399, 48.8589507, 2.2770204);
    } on PlatformException {
      distance = -1.0;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _distance = distance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter locations distance'),
        ),
        body: Center(
          child: Text(
              'Distance between Perros-Guirec and Paris in meters:\n $_distance\n'),
        ),
      ),
    );
  }
}
