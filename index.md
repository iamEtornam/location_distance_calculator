# location_distance_calculator

A Flutter package which provides the distance between two locations
* [See the example folder](https://github.com/iamEtornam/location_distance_calculator/tree/main/example)

## Installation

* Add this to your package's pubspec.yaml file:
```
dependencies:
  location_distance_calculator:
```
* You can install packages from the command line:
  with Flutter:
```
$ flutter packages get
```

* Import it now in your Dart code:
```
 import 'package:location_distance_calculator/location_distance_calculator.dart';
```


## Usage
* Code
```
    double distance;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      distance = await LocationDistanceCalculator().distanceBetween(48.8438543, -3.5232399, 48.8589507, 2.2770204);
    } on PlatformException {
      distance = -1.0;
    }
```
