import 'package:flutter/material.dart';
import '../Core/AppColors.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _anims = [];

  static const int _dotCount = 3;
  static const Duration _dotDelay = Duration(milliseconds: 200);
  static const Duration _dotDuration = Duration(milliseconds: 600);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _dotCount; i++) {
      final ctrl = AnimationController(vsync: this, duration: _dotDuration);
      _controllers.add(ctrl);
      _anims.add(
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 50),
          TweenSequenceItem(tween: Tween(begin: -8, end: 0), weight: 50),
        ]).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeInOut)),
      );
      Future.delayed(_dotDelay * i, () {
        if (mounted) ctrl.repeat();
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final dotColor = isDark ? AppColors.lightBeige : AppColors.darkGraphite;
    final borderColor = isDark ? AppColors.lightBeige : AppColors.darkGraphite;

    return Padding(
      padding: const EdgeInsets.only(left: 40, bottom: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.zero,
              border: Border.all(
                color: borderColor,
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_dotCount, (i) {
                return AnimatedBuilder(
                  animation: _anims[i],
                  builder: (_, __) => Transform.translate(
                    offset: Offset(0, _anims[i].value),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
