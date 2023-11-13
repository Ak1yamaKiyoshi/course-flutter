import 'dart:math' as math;
import 'package:flame/components.dart';


class Utils {
  Vector2 lerpVec2(Vector2 a, Vector2 b, double t ) {
    return a * (1.0 - t) + b * t;
  }

  dynamic lerp(dynamic a, dynamic b, double t ) {
    return a * (1.0 - t) + b * t;
  }

  double cutDegrees(double deg) {
    return deg = ((deg > 1) ? 1 : -1) * (deg.abs()%360);
  }

  double normalizeDegrees(double deg) {
    if (deg.abs() > 360) {
      deg = cutDegrees(deg);
    }
    if (deg < 0) {
      deg = 360 + deg;
    }
    return deg;
  }

  double toDegrees (double radians) {
    return radians * (180 / math.pi);
  }

  double toRadians (double degrees) {
    return degrees * (math.pi / 180);
  }

  double angleVec2(Vector2 a, Vector2 b) {
    return math.atan2(a.y - b.y, a.x - b.x);
  }
}