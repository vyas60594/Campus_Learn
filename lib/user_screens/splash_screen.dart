 import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a short loading time, then navigate to LoginScreen
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Colors picked to be close to the provided design
    const Color darkCard = Color(0xFF273645); // deep blue-grey
    const Color accentYellow = Color(0xFFFFD54F); // soft yellow

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App icon card with small yellow pill at top-right
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000), // subtle shadow
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Main dark rounded square
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: darkCard,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        size: 44,
                        color: Colors.white,
                      ),
                    ),
                    // Yellow pill in the top-right corner
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 12,
                        height: 28,
                        decoration: BoxDecoration(
                          color: accentYellow,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'CampusLearn',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF273645),
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Connect • Learn • Share',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
