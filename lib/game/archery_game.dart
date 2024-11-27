import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:projeto_final/game/archery_bow.dart';
import 'package:projeto_final/game/archery_world.dart';
import 'package:projeto_final/game/arrow.dart';

class ArcheryGame extends FlameGame with TapDetector, HasCollisionDetection {
  late ArcheryBow bow;
  late Arrow arrow;
  late World worldGame;
  late SpriteComponent pauseButton;
  late Sprite pauseButtomSprite;
  late CameraComponent mainCamera;
  late double finalScore;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    pauseButtomSprite = await loadSprite('pause_buttom.png');
    _initializeWorld();
  }

  void reset() {
    removeAll(children);
    _initializeWorld();
    resumeEngine();
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);

    if (pauseButton.containsPoint(info.eventPosition.global)) {
      overlays.add('PauseMenu');
      pauseEngine();
    }
  }

  void showGameOverMenu(double score){
    overlays.add('GameOverMenu');
    finalScore = score;
    pauseEngine();
  }    

  void _initializeWorld() async {
    worldGame = ArcheryWorld();

    pauseButton = SpriteComponent(
        sprite: pauseButtomSprite,
        size: Vector2(60, 60),
        position: Vector2(size.x - 60 - 20, 20));

    mainCamera = CameraComponent(
        world: worldGame, viewport: MaxViewport(children: [pauseButton]));
    add(mainCamera);

    (worldGame as ArcheryWorld).setCamera(mainCamera);

    add(worldGame);
  }
}
