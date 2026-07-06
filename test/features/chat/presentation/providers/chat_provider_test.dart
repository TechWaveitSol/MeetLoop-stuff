import 'package:flutter_test/flutter_test.dart';
import 'package:meetloop/features/chat/domain/entities/message_entity.dart';
import 'package:meetloop/features/chat/domain/repositories/chat_repository.dart';
import 'package:meetloop/features/chat/presentation/providers/chat_provider.dart';

class FakeChatRepository implements ChatRepository {
  List<MessageEntity> sentMessages = [];

  @override
  Future<void> sendMessage(MessageEntity message) async {
    sentMessages.add(message);
  }

  @override
  Future<void> addReaction(String chatId, String messageId, String userId, String emoji) async {}
  
  @override
  Future<void> deleteMessage(String chatId, String messageId) async {}

  @override
  Stream<List<Map<String, dynamic>>> getChats(String userId) {
    return Stream.value([]);
  }

  @override
  Future<void> markAsRead(String chatId, String messageId) async {}
  
  @override
  Stream<List<MessageEntity>> getMessages(String chatId) {
    return Stream.value([]);
  }
}

void main() {
  late FakeChatRepository fakeChatRepository;
  late ChatController chatController;

  setUp(() {
    fakeChatRepository = FakeChatRepository();
    chatController = ChatController(fakeChatRepository);
  });

  group('ChatController tests', () {
    test('sendMessage triggers repository call with mapped entity', () async {
      await chatController.sendMessage(
        chatId: 'chat_123',
        senderId: 'user_a',
        receiverId: 'user_b',
        text: 'Hello!',
      );

      expect(fakeChatRepository.sentMessages.length, 1);
      final msg = fakeChatRepository.sentMessages.first;
      expect(msg.chatId, 'chat_123');
      expect(msg.senderId, 'user_a');
      expect(msg.receiverId, 'user_b');
      expect(msg.text, 'Hello!');
    });
  });
}
