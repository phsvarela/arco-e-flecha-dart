import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ArcheryBow extends PositionComponent {

  ArcheryBow({required Vector2 position}) {
    this.position = position;
    size = Vector2(150, 300);
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = Colors.black;
    canvas.drawRect(size.toRect(), paint);
  }
}
