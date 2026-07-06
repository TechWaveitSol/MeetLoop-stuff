import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class GamesLobbyScreen extends StatefulWidget {
  const GamesLobbyScreen({Key? key}) : super(key: key);

  @override
  State<GamesLobbyScreen> createState() => _GamesLobbyScreenState();
}

class _GamesLobbyScreenState extends State<GamesLobbyScreen> {
  List<String?> _board = List.generate(9, (_) => null);
  bool _isPlayerTurn = true;
  String? _winnerMessage;

  void _resetGame() {
    setState(() {
      _board = List.generate(9, (_) => null);
      _isPlayerTurn = true;
      _winnerMessage = null;
    });
  }

  String? _checkWinner(List<String?> s) {
    const lines = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ];
    for (var line in lines) {
      if (s[line[0]] != null && s[line[0]] == s[line[1]] && s[line[0]] == s[line[2]]) {
        return s[line[0]];
      }
    }
    if (s.every((element) => element != null)) {
      return 'Draw';
    }
    return null;
  }

  void _makeMove(int index) {
    if (_board[index] != null || _winnerMessage != null || !_isPlayerTurn) return;

    setState(() {
      _board[index] = '❌';
      final win = _checkWinner(_board);
      if (win != null) {
        _winnerMessage = win == 'Draw' ? "It's a tie! 🤝" : "Winner is: ❌ ✨";
        return;
      }
      _isPlayerTurn = false;
    });

    // Simulate opponent response
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      final emptyIndices = <int>[];
      for (var i = 0; i < 9; i++) {
        if (_board[i] == null) emptyIndices.add(i);
      }
      if (emptyIndices.isNotEmpty) {
        final rIndex = (emptyIndices..shuffle()).first;
        setState(() {
          _board[rIndex] = '⭕️';
          final win = _checkWinner(_board);
          if (win != null) {
            _winnerMessage = win == 'Draw' ? "It's a tie! 🤝" : "Winner is: ⭕️ 😭";
          } else {
            _isPlayerTurn = true;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      appBar: AppBar(
        title: Text('Games Arenas', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Games Banner Stats
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          '🏆 Global Ranking Score',
                          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Chess Master Tier',
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text('1,480 Arena Score', style: GoogleFonts.poppins(color: Colors.white.withValues(alpha: 0.8), fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Text('82%', style: GoogleFonts.poppins(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.05),

            const SizedBox(height: 32),

            // Live Playable Game
            Container(
              padding: const EdgeInsets.all(24),
              decoration: AppTheme.solidCard(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Casual Arena: Tic Tac Toe', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14, color: AppTheme.textPrimary)),
                      GestureDetector(
                        onTap: _resetGame, 
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: AppTheme.bgLight, borderRadius: BorderRadius.circular(12)),
                          child: Text('Reset', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _makeMove(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.bgLight,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black.withValues(alpha: 0.03)),
                          ),
                          child: Center(
                            child: Text(
                              _board[index] ?? '',
                              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: AppTheme.roseGlassDecoration(),
                      child: Text(
                        _winnerMessage ?? (_isPlayerTurn ? "Your turn (❌)" : "Opponent planning... (⭕️)"),
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05),
          ],
        ),
      ),
    );
  }
}

class TravelPlannerScreen extends StatefulWidget {
  const TravelPlannerScreen({Key? key}) : super(key: key);

  @override
  State<TravelPlannerScreen> createState() => _TravelPlannerScreenState();
}

class _TravelPlannerScreenState extends State<TravelPlannerScreen> {
  final List<Map<String, dynamic>> _itinerary = [
    {'day': 1, 'title': 'Meet up & Cafe brief ☕️'},
    {'day': 2, 'title': 'Trekking sunset peak 🌅'},
    {'day': 3, 'title': 'Cozy bonfire stories 🔥'},
  ];

  final TextEditingController _itineraryController = TextEditingController();

  void _addItem() {
    if (_itineraryController.text.trim().isEmpty) return;
    setState(() {
      _itinerary.add({
        'day': _itinerary.length + 1,
        'title': _itineraryController.text,
      });
      _itineraryController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      appBar: AppBar(
        title: Text('Travel Companions', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                boxShadow: AppTheme.softShadow,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Stack(
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&q=80&w=600',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 180, 
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      )
                    ),
                    Positioned(
                      bottom: 24,
                      left: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('July 15 - 20, 2026', style: GoogleFonts.poppins(color: Colors.white.withValues(alpha: 0.9), fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                          const SizedBox(height: 4),
                          Text('Gokarna Roadtrip', style: GoogleFonts.poppins(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ).animate().fadeIn().slideY(begin: 0.05),

            const SizedBox(height: 32),

            // Itinerary
            Text(
              'SHARED TRIP ITINERARY',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: AppTheme.textMuted,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: AppTheme.solidCard(),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _itinerary.length,
                    itemBuilder: (context, idx) {
                      final item = _itinerary[idx];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${item['day']}',
                                  style: GoogleFonts.poppins(color: AppTheme.primary, fontSize: 12, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(child: Text(item['title'], style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary))),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _itineraryController,
                          style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.textPrimary),
                          decoration: InputDecoration(
                            hintText: 'Add new daily stop...',
                            hintStyle: GoogleFonts.poppins(color: AppTheme.textMuted),
                            filled: true,
                            fillColor: AppTheme.bgLight,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: _addItem,
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ]
                          ),
                          child: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05),
          ],
        ),
      ),
    );
  }
}
