import 'package:flutter/material.dart';
import '../Core/AppColors.dart';
import '../Core/Constants.dart';
import '../Models/MessageModel.dart';

class MessageBubble extends StatefulWidget {
  final MessageModel message;
  final bool isFirst;

  const MessageBubble({
    super.key,
    required this.message,
    this.isFirst = true,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: AppConstants.animNormal,
    );
    _fadeAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: Offset(widget.message.isUser ? 0.05 : -0.05, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUser = widget.message.isUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final maxBubbleWidth = screenWidth * 0.85;

    final bubbleColor = isUser
        ? (isDark ? AppColors.lightBeige : AppColors.darkGraphite)
        : Colors.transparent;

    final textColor = isUser
        ? (isDark ? AppColors.darkGraphite : AppColors.lightBeige)
        : (isDark ? AppColors.lightBeige : AppColors.darkGraphite);

    final borderColor = isDark ? AppColors.lightBeige : AppColors.darkGraphite;

    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(0),
      topRight: const Radius.circular(0),
      bottomLeft: const Radius.circular(0),
      bottomRight: const Radius.circular(0),
    );

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Padding(
          padding: EdgeInsets.only(
            left: isUser ? screenWidth * 0.15 : 0,
            right: isUser ? 0 : screenWidth * 0.15,
            bottom: AppConstants.spaceM,
          ),
          child: Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxBubbleWidth),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spaceM,
                      vertical: AppConstants.spaceM,
                    ),
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      borderRadius: borderRadius,
                      border: Border.all(
                        color: borderColor,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      widget.message.content,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: textColor,
                            fontSize: 15.0,
                            height: 1.6,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
