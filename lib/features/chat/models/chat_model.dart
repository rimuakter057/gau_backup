class ChatMessage {
  final String text;
  final bool isMe;
  final String status;

  ChatMessage({
    required this.text,
    required this.isMe,
    this.status = 'sending',
  });
}