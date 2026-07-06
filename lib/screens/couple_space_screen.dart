import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class CoupleSpaceScreen extends StatefulWidget {
  const CoupleSpaceScreen({Key? key}) : super(key: key);

  @override
  State<CoupleSpaceScreen> createState() => _CoupleSpaceScreenState();
}

class _CoupleSpaceScreenState extends State<CoupleSpaceScreen> {
  final List<Map<String, dynamic>> _checklistItems = [
    {'title': 'Sunset Coffee Date 🌅', 'completed': true},
    {'title': 'Play Chess Arena ♟️', 'completed': true},
    {'title': 'Plan Weekend Hiking Roadtrip 🧭', 'completed': false},
    {'title': 'Log first joint memory photo 📸', 'completed': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      appBar: AppBar(
        title: Text('Our Private Loop', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_rounded, color: AppTheme.primary),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Streak counter card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppTheme.lavenderGradient,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.secondary.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
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
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'COUPLE STREAK',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '12 Days Active',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'With Pooja Reddy',
                        style: GoogleFonts.poppins(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Text('🔥', style: TextStyle(fontSize: 52)),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1),

            const SizedBox(height: 32),

            // Daily Milestones / Bucket List
            Text(
              'SHARED BUCKET LIST',
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
                children: _checklistItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              item['completed'] = !item['completed'];
                            });
                          },
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: item['completed'] ? AppTheme.primary : AppTheme.textMuted.withValues(alpha: 0.3),
                                width: 2,
                              ),
                              color: item['completed'] ? AppTheme.primary : Colors.transparent,
                            ),
                            child: item['completed']
                                ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item['title'],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: item['completed'] ? FontWeight.w500 : FontWeight.w600,
                              decoration: item['completed'] 
                                  ? TextDecoration.lineThrough 
                                  : TextDecoration.none,
                              color: item['completed'] ? AppTheme.textMuted : AppTheme.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05),

            const SizedBox(height: 32),

            // Memory gallery Section
            Text(
              'SHARED TIMELINE',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: AppTheme.textMuted,
              ),
            ),
            const SizedBox(height: 16),

            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildMemoryCard(
                  'Sunset Coffee Shop',
                  'June 28, 2026',
                  'Logged our first date photo in the cozy local design library.',
                  'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&q=80&w=400',
                ),
                const SizedBox(height: 20),
                _buildMemoryCard(
                  'Chess Tournament victory',
                  'June 24, 2026',
                  'Arjun defeated Rohan in the custom Tic Tac Toe arena.',
                  'https://images.unsplash.com/photo-1529699211952-734e80c4d42b?auto=format&fit=crop&q=80&w=400',
                ),
              ],
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.05),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryCard(
    String title,
    String date,
    String desc,
    String imageUrl,
  ) {
    return Container(
      decoration: AppTheme.solidCard(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14, color: AppTheme.textPrimary),
                    ),
                    Text(
                      date,
                      style: GoogleFonts.poppins(color: AppTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  desc,
                  style: GoogleFonts.poppins(color: AppTheme.textSecondary, fontSize: 13, height: 1.4, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
