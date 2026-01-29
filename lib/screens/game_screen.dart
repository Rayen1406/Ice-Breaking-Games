import 'dart:async';
import 'package:flutter/material.dart';
import '../services/game_service.dart';
import '../widgets/method_card.dart';
import 'summary_screen.dart';

class GameScreen extends StatefulWidget {
  final double durationInMinutes;
  
  const GameScreen({
    super.key,
    this.durationInMinutes = 3.0, // Default 3 minutes
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameService _gameService = GameService();
  Timer? _timer;
  int _secondsRemaining = 180; // Will be set in initState

  @override
  void initState() {
    super.initState();
    _secondsRemaining = (widget.durationInMinutes * 60).toInt(); // Convert minutes to seconds
    _gameService.startNewGame();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
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

  Future<bool> _showExitConfirmation() async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;
        final isSmallScreen = size.width < 360;
        
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange.shade700,
                size: isSmallScreen ? 24 : 28,
              ),
              SizedBox(width: isSmallScreen ? 8 : 12),
              Expanded(
                child: Text(
                  'Exit Game?',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to exit? Your current progress will be lost.',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Exit',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final isMediumScreen = size.width >= 360 && size.width < 400;
    
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;
        
        final shouldPop = await _showExitConfirmation();
        if (shouldPop && context.mounted) {
          _timer?.cancel();
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black54),
            onPressed: () async {
              final shouldExit = await _showExitConfirmation();
              if (shouldExit && context.mounted) {
                _timer?.cancel();
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Score and Timer display
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 12 : 16,
                  vertical: isSmallScreen ? 8 : 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Score
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12 : 16,
                          vertical: isSmallScreen ? 6 : 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Score: ${_gameService.totalScore}',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(width: isSmallScreen ? 8 : 12),
                    
                    // Timer
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12 : 16,
                          vertical: isSmallScreen ? 6 : 8,
                        ),
                        decoration: BoxDecoration(
                          color: _secondsRemaining <= 30 
                              ? Colors.red.shade700 
                              : Colors.green.shade700,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: isSmallScreen ? 16 : 20,
                            ),
                            SizedBox(width: isSmallScreen ? 4 : 8),
                            Text(
                              _formatTime(_secondsRemaining),
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFeatures: const [FontFeature.tabularFigures()],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(width: isSmallScreen ? 8 : 12),
                    
                    // End Game button
                    TextButton(
                      onPressed: _endGame,
                      child: Text(
                        'End',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Word display card
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 12 : 16,
                  vertical: isSmallScreen ? 6 : 8,
                ),
                padding: EdgeInsets.all(isSmallScreen ? 20 : 32),
                decoration: BoxDecoration(
                  color: const Color(0xFF1565C0), // Blue from mockup
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    _gameService.currentWord?.displayText ?? '',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 20 : (isMediumScreen ? 24 : 28),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(height: isSmallScreen ? 8 : 16),

              // Method cards
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 8 : 0,
                  ),
                  child: Column(
                    children: [
                      MethodCard(
                        icon: Icons.edit,
                        labelEnglish: 'draw',
                        labelFrench: 'dessiner',
                        labelArabic: 'رسم',
                        score: 10,
                        onTap: () => _handleMethodSelection(GameMethod.draw),
                      ),
                      MethodCard(
                        icon: Icons.theater_comedy,
                        labelEnglish: 'mime',
                        labelFrench: 'mime',
                        labelArabic: 'ميم',
                        score: 15,
                        onTap: () => _handleMethodSelection(GameMethod.mime),
                      ),
                      MethodCard(
                        icon: Icons.palette,
                        labelEnglish: 'play dough',
                        labelFrench: 'pate à modeler',
                        labelArabic: 'صلصال',
                        score: 20,
                        onTap: () => _handleMethodSelection(GameMethod.playDough),
                      ),
                      MethodCard(
                        icon: Icons.chat_bubble_outline,
                        labelEnglish: 'one word',
                        labelFrench: 'un mot',
                        labelArabic: 'كلمة واحدة',
                        score: 5,
                        onTap: () => _handleMethodSelection(GameMethod.oneWord),
                      ),
                      SizedBox(height: isSmallScreen ? 12 : 20),
                    ],
                  ),
                ),
              ),

              // Pass button
              Padding(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handlePass,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade400,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 12 : 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      'PASS',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
