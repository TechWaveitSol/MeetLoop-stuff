import '../../../../core/errors/failure.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource _remoteDatasource;

  ChatRepositoryImpl({required ChatRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Stream<List<MessageEntity>> getMessages(String chatId) {
    return _remoteDatasource.getMessages(chatId).map((models) => models);
  }

  @override
  Future<void> sendMessage(MessageEntity message) async {
    try {
      final model = MessageModel(
        id: message.id,
        chatId: message.chatId,
        senderId: message.senderId,
        receiverId: message.receiverId,
        text: message.text,
        mediaUrl: message.mediaUrl,
        mediaType: message.mediaType,
        timestamp: message.timestamp,
        isRead: message.isRead,
        reactions: message.reactions,
        replyToMessageId: message.replyToMessageId,
      );
      await _remoteDatasource.sendMessage(model);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> markAsRead(String chatId, String messageId) async {
    try {
      await _remoteDatasource.markAsRead(chatId, messageId);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> addReaction(String chatId, String messageId, String userId, String emoji) async {
    try {
      await _remoteDatasource.addReaction(chatId, messageId, userId, emoji);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> deleteMessage(String chatId, String messageId) async {
    try {
      await _remoteDatasource.deleteMessage(chatId, messageId);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> getChats(String uid) {
    return _remoteDatasource.getChats(uid);
  }
}
