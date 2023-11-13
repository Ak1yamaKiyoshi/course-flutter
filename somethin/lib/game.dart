
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'actors/roket.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:somethin/utils/math_utils.dart';
import 'dart:math' as math;


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




class SpaceSomething extends FlameGame with KeyboardEvents {
  late Roket roket;
  Set<String> keys = {};
    final Utils utils = Utils();
  List<ParticleSystemComponent> particleArray = [];
  List<Star> stars = [];
  double multiplier = 1.0;
  bool isPaused = true;

  @override
  Future<void> onLoad() async {
    loadRoket();
    await super.onLoad();
  }

  void loadRoket() async {
    roket = Roket(sprite: await Sprite.load("roket_normals.png"))
    ..modGravity = 5
    ..position = Vector2(size.x/2, size.y/2)
    ..anchor = Anchor.center
    ..modTemporarySpeedBuff = 1
    ..speed = 10
    ..angularSpeed = 0.6
    ..modSpeedInertia = 0.985
    ..modSpeedAcceleration = 1.5
    ..modAngularInertia = 0.9
    ..modAngularAcceleration = 0.3
    ..modAngularDeceleration = 1.5
    ..modSpeedDeceleration = 0.5
    ..size = Vector2(60, 60);
    add(roket);
  }

  ParticleSystemComponent particles(color, lifespan, x, y, dx, dy, count, child) {
    ParticleSystemComponent particle = ParticleSystemComponent(
      particle: Particle.generate(
        count: count,
        lifespan: lifespan,
        generator: (i) => AcceleratedParticle(
          acceleration: Vector2(0, math.Random().nextDouble()*100),
          speed: Vector2(dx, dy),
          position: Vector2(x, y),
          child: child,
        )
      )
    );
    return particle;
  }

  void drawStars(dt) async {
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
            duration: utils.lerp(1, 0, 0.1)),
          ),
      );
      }

      element.distance(roket);
      element.position += Vector2(1, 0.0001)  * roket.inertiaSpeed.x * dt * (element.speedVec.y/40) * mul;
      element.position += Vector2(0, 1)  * -roket.inertiaSpeed.y * dt * (element.speedVec.y/10)* mul;
      element.process(dt);
    });

    List<Star> starsToRemove = stars.where((element) => element.position.y > size.y || element.position.y < 0).toList();
    if (starsToRemove.length >= 0) {
        starsToRemove.forEach((element) {
        remove(element);
        stars.remove(element);
      });
    }


    if (stars.length < 2000 && keys.contains('Shift Left')
     || keys.contains('W') && stars.length < 1000
     || stars.length < 200)  {
      String type =['star_yellow.png','star_blue.png'][math.Random().nextInt(2)];

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
            duration: utils.lerp(starLifetime, 0, 0.7)),
          ),
      );
      add(star);
      stars.add(star);
    }
  }

  @override
  update(double dt) async {
    if (isPaused == true) return;
    super.update(dt);
    drawStars(dt);
    roket.process(dt, keys, size);
  }

  @override
  void render(Canvas canvas) {
    if (isPaused) {
        TextPaint textPaint = TextPaint(
          style: const TextStyle(
            fontSize: 36.0,
            fontFamily: 'Awesome Font',
          ),
        );
        textPaint.render(canvas,
        ''
        + '\n Controls:'
        + '\n > Escape - Pause / Unpause'
        + '\n > W - move forward'
        + '\n > Space - Quick rotate, slow movement'
        + '\n > Shift - Slow rotate, fast movement'
        + '\n > A - rotate left'
        + '\n > D - rotate right'
        + '\n > T - hyperspace jump'
        + '\n Use english keyboard layout '
        + '\n (if you want controls to work)'
        + '\n By @akiyama, in progress of development'
        , Vector2(size.x/2/2, size.y/2/2/2/2/2),);
      }
    super.render(canvas);
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,
  ) {
    keys = keysPressed.map((e) => e.keyLabel).toSet();
    handleKeys();
    return KeyEventResult.handled;
  }

  void handleKeys(){
    print(keys);
    if (keys.contains('Shift Left')) {
      multiplier = 15;
    } else if (keys.contains('W')) {
      multiplier = 5;
    } else {
      multiplier = 1;
    }
    if (keys.contains('Escape')) {
      isPaused = !isPaused;
    }
  }
}
