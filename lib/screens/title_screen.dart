import 'package:flutter/material.dart';
import 'loading_screen.dart';
import 'credentials_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}



class _TitleScreenState extends State<TitleScreen> {
  double _selectedMinutes = 3; // Default 3 minutes (changed to double for 0.5)
  int _logoTapCount = 0;
  bool _isEasterEggFound = false;

  @override
  void initState() {
    super.initState();
    _checkEasterEggStatus();
  }

  Future<void> _checkEasterEggStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isEasterEggFound = prefs.getBool('is_easter_egg_found') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final isMediumScreen = size.width >= 360 && size.width < 400;
    
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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : 24,
                vertical: isSmallScreen ? 20 : 32,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _logoTapCount++;
                        if (_logoTapCount >= 5) {
                          _logoTapCount = 0;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CredentialsScreen(),
                            ),
                          ).then((_) => _checkEasterEggStatus());
                        }
                      });
                    },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24), // Matches app icon rounding
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: isSmallScreen ? 100 : (isMediumScreen ? 120 : 140),
                                height: isSmallScreen ? 100 : (isMediumScreen ? 120 : 140),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (_isEasterEggFound)
                            Positioned(
                              top: -15,
                              right: -10,
                              child: Transform.rotate(
                                angle: 0.5, // Approx 30 degrees tilt
                                child: const Text(
                                  '👑',
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                  
                  SizedBox(height: isSmallScreen ? 20 : 30),
                  
                  // Title
                  Text(
                    'The Card Game',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 32 : (isMediumScreen ? 40 : 48),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: isSmallScreen ? 40 : 60),
                  
                  // Timer configuration
                  Container(
                    padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
                    margin: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 8 : 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: isSmallScreen ? 20 : 24,
                            ),
                            SizedBox(width: isSmallScreen ? 8 : 12),
                            Text(
                              'Game Duration',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 16 : 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isSmallScreen ? 16 : 20),
                        
                        // Timer options with responsive layout
                        Wrap(
                          spacing: isSmallScreen ? 8 : 12,
                          runSpacing: isSmallScreen ? 8 : 12,
                          alignment: WrapAlignment.center,
                          children: <double>[0.5, 1, 3, 5, 10, 15].map((minutes) {
                            final isSelected = _selectedMinutes == minutes;
                            final label = minutes < 1 
                                ? '${(minutes * 60).toInt()} sec' 
                                : '${minutes.toInt()} min';
                            
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedMinutes = minutes;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 16 : 20,
                                  vertical: isSmallScreen ? 8 : 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? Colors.white 
                                      : Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected 
                                        ? Colors.blue.shade700 
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: isSmallScreen ? 30 : 40),
                  
                  // Start button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoadingScreen(
                            durationInMinutes: _selectedMinutes,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade700,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 40 : 60,
                        vertical: isSmallScreen ? 16 : 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                    ),
                    child: Text(
                      'START',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 20 : 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
