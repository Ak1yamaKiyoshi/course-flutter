import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:ui' hide TextStyle;

//void main() {
//  runApp(const GameWindow());
//}

class GameWindow extends StatelessWidget {
  const GameWindow({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: GameWidget(game: MyGame()),
    );
  }
}

class LightSource {
  Vector2 position;
  double intensity;
  LightSource({required this.position, required this.intensity});
}


class Roket extends SpriteComponent {
  final double modInertiaAngularSpeed;
  final double modInertiaSpeed;
  final double modAcceleration;
  final double modAccelerationAngular;
  double modGravity;
  final Sprite normal;

  Roket({
    required sprite,
    required this.normal,
    this.modInertiaAngularSpeed = 0.945,
    this.modInertiaSpeed = 0.985,
    this.modAcceleration = 2,
    this.modAccelerationAngular = 0.2,
    this.modGravity = 0.04,
  }) : super(sprite: sprite) {
    this.angle = 0;
  }

  double  inertiaAngularSpeed = 0;
  Vector2 inertiaSpeed = Vector2.zero();


  double speed = 10;
  double angularSpeed = 0.3;

  Vector2 lerpVec2(Vector2 a, Vector2 b, double t ) {
    return a * (1.0 - t) + b * t;
  }

  dynamic lerp(dynamic a, dynamic b, double t ) {
    return a * (1.0 - t) + b * t;
  }

  void process(double dt, Set<String> keysPressed, [double modmultiplier=1]) {
    updateMovement(dt, keysPressed, modmultiplier);
    //updateTexture(Vector2(900, 900));
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

  double angleVec2(Vector2 a, Vector2 b) {
    return math.atan2(a.y - b.y, a.x - b.x);
  }

  @override
  void render(Canvas c) async {

  super.render(c);
  normal.render(c, size: size) ;
  }

  get degreesAngle => angle * 180 / math.pi;

  void updateMovement(double dt, Set<String> keysPressed, [double modmultiplier=1]) async {
    angle += inertiaAngularSpeed;
    angle = normalizeDegrees(angle);
    double angularMovement = angularSpeed * dt * ((keysPressed.contains('Shift Left')) ? modAccelerationAngular : 1);
    if (keysPressed.contains('Q')) {
      angle -= angularMovement;
      inertiaAngularSpeed += -angularMovement;
    } else if (keysPressed.contains('E')) {
      angle += angularMovement;
      inertiaAngularSpeed += angularMovement;
    }
    inertiaAngularSpeed = lerp(inertiaAngularSpeed, 0, (1-modInertiaAngularSpeed));

    double movement = speed * dt * ((keysPressed.contains('Shift Left')) ? modAcceleration : 1);
    position += inertiaSpeed;
    Vector2 speedVector = Vector2(math.sin(angle)*movement, -math.cos(angle)*movement);
    inertiaSpeed += Vector2(0, modGravity);
    speedVector *= modmultiplier;
    if (keysPressed.contains('W')) {
      position += speedVector;
      inertiaSpeed += speedVector;
    }
    inertiaSpeed = lerpVec2(inertiaSpeed, Vector2.zero(), (1-modInertiaSpeed));
  }
}

class Star extends SpriteComponent {
  final double lifetime_s;
  final double fade_s;
  Vector2 speedVec;
  DateTime spawnTime = DateTime.now();
  Star({
    required this.speedVec,
    required this.lifetime_s,
    required this.fade_s,
  });

  @override
  void onLoad() {
    super.onLoad();
    spawnTime = DateTime.now();
  }

  process(double dt){
    position += speedVec * dt;
  }

  @override
  void render(Canvas c) async {
    super.render(c);
  }
}

class MyGame extends FlameGame with KeyboardEvents {
  late Roket roket;
  Set<String> keys = {};
  List<Star> stars = [];
  double multiplier = 1.0;
  bool gameStarted = false;
  bool justReloaded = true;


  @override
  Future<void> onLoad() async {
    await super.onLoad();
      keys = {};
      stars = [];
      multiplier = 1.0;
      gameStarted = false;

    roket = Roket(sprite: await Sprite.load('roket_base.png'), normal: await Sprite.load('roket_normals.png'));
    roket
      ..size = Vector2(50, 50)
      ..anchor = Anchor.center
      ..position = size / 2;
    roket.modGravity = 0.01;
    add(roket);
  }

    dynamic lerp(dynamic a, dynamic b, double t ) {
    return a * (1.0 - t) + b * t;
  }


