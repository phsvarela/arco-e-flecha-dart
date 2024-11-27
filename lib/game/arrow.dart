import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final/game/archery_world.dart';

class Arrow extends PositionComponent with CollisionCallbacks {
  Vector2 velocity = Vector2.zero();
  double shootAngle = 0.0;
  final double gravity = 600;
  double force = 0.0;
  double time = 0;
  bool isShoot = false;

  final double groundLevel;
  final double skyLimit;

  Arrow(
      {required Vector2 position,
      required this.groundLevel,
      required this.skyLimit}) {
    this.position = position;
    size = Vector2(100, 10);
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  bool isStopped() {
    return velocity.length < 0.1;
  }

  bool isOutOfBounds() {
    return position.x < -size.x ||
        position.x > size.x ||
        position.y < -size.y ||
        position.y > size.y;
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle = shootAngle;

    if (isShoot) {
      velocity.y += gravity * dt;
      position.add(Vector2(velocity.x, velocity.y) * dt);
      shootAngle = atan2(velocity.y, velocity.x);
      if (position.y >= groundLevel) {
        stopShootOnMiss();
      }

      if (position.y < skyLimit) {
        stopShootOnMiss();
        removeFromParent();
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = Colors.red;
    canvas.drawRect(size.toRect(), paint);
  }  

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Target && !isStopped()) {
      stopShootOnHit();
    }
  }

  void shoot(double force) {
    this.force = force;
    velocity =
        Vector2(force * 9 * cos(shootAngle), force * 9 * sin(shootAngle));
    isShoot = true;
  }

  void stopShootOnHit() {
    velocity = Vector2.zero();
    isShoot = false;
    final world = (parent as ArcheryWorld);
    world.updateCameraOnHit();
  }

    void stopShootOnMiss() {      
    velocity = Vector2.zero();
    isShoot = false;
    final world = (parent as ArcheryWorld);
    world.updateCameraOnMiss();
  }
}
