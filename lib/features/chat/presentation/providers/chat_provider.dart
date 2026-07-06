import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/datasources/chat_remote_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repository.dart';

// Firestore Provider dependency injection
final chatFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// Remote Datasource Provider
final chatRemoteDatasourceProvider = Provider<ChatRemoteDatasource>((ref) {
  final firestore = ref.watch(chatFirestoreProvider);
  return ChatRemoteDatasourceImpl(firestore: firestore);
});

// Repository Provider
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final remoteDatasource = ref.watch(chatRemoteDatasourceProvider);
  return ChatRepositoryImpl(remoteDatasource: remoteDatasource);
});

// Chats stream provider (list of active dialogs for current user)
final userChatsProvider = StreamProvider.family<List<Map<String, dynamic>>, String>((ref, uid) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getChats(uid);
});

// Messages stream provider for a given chatId
final chatMessagesProvider = StreamProvider.family<List<MessageEntity>, String>((ref, chatId) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getMessages(chatId);
});

// StateNotifier for Chat operations
class ChatControllerState {
  final bool isLoading;
  final String? errorMessage;

  const ChatControllerState({
    this.isLoading = false,
    this.errorMessage,
  });
}

class ChatController extends StateNotifier<ChatControllerState> {
  final ChatRepository _repository;

  ChatController(this._repository) : super(const ChatControllerState());

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String text,
    String? mediaUrl,
    String mediaType = 'text',
    String? replyToMessageId,
  }) async {
    final message = MessageEntity(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      chatId: chatId,
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      mediaUrl: mediaUrl,
      mediaType: mediaType,
      timestamp: DateTime.now(),
      replyToMessageId: replyToMessageId,
    );

    try {
      await _repository.sendMessage(message);
    } catch (e) {
      state = ChatControllerState(errorMessage: e.toString());
    }
  }

  Future<void> addReaction(String chatId, String messageId, String userId, String emoji) async {
    try {
      await _repository.addReaction(chatId, messageId, userId, emoji);
    } catch (e) {
      state = ChatControllerState(errorMessage: e.toString());
    }
  }

  Future<void> markAsRead(String chatId, String messageId) async {
    try {
      await _repository.markAsRead(chatId, messageId);
    } catch (e) {
      state = ChatControllerState(errorMessage: e.toString());
    }
  }
}

// Chat Controller Provider
final chatControllerProvider = StateNotifierProvider<ChatController, ChatControllerState>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatController(repository);
});
