import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:somethin/utils/math_utils.dart';
import 'dart:math' as math;

class Roket extends SpriteComponent {
  final Utils utils = Utils();
  double modAngularInertia;
  double modSpeedInertia;
  double modSpeedAcceleration;
  double modAngularAcceleration;
  double modSpeedDeceleration;
  double modAngularDeceleration;
  double modGravity;

  double modTemporarySpeedBuff = 1;

  double inertiaAngularSpeed = 0;
  Vector2 inertiaSpeed = Vector2.zero();

  bool isMoving = false;
  bool isSpeedUp = false;
  bool isRotateLeft = false;
  bool isRotateRight = false;
  bool isSlowedDown = false;

  Color colorSpeedUp     = const Color.fromARGB(255, 0, 30, 255);
  Color colorSlowedDown  = const Color.fromARGB(255, 255, 0, 0);
  Color colorRotareLeft  = const Color.fromARGB(255, 255, 191, 0);
  Color colorRotareRight = const Color.fromARGB(255, 0, 170, 255);

  double speed = 10;
  double angularSpeed = 0.3;

  get angleDeg => utils.toDegrees(angle);
  set angleSetDeg(deg) { angle = utils.toRadians(deg); }

  Roket({
    required sprite,
    this.modAngularInertia      = 0.945,
    this.modSpeedInertia        = 0.985,
    this.modSpeedAcceleration   = 2,
    this.modAngularAcceleration = 0.2 ,
    this.modGravity             = 0.04,
    this.modAngularDeceleration = 1.5,
    this.modSpeedDeceleration   = 0.5,
  }) : super(sprite: sprite) {
    angle = 0;
  }

  void moveAngular(double dt) {
    angle += inertiaAngularSpeed; // add inertia
    angle = utils.toRadians(utils.normalizeDegrees(angleDeg)); // normalize ( cut and reassign )
    double angularMovement = angularSpeed * dt * ((isSpeedUp) ? modAngularAcceleration : (isSlowedDown) ? modAngularDeceleration : 1);
    if (isRotateLeft) {
      angle -= angularMovement;
      inertiaAngularSpeed += -angularMovement;
    } else if (isRotateRight) {
      angle += angularMovement;
      inertiaAngularSpeed += angularMovement;
    }
    inertiaAngularSpeed = utils.lerp(inertiaAngularSpeed, 0, (1-modAngularInertia));
  }

  void moveGeneral(double dt) {
    position += inertiaSpeed + Vector2(0, modGravity); // inertia + gravity movement
    if (isMoving) {
      double currentMovement = speed * dt * ((isSpeedUp) ? modSpeedAcceleration : (isSlowedDown) ? modSpeedDeceleration : 1);
      Vector2 movementVec2 = Vector2(math.sin(angle)*currentMovement, -math.cos(angle)*currentMovement);
      movementVec2 *= (isSpeedUp) ? modTemporarySpeedBuff : 1;
      position += movementVec2;
      inertiaSpeed += movementVec2;
    }
    // Cut inertia speed
    inertiaSpeed = utils.lerpVec2(inertiaSpeed, Vector2.zero(), (1-modSpeedInertia));
  }

  void move(double dt) {
    moveAngular(dt);
    moveGeneral(dt);
  }

  void keepOnScreen(sizex, sizey){
    if (position.x < 0) {
      position.x = sizex;
    } else if ( position.x > sizex) {
      position.x = 0;
    }
    if (position.y < 0) {
      position.y = sizey;
    } else if (position.y > sizey - 100) {
      if (position.y > sizey) {
        position.y = 0;
      }
    }
  }

  ParticleSystemComponent particles(double spread, double modSpeed, double count, Color color, double lifespan, double angularSpeed) {
    ParticleSystemComponent particle = ParticleSystemComponent(
      particle: Particle.generate(
        count: 10,
        lifespan: lifespan,
        generator: (i) => AcceleratedParticle(
          acceleration: Vector2(0, math.Random().nextDouble()*100),
          speed: Vector2((math.Random().nextDouble()-0.5)*spread + angularSpeed, modSpeed * ((isSpeedUp ? modSpeedAcceleration : (isSlowedDown) ? modSpeedDeceleration : 1))) * 100,
          position: Vector2(size.x, size.y+size.y/1.5)/2,
          child: CircleParticle(
            radius: 0.6,
            paint: Paint()..color = color,
          ),
        )
      )
    );
    return particle;
  }

  void visualEffects() {
    colorEffects();
    if (isMoving) {
      double spread = size.x/50 * (isSpeedUp ? modSpeedDeceleration  : (isSlowedDown) ?modSpeedAcceleration : 1);
      double speed = 2 * size.x/50;
      double count = 20 / size.x /50;
      // fire
      Color blue = Color.fromARGB(255, 103, 98, 252);
      Color blueLighter = const Color.fromARGB(255, 124, 143, 252);
      Color blueLight = const Color.fromARGB(255, 202, 207, 255);
      add(particles(spread/10, speed/3,  count/2, blueLight, 0.2,      speed/3 *5 * inertiaAngularSpeed,));
      add(particles(math.Random().nextDouble() * spread/2, math.Random().nextDouble() * speed/1.5,  count*2, blue, 0.2, speed/2 *5 * inertiaAngularSpeed,));
      add(particles(spread/3,  speed/10, count, blue, 0.2,    speed/10*5* inertiaAngularSpeed));
      add(particles(spread/5,  speed/5,  count/3,  blueLighter, 0.2,    speed/5 *5 * inertiaAngularSpeed));
    }
  }

  void colorEffects() {
    if (isSpeedUp || isSlowedDown || isRotateLeft || isRotateRight) {
      add(ColorEffect(
        ((isSpeedUp) ? colorSpeedUp : (isSlowedDown) ? colorSlowedDown : (isRotateLeft) ? colorRotareLeft : colorRotareRight),
        const Offset(0.2, 0.4,),
        EffectController(duration:0))
      );
    } else {
      add(ColorEffect(
        const Color.fromARGB(0, 255, 255, 255),
        const Offset(0.0, 0,),
        EffectController(duration:0))
      );
    }
  }

  @override
  onLoad() {
    super.onLoad();
  }

  process(double dt, Set<String> keysPressed, size) {
    handleKeys(keysPressed);
    move(dt);
    visualEffects();
    keepOnScreen(size.x, size.y);
  }

  void handleKeys(Set<String> keysPressed) {
    isMoving =      keysPressed.contains('W');
    isRotateLeft =  keysPressed.contains('A');
    isRotateRight = keysPressed.contains('D');
    isSpeedUp =     keysPressed.contains('Shift Left');
    isSlowedDown =  keysPressed.contains(' ');
  }

  @override
  render(Canvas c) {
    super.render(c);
  }
}