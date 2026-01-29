import 'package:flutter/material.dart';

class MethodCard extends StatelessWidget {
  final IconData icon;
  final String labelEnglish;
  final String labelFrench;
  final String labelArabic;
  final int score;
  final VoidCallback onTap;

  const MethodCard({
    super.key,
    required this.icon,
    required this.labelEnglish,
    required this.labelFrench,
    required this.labelArabic,
    required this.score,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 4 : 8,
          horizontal: isSmallScreen ? 12 : 16,
        ),
        padding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 12 : 16,
          horizontal: isSmallScreen ? 16 : 20,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF4DD0E1), // Cyan color from mockup
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon circle
            Container(
              width: isSmallScreen ? 48 : 60,
              height: isSmallScreen ? 48 : 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: isSmallScreen ? 24 : 32,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: isSmallScreen ? 12 : 20),
            // Labels
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleCase(labelEnglish),
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '$labelFrench - $labelArabic',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            // Score
            Text(
              score.toString(),
              style: TextStyle(
                fontSize: isSmallScreen ? 36 : 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.green.shade700,
                    offset: const Offset(2, 2),
                    blurRadius: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String titleCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
