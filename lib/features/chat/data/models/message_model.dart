import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required String id,
    required String chatId,
    required String senderId,
    required String receiverId,
    required String text,
    String? mediaUrl,
    String mediaType = 'text',
    required DateTime timestamp,
    bool isRead = false,
    Map<String, String> reactions = const {},
    String? replyToMessageId,
  }) : super(
          id: id,
          chatId: chatId,
          senderId: senderId,
          receiverId: receiverId,
          text: text,
          mediaUrl: mediaUrl,
          mediaType: mediaType,
          timestamp: timestamp,
          isRead: isRead,
          reactions: reactions,
          replyToMessageId: replyToMessageId,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    DateTime ts;
    if (json['timestamp'] is Timestamp) {
      ts = (json['timestamp'] as Timestamp).toDate();
    } else if (json['timestamp'] is String) {
      ts = DateTime.parse(json['timestamp'] as String);
    } else {
      ts = DateTime.now();
    }

    return MessageModel(
      id: json['id'] as String? ?? '',
      chatId: json['chatId'] as String? ?? '',
      senderId: json['senderId'] as String? ?? '',
      receiverId: json['receiverId'] as String? ?? '',
      text: json['text'] as String? ?? '',
      mediaUrl: json['mediaUrl'] as String?,
      mediaType: json['mediaType'] as String? ?? 'text',
      timestamp: ts,
      isRead: json['isRead'] as bool? ?? false,
      reactions: Map<String, String>.from(json['reactions'] ?? {}),
      replyToMessageId: json['replyToMessageId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'reactions': reactions,
      'replyToMessageId': replyToMessageId,
    };
  }
}
