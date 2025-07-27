import 'package:flutter/material.dart';
import '../services/gemini_service.dart'; // Ajusta el path
import 'settings_screen.dart';
import '../l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.insert(0, {'role': 'user', 'text': text});
      _controller.clear();
      _isLoading = true;
    });

    final reply = await GeminiService.chat(text, context);

    if (!mounted) return;

    setState(() {
      _messages.insert(0, {'role': 'bot', 'text': reply});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: localizations.restart_chat,
            onPressed: () {
              setState(() {
                _messages.clear();
              });
              GeminiService.reset();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: localizations.settings,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Lista de mensajes
            Expanded(
              child: _messages.isEmpty
                  ? Center(
                      child: Text(
                        localizations.noMessages,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : ListView.separated(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      itemCount: _messages.length,
                      itemBuilder: (_, index) {
                        final message = _messages[index];
                        final isUser = message['role'] == 'user';

                        return Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isUser
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: const Radius.circular(16),
                                bottomLeft: Radius.circular(isUser ? 16 : 0),
                                bottomRight: Radius.circular(isUser ? 0 : 16),
                              ),
                            ),
                            child: Text(
                              message['text']!,
                              style: TextStyle(
                                color: isUser
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        );
                      },

                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                    ),
            ),

            if (_isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: CircularProgressIndicator(),
              ),

            // Campo de texto
            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: localizations.hintMessage,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                      tooltip: localizations.send,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
