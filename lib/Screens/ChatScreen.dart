import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Core/AppColors.dart';
import '../Core/Constants.dart';
import '../Providers/ChatProvider.dart';
import '../Providers/AuthProvider.dart';
import '../Components/MessageBubble.dart';
import '../Components/TypingIndicator.dart';
import '../Components/ChatInputField.dart';
import 'ProfileScreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToBottom({bool animated = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollCtrl.hasClients) return;
      if (animated) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: AppConstants.animNormal,
          curve: Curves.easeOut,
        );
      } else {
        _scrollCtrl.jumpTo(_scrollCtrl.position.maxScrollExtent);
      }
    });
  }

  Future<void> _handleSend(String text) async {
    final chat = context.read<ChatProvider>();
    chat.sendMessage(text);
    _scrollToBottom();
    Future.delayed(AppConstants.typingDelay + const Duration(milliseconds: 300),
        () => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final auth = context.watch<AuthProvider>();
    final chat = context.watch<ChatProvider>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= AppConstants.tabletBreakpoint;

    return Scaffold(
      appBar: _buildAppBar(context, auth, isDark, isDesktop),
      body: Column(
        children: [
          Expanded(
            child: chat.messages.isEmpty
                ? _EmptyState(isDark: isDark)
                : NotificationListener<ScrollNotification>(
                    child: ListView.builder(
                      controller: _scrollCtrl,
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop
                            ? (screenWidth - AppConstants.maxContentWidth) / 2
                            : AppConstants.spaceM,
                        vertical: AppConstants.spaceM,
                      ),
                      itemCount: chat.messages.length + (chat.isTyping ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (chat.isTyping && index == chat.messages.length) {
                          return const TypingIndicator();
                        }
                        return MessageBubble(
                          key: ValueKey(chat.messages[index].id),
                          message: chat.messages[index],
                        );
                      },
                    ),
                    onNotification: (_) => true,
                  ),
          ),
          isDesktop
              ? Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        maxWidth: AppConstants.maxContentWidth),
                    child: ChatInputField(
                      onSend: _handleSend,
                      isDisabled: chat.isTyping,
                    ),
                  ),
                )
              : ChatInputField(
                  onSend: _handleSend,
                  isDisabled: chat.isTyping,
                ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    AuthProvider auth,
    bool isDark,
    bool isDesktop,
  ) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppConstants.appName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
              ),
              Text(
                'AI Assistant',
                style: GoogleFonts.roboto(
                  fontSize: 11,
                  color: isDark ? AppColors.primaryLight : AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: 'Clear chat',
          icon: Icon(
            Icons.delete_sweep_outlined,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
          onPressed: () => _showClearDialog(context),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          ),
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                auth.currentUser?.email?.isNotEmpty == true
                    ? auth.currentUser!.email![0].toUpperCase()
                    : 'U',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Chat'),
        content: const Text('This will delete all messages in this session.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<ChatProvider>().clearChat();
              Navigator.of(ctx).pop();
            },
            child: Text(
              'Clear',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool isDark;
  const _EmptyState({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      '✨ Explain quantum computing simply',
      '💡 Write a Flutter widget for a gradient button',
      '🎯 Give me 5 productivity tips for developers',
      '🌍 What are the latest AI trends?',
    ];

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              'Hello! I\'m NeuroChat',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 22),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Your AI assistant, powered by Gemini.\nAsk me anything to get started!',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: suggestions
                  .map((s) => _SuggestionChip(text: s, isDark: isDark))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String text;
  final bool isDark;
  const _SuggestionChip({required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final clean = text
            .replaceAll(RegExp(r'^[\p{Emoji}\s]+', unicode: true), '')
            .trim();
        context
            .read<ChatProvider>()
            .sendMessage(clean.isNotEmpty ? clean : text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurfaceVariant
              : AppColors.lightSurfaceVariant,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
        ),
      ),
    );
  }
}
