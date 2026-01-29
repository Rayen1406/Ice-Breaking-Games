import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'game_screen.dart';

class LoadingScreen extends StatefulWidget {
  final double durationInMinutes;
  
  const LoadingScreen({
    super.key,
    required this.durationInMinutes,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  int _countdown = 3;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Setup scale animation for countdown numbers
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    
    _startCountdown();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _scaleController.forward();
    
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
        _scaleController.reset();
        _scaleController.forward();
      } else {
        timer.cancel();
        // Show "GO!" for a brief moment before navigating
        setState(() {
          _countdown = 0;
        });
        _scaleController.reset();
        _scaleController.forward();
        
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => GameScreen(
                  durationInMinutes: widget.durationInMinutes,
                ),
              ),
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade700,
              Colors.blue.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lottie Animation
                SizedBox(
                  width: isSmallScreen ? size.width * 0.6 : size.width * 0.7,
                  height: isSmallScreen ? size.height * 0.3 : size.height * 0.4,
                  child: Lottie.asset(
                    'assets/animations/walking_pencil.json',
                    fit: BoxFit.contain,
                  ),
                ),
                
                SizedBox(height: isSmallScreen ? 40 : 60),
                
                // Countdown Display
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: isSmallScreen ? 120 : 150,
                    height: isSmallScreen ? 120 : 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: _countdown > 0
                          ? Text(
                              '$_countdown',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 60 : 80,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              'GO!',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 40 : 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 4,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                
                SizedBox(height: isSmallScreen ? 30 : 40),
                
                // "Get Ready" text
                Text(
                  'Get Ready!',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 24 : 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
