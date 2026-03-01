import 'package:flutter/material.dart';
import '../Core/AppColors.dart';
import '../Core/Constants.dart';

class ChatInputField extends StatefulWidget {
  final void Function(String) onSend;
  final bool isDisabled;

  const ChatInputField({
    super.key,
    required this.onSend,
    this.isDisabled = false,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);
  }

  void _handleSend() {
    if (!_hasText || widget.isDisabled) return;
    final text = _controller.text.trim();
    _controller.clear();
    widget.onSend(text);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final containerBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final sendBtnColor = isDark ? AppColors.darkBorder : AppColors.darkGraphite;
    final sendBtnIconColor =
        isDark ? AppColors.darkSurface : AppColors.lightBeige;

    return Container(
      padding: EdgeInsets.only(
        left: AppConstants.spaceM,
        right: AppConstants.spaceM,
        top: AppConstants.spaceS,
        bottom: AppConstants.spaceS + bottomPadding,
      ),
      decoration: BoxDecoration(
        color: containerBg,
        border: Border(
          top: BorderSide(
            color: borderColor,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 130),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: borderColor,
                  width: 1.0,
                ),
              ),
              child: TextField(
                controller: _controller,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                enabled: !widget.isDisabled,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  hintText: widget.isDisabled
                      ? 'NeuroChat is thinking…'
                      : 'Type a message…',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  fillColor: Colors.transparent,
                  filled: false,
                ),
                onSubmitted: (_) => _handleSend(),
              ),
            ),
          ),
          const SizedBox(width: AppConstants.spaceS),
          GestureDetector(
            onTap: _handleSend,
            child: AnimatedOpacity(
              opacity: _hasText && !widget.isDisabled ? 1.0 : 0.3,
              duration: AppConstants.animFast,
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: sendBtnColor,
                  borderRadius: BorderRadius.zero,
                  border: Border.all(
                    color: borderColor,
                    width: 1.0,
                  ),
                ),
                child: Icon(
                  Icons.send_rounded,
                  color: sendBtnIconColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
