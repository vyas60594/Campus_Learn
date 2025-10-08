import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;
  const NewPasswordScreen({super.key, required this.email});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // Updates the user's password
  // Toggles the visibility of the password field
  void _togglePasswordVisibility() {
    setState(() {
      _obscure1 = !_obscure1;
    });
  }

  // Toggles the visibility of the confirm password field
  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscure2 = !_obscure2;
    });
  }

  // Updates the user's password
  void _update() {
    // First, validate the form
    if (!_formKey.currentState!.validate()) return;

    // For this demo, we'll just show a success message and navigate back to the login screen.
    // In a real app, you would make a network request to update the password.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password updated (demo)')),
    );

    // Navigate back to the first screen in the stack (usually the login screen)
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    const Color darkButton = Color(0xFF000000);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black87),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Set a new password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 15, color: Colors.grey.shade800, height: 1.4),
                    children: const [
                      TextSpan(text: 'Create a '),
                      TextSpan(
                          text: 'new password',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(
                          text:
                              '. Ensure it differs from previous ones for security'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Password',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscure1,
                        decoration: InputDecoration(
                          hintText: '•••••••',
                          suffixIcon: IconButton(
                            icon: Icon(_obscure1
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: _togglePasswordVisibility,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        validator: (value) {
                          // Check if the input is null or empty
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a password';
                          }
                          // Check if the password has at least 6 characters
                          if (value.length < 6) {
                            return 'Use at least 6 characters';
                          }
                          // Return null if the input is valid
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text('Confirm Password',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _confirmController,
                        obscureText: _obscure2,
                        decoration: InputDecoration(
                          hintText: '•••••••',
                          suffixIcon: IconButton(
                            icon: Icon(_obscure2
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: _toggleConfirmPasswordVisibility,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        validator: (value) {
                          // Check if the confirmed password matches the original password
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          // Return null if the input is valid
                          return null;
                        },
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkButton,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28)),
                            elevation: 0,
                          ),
                          onPressed: _update,
                          child: const Text('Update Password',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ],
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
