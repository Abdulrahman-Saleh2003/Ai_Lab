enum MessageSender { user, ai }

class Message {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;
  final bool isTyping;
  final Suggestion? suggestion;

  Message({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.isTyping = false,
    this.suggestion,
  });
}

class Suggestion {
  final String title;
  final String subtitle;
  final String icon;

  Suggestion({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}