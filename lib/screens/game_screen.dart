import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../services/game_service.dart';
import '../widgets/method_card.dart';
import 'summary_screen.dart';

class GameScreen extends StatefulWidget {
  final double durationInMinutes;
  
  const GameScreen({
    super.key,
    this.durationInMinutes = 3.0,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameService _gameService = GameService();
  late ConfettiController _confettiController;
  Timer? _timer;
  int _secondsRemaining = 180;
  final Color _backgroundColor = const Color(0xFFFCF0CC); // Beige background

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    _secondsRemaining = (widget.durationInMinutes * 60).toInt();
    _gameService.startNewGame();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _confettiController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
          _endGame();
        }
      });
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _handleMethodSelection(GameMethod method) {
    setState(() {
      _gameService.selectMethod(method);
    });
    _confettiController.play();
  }

  void _handlePass() {
    setState(() {
      _gameService.passWord();
    });
  }

  void _endGame() {
    _timer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          totalScore: _gameService.totalScore,
          wordsCompleted: _gameService.wordsCompleted,
          wordsPassed: _gameService.wordsPassed,
        ),
      ),
    );
  }

  Future<bool> _showConfirmationDialog({
    required String title,
    required String message,
    required String confirmText,
    required Color confirmColor,
  }) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange.shade800,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: confirmColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadowColor: confirmColor.withOpacity(0.4),
                        ),
                        child: Text(
                          confirmText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;
        final shouldPop = await _showConfirmationDialog(
          title: 'Exit Game?',
          message: 'Are you sure you want to leave?\nYour current progress and score\nwill be lost.',
          confirmText: 'Exit',
          confirmColor: const Color(0xFFEF5350),
        );
        if (shouldPop && context.mounted) {
          _timer?.cancel();
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: Stack(
          children: [
            // Background Pattern (Simple dots)
            CustomPaint(
              size: Size.infinite,
              painter: DotPatternPainter(
                color: Colors.orange.withOpacity(0.1),
                spacing: 20,
              ),
            ),
            


            SafeArea(
              child: Column(
                children: [
                  // App Bar / Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_rounded, color: Colors.black87),
                            onPressed: () async {
                              final shouldExit = await _showConfirmationDialog(
                                title: 'Exit Game?',
                                message: 'Are you sure you want to leave?\nYour current progress and score\nwill be lost.',
                                confirmText: 'Exit',
                                confirmColor: const Color(0xFFEF5350),
                              );
                              if (shouldExit && context.mounted) {
                                _timer?.cancel();
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                        
                        // End Button
                        TextButton(
                          onPressed: () async {
                              final shouldEnd = await _showConfirmationDialog(
                                title: 'End Game?',
                                message: 'Are you sure you want to end?\nYou will be taken to the\nsummary screen.',
                                confirmText: 'End',
                                confirmColor: Colors.blue.shade600,
                              );
                              if (shouldEnd && context.mounted) {
                                _endGame();
                              }
                          },
                          child: Text(
                            'End',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Score and Timer Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Score Pill
                        _buildStatusPill(
                          label: 'Score: ${_gameService.totalScore}',
                          color: Colors.blue.shade600,
                          icon: null,
                        ),
                        // Timer Pill
                        _buildStatusPill(
                          label: _formatTime(_secondsRemaining),
                          color: _secondsRemaining <= 30 
                              ? Colors.red.shade500 
                              : const Color(0xFF00C853), // Green
                          icon: Icons.timer,
                        ),
                      ],
                    ),
                  ),

                  // Word Display
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade400,
                          Colors.blue.shade700,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade300.withOpacity(0.5),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [

                        Center(
                          child: Text(
                            _gameService.currentWord?.displayText ?? '',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Grid Layout for Methods
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85, // Adjust for taller cards
                        children: [
                          MethodCard(
                            icon: Icons.edit,
                            labelEnglish: 'Draw',
                            labelFrench: 'dessiner',
                            labelArabic: 'رسم',
                            score: _gameService.getScoreForMethod(GameMethod.draw),
                            color: const Color(0xFFFF8A65), // Orange
                            onTap: () => _handleMethodSelection(GameMethod.draw),
                          ),
                          MethodCard(
                            icon: Icons.theater_comedy,
                            labelEnglish: 'Mime',
                            labelFrench: 'mime',
                            labelArabic: 'ميم',
                            score: _gameService.getScoreForMethod(GameMethod.mime),
                            color: const Color(0xFF9575CD), // Purple
                            onTap: () => _handleMethodSelection(GameMethod.mime),
                          ),
                          MethodCard(
                            icon: Icons.palette,
                            labelEnglish: 'Play Dough',
                            labelFrench: 'pate à modeler',
                            labelArabic: 'صلصال',
                            score: _gameService.getScoreForMethod(GameMethod.playDough),
                            color: const Color(0xFF66BB6A), // Green
                            onTap: () => _handleMethodSelection(GameMethod.playDough),
                          ),
                          MethodCard(
                            icon: Icons.chat_bubble_outline,
                            labelEnglish: 'One Word',
                            labelFrench: 'un mot',
                            labelArabic: 'كلمة واحدة',
                            score: _gameService.getScoreForMethod(GameMethod.oneWord),
                            color: const Color(0xFF26C6DA), // Cyan
                            onTap: () => _handleMethodSelection(GameMethod.oneWord),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Pass Button (Bottom)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: ElevatedButton(
                      onPressed: _handlePass,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9800),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        'PASS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Confetti Overlay (Center)
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
                createParticlePath: drawStar, 
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusPill({
    required String label,
    required Color color,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }

  // Path for star-shaped confetti
  Path drawStar(Size size) {
    // Method to create a star path
    double degToRad(double deg) => deg * (3.1415926535897932 / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = 360 / numberOfPoints;
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = 360;
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * Colors.white.opacity, halfWidth + externalRadius * Colors.white.opacity); // Placeholder math, fixing below
    }
    
    // Correct simplified star path
    path.reset();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width * 0.6, size.height * 0.4);
    path.lineTo(size.width, size.height * 0.4);
    path.lineTo(size.width * 0.7, size.height * 0.6);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width * 0.5, size.height * 0.75);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(size.width * 0.3, size.height * 0.6);
    path.lineTo(0, size.height * 0.4);
    path.lineTo(size.width * 0.4, size.height * 0.4);
    path.close();
    return path;
    
  }
}

// Simple painter for background dots
class DotPatternPainter extends CustomPainter {
  final Color color;
  final double spacing;

  DotPatternPainter({required this.color, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        if ((x ~/ spacing) % 2 == (y ~/ spacing) % 2) {
           canvas.drawCircle(Offset(x, y), 1.5, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
