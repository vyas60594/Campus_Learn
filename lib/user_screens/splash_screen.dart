import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Set system UI overlay style for full screen
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    // Initialize simple fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    // Start simple animation
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _fadeController.forward();

    // Navigate to login screen after animation completes
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        maintainBottomViewPadding: true,
        child: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Simple fade animation for logo
                FadeTransition(opacity: _fadeAnimation, child: _buildLogo()),

                const SizedBox(height: 30),

                // Simple fade animation for app name
                FadeTransition(opacity: _fadeAnimation, child: _buildAppName()),

                const SizedBox(height: 20),

                // Simple fade animation for subtitle
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildSubtitle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Graduation cap base
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF2C3E50),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.school, size: 60, color: Colors.white),
          ),

          // Tassel
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              width: 8,
              height: 25,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          // Tassel string
          Positioned(
            top: 25,
            right: 19,
            child: Container(
              width: 2,
              height: 15,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppName() {
    return const Text(
      'CampusLearn',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2C3E50),
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      'Connect • Learn • Share',
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF7F8C8D),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }
}
