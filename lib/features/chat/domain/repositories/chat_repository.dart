import '../../domain/entities/message_entity.dart';

abstract class ChatRepository {
  Stream<List<MessageEntity>> getMessages(String chatId);

  Future<void> sendMessage(MessageEntity message);

  Future<void> markAsRead(String chatId, String messageId);

  Future<void> addReaction(String chatId, String messageId, String userId, String emoji);

  Future<void> deleteMessage(String chatId, String messageId);

  Stream<List<Map<String, dynamic>>> getChats(String uid);
}
