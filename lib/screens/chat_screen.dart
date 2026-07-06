import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _mockChats = const [
    {
      'id': 'c1',
      'name': 'Ananya',
      'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100',
      'lastMsg': 'Hey Arjun! Wanna play Chess tonight?',
      'time': 'Just now',
      'unread': true,
    },
    {
      'id': 'c2',
      'name': 'Rohan',
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=100',
      'lastMsg': 'Tic Tac Toe rematch whenever you are free!',
      'time': '12m ago',
      'unread': false,
    },
    {
      'id': 'c3',
      'name': 'Pooja',
      'avatar': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&q=80&w=100',
      'lastMsg': 'Our sunset hiking route is finalized! 🧭⛰️',
      'time': '1h ago',
      'unread': true,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      appBar: AppBar(
        title: Text('Inbox Orbit', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: _mockChats.length,
        itemBuilder: (context, index) {
          final chat = _mockChats[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InteractiveChatScreen(chatId: chat['id']),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: AppTheme.solidCard(),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(chat['avatar']),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                chat['name'],
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700, 
                                  fontSize: 15,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                chat['time'],
                                style: GoogleFonts.poppins(
                                  color: AppTheme.textMuted, 
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            chat['lastMsg'],
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: chat['unread'] ? AppTheme.primary : AppTheme.textSecondary,
                              fontWeight: chat['unread'] ? FontWeight.w600 : FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (chat['unread'])
                      Container(
                        margin: const EdgeInsets.only(left: 12),
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                        ),
                      )
                  ],
                ),
              ),
            ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1),
          );
        },
      ),
    );
  }
}

class InteractiveChatScreen extends StatefulWidget {
  final String chatId;
  const InteractiveChatScreen({Key? key, required this.chatId}) : super(key: key);

  @override
  State<InteractiveChatScreen> createState() => _InteractiveChatScreenState();
}

class _InteractiveChatScreenState extends State<InteractiveChatScreen> {
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hey Arjun! Let\'s synchronize our locations today', 'isMe': false},
    {'text': 'Sounds like a master plan! Sunset hiking or chess arena first?', 'isMe': true},
    {'text': 'Let\'s definitely do the chess challenge first. Prepare to lose! ♟️👑', 'isMe': false},
  ];

  final TextEditingController _msgController = TextEditingController();

  void _sendMessage() {
    if (_msgController.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'text': _msgController.text,
        'isMe': true,
      });
      _msgController.clear();
    });

    // Simulate response delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'text': 'Haha challenge accepted! Let\'s lock in the schedule now. 🧭',
            'isMe': false,
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      appBar: AppBar(
        backgroundColor: AppTheme.cardWhite,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ananya', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                Text('Active 3m ago', style: GoogleFonts.poppins(fontSize: 11, color: AppTheme.success, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      gradient: msg['isMe'] ? AppTheme.primaryGradient : null,
                      color: msg['isMe'] ? null : AppTheme.cardWhite,
                      boxShadow: msg['isMe'] ? AppTheme.softShadow : AppTheme.cardShadow,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(24),
                        topRight: const Radius.circular(24),
                        bottomLeft: msg['isMe'] ? const Radius.circular(24) : const Radius.circular(6),
                        bottomRight: msg['isMe'] ? const Radius.circular(6) : const Radius.circular(24),
                      ),
                    ),
                    child: Text(
                      msg['text'],
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: msg['isMe'] ? Colors.white : AppTheme.textPrimary,
                      ),
                    ),
                  ).animate().scale(
                    alignment: msg['isMe'] ? Alignment.centerRight : Alignment.centerLeft, 
                    duration: 300.ms,
                    curve: Curves.easeOutBack,
                  ),
                );
              },
            ),
          ),

          // Smart Quick replies bar
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildSmartReply('I\'m on my way! 🚗'),
                  _buildSmartReply('Let\'s play! ♟️'),
                  _buildSmartReply('Send coordinates 📍'),
                ],
              ),
            ),
          ),

          // Message bar input
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.cardWhite,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: AppTheme.cardShadow,
                      ),
                      child: TextField(
                        controller: _msgController,
                        style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Type messages...',
                          hintStyle: GoogleFonts.poppins(color: AppTheme.textMuted),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        shape: BoxShape.circle,
                        boxShadow: AppTheme.softShadow,
                      ),
                      child: const Icon(Icons.send_rounded, size: 20, color: Colors.white),
                    ),
                  ).animate().scale(duration: 200.ms)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartReply(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _messages.add({'text': text, 'isMe': true});
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.bgLight, width: 1),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12, 
            fontWeight: FontWeight.w500,
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }
}
