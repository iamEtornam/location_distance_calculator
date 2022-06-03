package dev.etornam.location_distance_calculator;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import java.util.Map;
import android.location.Location;


class Coordinate {
  public final double latitude;
  public final double longitude;

  public Coordinate(double latitude, double longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
  }
}

/** LocationDistanceCalculatorPlugin */
public class LocationDistanceCalculatorPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "location_distance_calculator");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("distanceBetween")) {
      receiveDistanceBetweenLocations(call.arguments, result);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  private static void receiveDistanceBetweenLocations(Object arguments, Result result) {
    // parse arguments to get coordiantes
    Coordinate sourceCoordinate;
    Coordinate destinationCoordinate;

    if(arguments == null) {
      throw new IllegalArgumentException("No coordinates supplied to calculate distance between.");
    }

    @SuppressWarnings("unchecked")
    Map<String, Double> coordinates = (Map<String, Double>)arguments;

    if(coordinates == null)
      throw new IllegalArgumentException("No coordinates supplied to calculate distance between.");

    sourceCoordinate = new Coordinate(
            coordinates.get("startLatitude"),
            coordinates.get("startLongitude"));
    destinationCoordinate = new Coordinate(
            coordinates.get("endLatitude"),
            coordinates.get("endLongitude"));

    if(sourceCoordinate == null || destinationCoordinate == null) {
      result.error(
              "ERROR_CALCULATE_DISTANCE_INVALID_PARAMS",
              "Please supply start and end coordinates.",
              null);
    }

    float[] results = new float[1];

    try {
      Location.distanceBetween(
              sourceCoordinate.latitude,
              sourceCoordinate.longitude,
              destinationCoordinate.latitude,
              destinationCoordinate.longitude,
              results);

      // According to the Android documentation the distance is
      // always stored in the first position of the result array
      // (see: https://developer.android.com/reference/android/location/Location.html#distanceBetween(double,%20double,%20double,%20double,%20float[]))
      result.success(results[0]);
    } catch(IllegalArgumentException ex) {
      result.error(
              "ERROR_CALCULATE_DISTANCE_ILLEGAL_ARGUMENT",
              ex.getLocalizedMessage(),
              null);
    }
  }
}
