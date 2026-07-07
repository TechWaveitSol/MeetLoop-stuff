import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class SwipeConnectionScreen extends StatefulWidget {
  const SwipeConnectionScreen({Key? key}) : super(key: key);

  @override
  State<SwipeConnectionScreen> createState() => _SwipeConnectionScreenState();
}

class _SwipeConnectionScreenState extends State<SwipeConnectionScreen> {
  int _currentIndex = 0;
  bool _showMatchOverlay = false;

  final List<Map<String, dynamic>> _mockProfiles = [
    {
      'name': 'Ananya',
      'age': 22,
      'distance': '2.4 km away',
      'bio': 'Love exploring new places and meeting new people! Let\'s grab a cup of matcha latte 🍵 or go for a sunset hike 🌅.',
      'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=600',
      'matchScore': 94,
    },
    {
      'name': 'Siddu',
      'age': 24,
      'distance': '1.8 km away',
      'bio': 'Always down for game nights or cafe hopping! Play chess or Connect Four? ♟️ Let\'s connect and create memories.',
      'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=600',
      'matchScore': 88,
    },
    {
      'name': 'Pooja',
      'age': 23,
      'distance': '0.9 km away',
      'bio': 'UI/UX Designer & explorer. Let\'s sketch some digital layouts over premium hot chocolate! ☕️🎨',
      'image': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&q=80&w=600',
      'matchScore': 97,
    }
  ];

  void _handleAction(bool accepted) {
    if (accepted) {
      // Show match modal randomly or if match score > 90
      if (_mockProfiles[_currentIndex]['matchScore'] > 90) {
        setState(() {
          _showMatchOverlay = true;
        });
        return;
      }
    }
    
    _nextCard();
  }

  void _nextCard() {
    setState(() {
      _showMatchOverlay = false;
      _currentIndex = (_currentIndex + 1) % _mockProfiles.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = _mockProfiles[_currentIndex];

    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      appBar: AppBar(
        title: Text('Connect Nearby', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Base Swipe Card Column
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      // Photo container with overlay text info
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: AppTheme.softShadow,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                profile['image'],
                                fit: BoxFit.cover,
                              ),
                              // Soft dark bottom protection gradient for text
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                              // Match percentage pill
                              Positioned(
                                top: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: AppTheme.glassDecoration(radius: BorderRadius.circular(20), tint: Colors.white),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.auto_awesome_rounded, size: 14, color: AppTheme.primary),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${profile['matchScore']}% MATCH',
                                        style: GoogleFonts.poppins(
                                          color: AppTheme.primary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Profile Text Info
                              Positioned(
                                bottom: 24,
                                left: 20,
                                right: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${profile['name']}, ${profile['age']}',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 26,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(Icons.verified_rounded, color: Colors.white, size: 22),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      profile['distance'],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white.withValues(alpha: 0.9),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      profile['bio'],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white.withValues(alpha: 0.8),
                                        fontSize: 13,
                                        height: 1.4,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate(key: ValueKey(_currentIndex))
                        .fadeIn(duration: 400.ms)
                        .scale(begin: const Offset(0.95, 0.95)),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),

                // Controls Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRoundButton(
                      Icons.close_rounded, 
                      AppTheme.primary, 
                      onTap: () => _handleAction(false),
                    ),
                    _buildRoundButton(
                      Icons.star_rounded, 
                      AppTheme.secondary, 
                      size: 68,
                      iconSize: 34,
                      onTap: () => _handleAction(true),
                    ),
                    _buildRoundButton(
                      Icons.favorite_rounded, 
                      AppTheme.accent, 
                      onTap: () => _handleAction(true),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Match Success Overlay Popup
          if (_showMatchOverlay)
            Container(
              color: AppTheme.bgWarm.withValues(alpha: 0.85),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(32),
                  decoration: AppTheme.solidCard(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.favorite_rounded, size: 80, color: AppTheme.primary)
                        .animate()
                        .scale(duration: 600.ms, curve: Curves.elasticOut),
                      const SizedBox(height: 24),
                      Text(
                        "It's a Match! ✨",
                        style: GoogleFonts.poppins(
                          color: AppTheme.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You and ${profile['name']} liked each other.',
                        style: GoogleFonts.poppins(color: AppTheme.textSecondary, fontSize: 13),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _nextCard,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 54),
                        ),
                        child: const Text('Send a Game Challenge'),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _nextCard,
                        child: Text(
                          'Keep Exploring', 
                          style: GoogleFonts.poppins(
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 300.ms),
        ],
      ),
    );
  }

  Widget _buildRoundButton(
    IconData icon, 
    Color color, {
    double size = 56.0, 
    double iconSize = 28.0,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Center(
          child: Icon(icon, color: color, size: iconSize),
        ),
      ).animate().scale(begin: const Offset(0.8, 0.8), duration: 400.ms, curve: Curves.easeOutBack),
    );
  }
}
