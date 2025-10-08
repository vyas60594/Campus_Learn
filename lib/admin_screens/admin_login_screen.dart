import 'package:flutter/material.dart';
import '../ui_shared/app_theme.dart';
import '../ui_shared/widgets.dart';
import '../ui_shared/validators.dart';
import 'admin_main_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _hasAttemptedSubmit = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    // Mark that user has attempted to submit
    setState(() {
      _hasAttemptedSubmit = true;
    });
    
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // For demo: accept any email with password "admin123"
    if (_passwordController.text == 'admin123') {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const AdminMainScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid admin credentials. Use password: admin123'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: AppTheme.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Admin logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primary,
                          AppTheme.primary.withOpacity(0.8)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.admin_panel_settings,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Admin Panel',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.primary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Sign in to manage your campus platform',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Column(
                    children: [
                      // Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Admin Email',
                          hintText: 'admin@campuslearn.com',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: _hasAttemptedSubmit && Validators.email(_emailController.text) != null ? Colors.red : null,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: _hasAttemptedSubmit && Validators.email(_emailController.text) != null
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                                )
                              : OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                          focusedBorder: _hasAttemptedSubmit && Validators.email(_emailController.text) != null
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.red, width: 2),
                                )
                              : OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: AppTheme.primary, width: 2),
                                ),
                        ),
                        validator: _hasAttemptedSubmit ? Validators.email : null,
                        onChanged: (_) => setState(() {}),
                      ),

                      const SizedBox(height: 16),

                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: _hasAttemptedSubmit && Validators.password(_passwordController.text) != null ? Colors.red : null,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: _hasAttemptedSubmit && Validators.password(_passwordController.text) != null
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                                )
                              : OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                          focusedBorder: _hasAttemptedSubmit && Validators.password(_passwordController.text) != null
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.red, width: 2),
                                )
                              : OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: AppTheme.primary, width: 2),
                                ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(
                                  () => _obscurePassword = !_obscurePassword);
                            },
                          ),
                        ),
                        validator: _hasAttemptedSubmit ? Validators.password : null,
                        onChanged: (_) => setState(() {}),
                      ),

                      const SizedBox(height: 24),

                      // Login button
                      PrimaryButton(
                        label: 'Sign In as Admin',
                        loading: false,
                        onPressed: _login,
                      ),

                      const SizedBox(height: 16),

                      const SizedBox(height: 24),

                      // Back to user app
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Back to User App'),
                      ),
                    ],
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
