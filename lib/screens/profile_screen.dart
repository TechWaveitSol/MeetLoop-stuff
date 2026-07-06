import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _searchRadius = 15.0;
  final List<String> _interests = ['Travel', 'Music', 'Photography', 'Gaming', 'Cycling', 'Movies'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      appBar: AppBar(
        title: Text('My Identity', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: AppTheme.textPrimary),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overlapping Card with Cover and Avatar
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: AppTheme.softShadow,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&q=80&w=600',
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  left: 24,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppTheme.bgWarm,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 42,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
                      ),
                    ),
                  ),
                ).animate().scale(delay: 200.ms, duration: 400.ms, curve: Curves.easeOutBack)
              ],
            ).animate().fadeIn().slideY(begin: -0.05),

            const SizedBox(height: 56),

            // User Info
            Row(
              children: [
                Text(
                  'Arjun Reddy',
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.verified_rounded, color: Colors.lightBlue, size: 20),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Verified Architect',
              style: GoogleFonts.poppins(color: AppTheme.primary, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Explorer | Music Lover | Coffee Addict ☕️\nAlways up for new adventures and meaningful conversations!',
              style: GoogleFonts.poppins(color: AppTheme.textSecondary, fontSize: 13, height: 1.5),
            ),

            const SizedBox(height: 32),

            // Search Radius Slider Preferences
            Text(
              'SEARCH RADIUS PREFERENCE',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: AppTheme.textMuted,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: AppTheme.solidCard(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Scan Radius', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(color: AppTheme.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                        child: Text('${_searchRadius.round()} km', style: GoogleFonts.poppins(color: AppTheme.primary, fontWeight: FontWeight.w700, fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: _searchRadius,
                    min: 2,
                    max: 50,
                    activeColor: AppTheme.primary,
                    inactiveColor: AppTheme.bgLight,
                    onChanged: (val) {
                      setState(() {
                        _searchRadius = val;
                      });
                    },
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.05),

            const SizedBox(height: 32),

            // Interests tags list
            Text(
              'MY INTERESTS & HOBBIES',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: AppTheme.textMuted,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _interests.map((hobby) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.bgLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black.withValues(alpha: 0.03)),
                  ),
                  child: Text(hobby, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
                );
              }).toList(),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
