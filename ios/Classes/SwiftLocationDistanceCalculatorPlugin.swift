import Flutter
import UIKit
import CoreLocation

public class SwiftLocationDistanceCalculatorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "location_distance_calculator", binaryMessenger: registrar.messenger())
    let instance = SwiftLocationDistanceCalculatorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "distanceBetween" {
          self.receiveDistanceBetweenLocations(arguments: call.arguments, result: result);
        } else {
          result(FlutterMethodNotImplemented)
        }
  }


    private func receiveDistanceBetweenLocations(arguments: Any?, result: FlutterResult) {
      // parse arguments to get coordiantes
      var _startLocation: CLLocation?
      var _endLocation: CLLocation?
      if let location = arguments as! NSDictionary? {
        let startLatitude = location.object(forKey: "startLatitude") as! CLLocationDegrees
        let startLongitude = location.object(forKey: "startLongitude") as! CLLocationDegrees
        let endLatitude = location.object(forKey: "endLatitude") as! CLLocationDegrees
        let endLongitude = location.object(forKey: "endLongitude") as! CLLocationDegrees

        _startLocation = CLLocation.init(latitude: startLatitude, longitude: startLongitude)
        _endLocation = CLLocation.init(latitude: endLatitude, longitude: endLongitude)
      } else {
        _startLocation = nil
        _endLocation = nil
      }

      guard let startLocation = _startLocation, let endLocation = _endLocation else {
        result(FlutterError.init(
            code: "ERROR_CALCULATE_DISTANCE_INVALID_PARAMS",
            message: "Please supply start and end coordinates.",
            details: nil))

        return
      }

      let distance = endLocation.distance(from: startLocation)

      result(distance)
    }
}
