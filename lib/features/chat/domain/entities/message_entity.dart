import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String chatId;
  final String senderId;
  final String receiverId;
  final String text;
  final String? mediaUrl;
  final String mediaType; // 'text' | 'image' | 'video' | 'audio' | 'location'
  final DateTime timestamp;
  final bool isRead;
  final Map<String, String> reactions; // userId -> emoji
  final String? replyToMessageId;

  const MessageEntity({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.text,
    this.mediaUrl,
    this.mediaType = 'text',
    required this.timestamp,
    this.isRead = false,
    this.reactions = const {},
    this.replyToMessageId,
  });

  MessageEntity copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? receiverId,
    String? text,
    String? mediaUrl,
    String? mediaType,
    DateTime? timestamp,
    bool? isRead,
    Map<String, String>? reactions,
    String? replyToMessageId,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      text: text ?? this.text,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      reactions: reactions ?? this.reactions,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        chatId,
        senderId,
        receiverId,
        text,
        mediaUrl,
        mediaType,
        timestamp,
        isRead,
        reactions,
        replyToMessageId,
      ];
}