  @override
  update(double dt) async {
    super.update(dt);

    if (gameStarted == false) return;

    if (roket.position.x < 0) {
      roket.position.x = size.x;
    } else if ( roket.position.x > size.x) {
      roket.position.x = 0;
    }
    if (roket.position.y < 0) {
      roket.position.y = size.y;
    } else if (roket.position.y > size.y - 100) {
      if (roket.position.y > size.y) {
        roket.position.y = 0;
      }
    }
      roket.process(dt, keys);

    stars.forEach((element) {
      double mul = 1;
      if (keys.contains("T")) {
        mul = 20;
        element.add(
        ColorEffect(
        Color.fromARGB(255, 224, 222, 255),
          const Offset(
            0.2,
            0.8,
          ), // Means, applies from 0% to 50% of the color
          EffectController(
            duration: lerp(1, 0, 0.1)),
          ),
      );
      }

      element.distance(roket);
      element.position += Vector2(1, 0.0001)  * roket.inertiaSpeed.x * dt * (element.speedVec.y/40) * mul;
      element.position += Vector2(0, 1)  * -roket.inertiaSpeed.y * dt * (element.speedVec.y/10)* mul;
      element.process(dt);
    });

    List<Star> starsToRemove = stars.where((element) => element.position.y > size.y).toList();
    if (starsToRemove.length >= 0) {
        starsToRemove.forEach((element) {
        remove(element);
        stars.remove(element);
      });
    }


    if (stars.length < 2000 && keys.contains('Shift Left')
     || keys.contains('W') && stars.length < 1000
     || stars.length < 200)  {
      String type =['star_yellow.png', 'star_rose_b.png','star_blue.png', 'star_rose_b.png', 'star_rose_b.png'][math.Random().nextInt(5)];

      double mul = 1;
      if (multiplier > 1 ) {
         mul = multiplier * math.Random().nextDouble();
      }
      Vector2 starSpeed = Vector2(0 , 1)*500*math.Random().nextDouble() * 10 * dt * mul;
      Vector2 starPosition = Vector2.zero();
      if (roket.inertiaSpeed.y < 140)  {
           starPosition = Vector2(1.0 + math.Random().nextDouble() * (size.x), 1.0);
      } else {
         starPosition =Vector2(1.0 + math.Random().nextDouble() * (size.x), size.y);
      }

      double starLifetime = size.y / starSpeed.y + 1;
   
      Star star = Star(fade_s: 4, lifetime_s: starLifetime, speedVec: starSpeed);
      star.position = starPosition;
      double d = math.Random().nextDouble() * (10);
      star.size = Vector2(d, d);
      star.sprite = await Sprite.load(type);

      Color color = [
     const Color.fromARGB(255, 225, 61, 61),
     const Color.fromARGB(255, 255, 136, 0),
     const Color.fromARGB(255, 0, 51, 255),
     const Color.fromARGB(255, 81, 0, 255),
     const Color.fromARGB(255, 0, 162, 255),
     const Color.fromARGB(255, 255, 255, 255),
     const Color.fromARGB(255, 255, 0, 0),
     const Color.fromARGB(255, 255, 94, 0),
      ][math.Random().nextInt(8)];

      star.add(
        ColorEffect(
        color,
          const Offset(
            0.0,
            0.8,
          ), // Means, applies from 0% to 50% of the color
          EffectController(
            duration: lerp(starLifetime, 0, 0.1)),
          ),
      );
      add(star);
      stars.add(star);
    }
  }

    @override
    void render(Canvas canvas) {
      super.render(canvas);
      if (gameStarted == false) {
        TextPaint textPaint = TextPaint(
          style: const TextStyle(
            fontSize: 48.0,
            fontFamily: 'Awesome Font',
          ),
        );
        textPaint.render(canvas,
        ' *Paused* \n Controls: \n Space - pause \n Q - rotare left \n E - rotare right \n W - go forward \n Left Shift - speedup \n T - hyperspace jump \n', Vector2(10, 10),);
      }
      stars.forEach((element) {
        element.render(canvas);
      });
    }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,
  ) {
    keys = keysPressed.map((e) => e.keyLabel).toSet();
    if (keys.contains('Shift Left')) {
      multiplier = 15;
    } else if (keys.contains('W')) {
      multiplier = 5;
    } else {
      multiplier = 1;
    }

    if (keys.contains(' ')) {
      gameStarted = !gameStarted;

    }


    return KeyEventResult.handled;
  }
}
