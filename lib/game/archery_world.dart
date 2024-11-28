import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final/game/archery_bow.dart';
import 'package:projeto_final/game/archery_game.dart';
import 'package:projeto_final/game/arrow.dart';

class ArcheryWorld extends World with DragCallbacks {
  late ArcheryBow archeryBow;
  late CameraComponent mainCamera;
  late Ground ground;
  late Sky sky;
  late Target target;
  late Arrow arrow;
  late Vector2 _dragStartPosition;
  Vector2? _dragCurrentPosition;
  double shootAngle = 0.0;
  double force = 0.0;
  bool bowIsDragging = false;
  late Vector2 worldSize;
  late double worldWidth;
  late double worldHeight;
  double arrowCount = 3;
  late TextComponent arrowLabel;
  double score = 0;
  late TextComponent scoreLabel;
  double hits = 0;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    worldSize = mainCamera.viewport.size;
    worldWidth = worldSize.x * 8;
    worldHeight = worldSize.y * 8;

    _createScenario();
    _addScenario();
    _createArrowOnBow();
    _setCameraBoundsAndStartAnimation();
    mainCamera.follow(arrow);
    _createHUD();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (arrowCount == 0) {
      
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    if (archeryBow.containsPoint(event.localPosition)) {
      _dragStartPosition = event.localPosition;
      _dragCurrentPosition = null;
      bowIsDragging = true;
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (bowIsDragging) {
      _dragCurrentPosition = event.localEndPosition;
      final direction = _dragCurrentPosition! - _dragStartPosition;
      shootAngle = atan2(direction.y, direction.x);
      force = (direction.length / 3) * -1;
      arrow.shootAngle = shootAngle;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    if (bowIsDragging) {
      arrow.shoot(force);
      bowIsDragging = false;
    }
  }

  void setCamera(CameraComponent camera) {
    mainCamera = camera;
  }

  void _createArrowOnBow() {
    arrow = Arrow(
        position: archeryBow.position.clone(),
        groundLevel: ground.position.y,
        skyLimit: sky.position.y);
    add(arrow);
  }

  void _createScenario() {
    ground = Ground(
        position: Vector2(-worldWidth / 2, 0),
        size: Vector2(worldWidth * 4, worldHeight / 2));
    sky = Sky(
        position: Vector2(-worldWidth / 2, -worldHeight / 2),
        size: Vector2(worldWidth * 4, worldHeight));
    target = Target(position: Vector2(1000, -200), size: Vector2(120, 120));
    archeryBow = ArcheryBow(position: Vector2(0, -200));
  }

  void _addScenario() {
    addAll([sky, ground]);
    add(archeryBow);
    add(target);
  }

  void _setCameraBoundsAndStartAnimation() async {
    final bounds = Rectangle.fromLTRB(
        -worldWidth / 2, -worldHeight / 2, worldWidth / 2, worldHeight / 2);
    mainCamera.setBounds(bounds);
    mainCamera.viewfinder.zoom = 0.2;

    await Future.delayed(const Duration(seconds: 1));

    const zoomDuration = 3.0;
    double elapsedTime = 0;

    add(TimerComponent(
      period: 1 / 60,
      repeat: true,
      onTick: () {
        elapsedTime += 1 / 60;
        final t = (elapsedTime / zoomDuration).clamp(0, 1);
        mainCamera.viewfinder.zoom = 0.2 + (1.0 - 0.2) * t;

        if (t >= 1.0) {
          mainCamera.viewfinder.zoom = 1.0;
        }
      },
    ));
  }

  void updateCameraOnHit() {
    target.attachArrow(arrow);
    hits++;
    score += 100;
    updateHUD();
    _createArrowOnBow();
    mainCamera.follow(arrow);
    target.moveWithArrows();
  }

  void updateCameraOnMiss() {
    arrowCount--;
    updateHUD();
    if(arrowCount == 0){
      (parent as ArcheryGame).showGameOverMenu(score);
    }
    _createArrowOnBow();
    mainCamera.follow(arrow);
  }

  void _createHUD() {
    scoreLabel = TextComponent(
        text: "Pontos: $score",
        position: Vector2(20, 20),
        textRenderer: TextPaint(
            style: const TextStyle(color: Colors.white, fontSize: 20)));
    arrowLabel = TextComponent(
        text: "Flechas: $arrowCount",
        position: Vector2(20, 50),
        textRenderer: TextPaint(
            style: const TextStyle(color: Colors.white, fontSize: 20)));

    mainCamera.viewport.addAll([scoreLabel, arrowLabel]);
  }

  void updateHUD() {
    scoreLabel.text = 'Pontos: $score';
    arrowLabel.text = 'Flechas: $arrowCount';
  }
}

class Ground extends PositionComponent {
  Ground({required Vector2 position, required Vector2 size}) {
    this.position = position;
    this.size = size;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = Colors.green;
    canvas.drawRect(size.toRect(), paint);
  }
}

class Sky extends PositionComponent {
  Sky({required Vector2 position, required Vector2 size}) {
    this.position = position;
    this.size = size;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = Colors.blue;
    canvas.drawRect(size.toRect(), paint);
  }
}

class Target extends PositionComponent with CollisionCallbacks {
  List<Arrow> attachedArrows = [];
  Target({required Vector2 position, required Vector2 size}) {
    this.position = position;
    this.size = size;
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = Colors.pink;
    canvas.drawRect(size.toRect(), paint);
  }

  void attachArrow(Arrow arrow) {
    attachedArrows.add(arrow);
  }

  void moveWithArrows() {
    final world = (parent as ArcheryWorld);
    position.x = position.x + 25 * world.arrowCount;

    for (var arrow in attachedArrows) {
      arrow.position.x = arrow.position.x + 25 * world.arrowCount;
    }
  }
}
