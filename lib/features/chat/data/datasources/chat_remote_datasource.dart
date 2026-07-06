import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDatasource {
  Stream<List<MessageModel>> getMessages(String chatId);

  Future<void> sendMessage(MessageModel message);

  Future<void> markAsRead(String chatId, String messageId);

  Future<void> addReaction(String chatId, String messageId, String userId, String emoji);

  Future<void> deleteMessage(String chatId, String messageId);

  Stream<List<Map<String, dynamic>>> getChats(String uid);
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final FirebaseFirestore _firestore;

  ChatRemoteDatasourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<MessageModel>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
    });
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    final chatDocRef = _firestore.collection('chats').doc(message.chatId);
    final messageDocRef = chatDocRef.collection('messages').doc(message.id);

    final batch = _firestore.batch();
    
    // Write message
    batch.set(messageDocRef, message.toJson());
    
    // Update last message metadata in the parent Chat doc
    batch.set(chatDocRef, {
      'lastMessageText': message.text,
      'lastMessageSenderId': message.senderId,
      'lastMessageTimestamp': message.timestamp.toIso8601String(),
      'participants': FieldValue.arrayUnion([message.senderId, message.receiverId]),
    }, SetOptions(merge: true));

    await batch.commit();
  }

  @override
  Future<void> markAsRead(String chatId, String messageId) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({'isRead': true});
  }

  @override
  Future<void> addReaction(String chatId, String messageId, String userId, String emoji) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({
      'reactions.$userId': emoji,
    });
  }

  @override
  Future<void> deleteMessage(String chatId, String messageId) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  @override
  Stream<List<Map<String, dynamic>>> getChats(String uid) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: uid)
        .orderBy('lastMessageTimestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }
}
