import 'package:bonfire/mixins/direction_animation.dart';
import 'package:bonfire/mixins/jumper.dart';
import 'package:bonfire/util/direction.dart';
import 'package:bonfire/util/direction_animations/simple_animation_enum.dart';

enum JumpAnimationsEnum {
  jumpUpRight,
  jumpUpLeft,
  jumpDownRight,
  jumpDownLeft,
}

mixin JumperAnimation on Jumper, DirectionAnimation {
  @override
  void onPlayRunDownAnimation() {
    if (jumping) {
      if (lastDirectionHorizontal == Direction.left) {
        _jumpDownLeft();
      } else {
        animation?.playOther(
          JumpAnimationsEnum.jumpDownRight.name,
          flipX: false,
        );
      }
    } else {
      if (lastDirectionHorizontal == Direction.left) {
        animation?.play(SimpleAnimationEnum.idleLeft);
      } else {
        animation?.play(SimpleAnimationEnum.idleRight);
      }
    }
  }

  @override
  void onPlayRunDownLeftAnimation() {
    if (jumping) {
      _jumpDownLeft();
    } else {
      super.onPlayRunDownLeftAnimation();
    }
  }

  @override
  void onPlayRunDownRightAnimation() {
    if (jumping) {
      animation?.playOther(JumpAnimationsEnum.jumpDownRight.name, flipX: false);
    } else {
      super.onPlayRunDownRightAnimation();
    }
  }

  @override
  void onPlayRunUpLeftAnimation() {
    if (jumping) {
      _playJumpUpLeft();
    } else {
      super.onPlayRunUpLeftAnimation();
    }
  }

  @override
  void onPlayRunUpRightAnimation() {
    if (jumping) {
      animation?.playOther(JumpAnimationsEnum.jumpUpRight.name, flipX: false);
    } else {
      super.onPlayRunUpRightAnimation();
    }
  }

  @override
  void onPlayRunUpAnimation() {
    if (jumping) {
      if (lastDirectionHorizontal == Direction.left) {
        _playJumpUpLeft();
      } else {
        animation?.playOther(JumpAnimationsEnum.jumpUpRight.name, flipX: false);
      }
    } else {
      super.onPlayRunUpAnimation();
    }
  }

  void _playJumpUpLeft() {
    if (animation?.containOther(JumpAnimationsEnum.jumpUpLeft.name) == true) {
      animation?.playOther(JumpAnimationsEnum.jumpUpLeft.name);
    } else {
      animation?.playOther(
        JumpAnimationsEnum.jumpUpRight.name,
        flipX: true,
      );
    }
  }

  void _jumpDownLeft() {
    if (animation?.containOther(JumpAnimationsEnum.jumpDownLeft.name) == true) {
      animation?.playOther(JumpAnimationsEnum.jumpDownLeft.name);
    } else {
      animation?.playOther(
        JumpAnimationsEnum.jumpDownRight.name,
        flipX: true,
      );
    }
  }

  @override
  void idle() {
    if (!jumping) {
      super.idle();
    }
  }
}