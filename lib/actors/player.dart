import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_test/pixel_adventure.dart';

enum PlayerState {
  idle,
  running,
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure> {
  String character;

  Player({position, required this.character}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;

  final idleStepTime = 0.05;
  final runningStepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();

    return super.onLoad();
  }

  void _loadAllAnimations() {
    runningAnimation = _spriteAnimation(
      state: 'Run',
      frameAmount: 12,
      stepTime: runningStepTime,
    );

    idleAnimation = _spriteAnimation(
      state: 'Idle',
      frameAmount: 11,
      stepTime: idleStepTime,
    );

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
    };

    // Set current animation
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation({
    required String state,
    required int frameAmount,
    required double stepTime,
  }) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: frameAmount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
