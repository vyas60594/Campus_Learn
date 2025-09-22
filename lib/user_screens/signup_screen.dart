import 'package:flutter/material.dart';
import 'package:campus_learn/user_screens/complete_profile_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameFocus.addListener(() => setState(() {}));
    _emailFocus.addListener(() => setState(() {}));
    _passwordFocus.addListener(() => setState(() {}));
    _confirmPasswordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // Navigate immediately without artificial delay
      if (!mounted) return;
      setState(() => _isLoading = false);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const CompleteProfileScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBrandHeader(),
              const SizedBox(height: 24),
              _buildAuthCard(),
              const SizedBox(height: 16),
              _buildLoginPrompt(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.school, color: Colors.white),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'CampusLearn',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Create your account to get started',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuthCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildForm(),
          const SizedBox(height: 16),
          _buildSignUpButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Register',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
            children: [
              TextSpan(text: 'Create an '),
              TextSpan(text: 'account', style: TextStyle(color: Colors.blue)),
              TextSpan(text: ' to access all the features of '),
              TextSpan(text: 'CampusLearn', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildNameField(),
          const SizedBox(height: 18),
          _buildEmailField(),
          const SizedBox(height: 18),
          _buildPasswordField(),
          const SizedBox(height: 18),
          _buildConfirmPasswordField(),
        ],
      ),
    );
  }

  InputDecoration _pillDecoration({required String hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.black, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.black, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      suffixIcon: suffix,
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Full Name',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _nameController,
          focusNode: _nameFocus,
          textInputAction: TextInputAction.next,
          decoration: _pillDecoration(
            hint: _nameFocus.hasFocus ? '' : 'Ex.  Rajan Vyas',
            suffix: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.person_outline, color: Colors.black),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          focusNode: _emailFocus,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: _pillDecoration(
            hint: _emailFocus.hasFocus ? '' : 'Ex: abc@example.com',
            suffix: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.alternate_email, color: Colors.black),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter your email';
            final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          focusNode: _passwordFocus,
          obscureText: !_isPasswordVisible,
          textInputAction: TextInputAction.next,
          decoration: _pillDecoration(
            hint: _passwordFocus.hasFocus ? '' : '••••••••',
            suffix: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.black,
              ),
              onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter your password';
            if (value.length < 6) return 'Password must be at least 6 characters';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Confirm Password',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _confirmPasswordController,
          focusNode: _confirmPasswordFocus,
          obscureText: !_isConfirmPasswordVisible,
          textInputAction: TextInputAction.done,
          decoration: _pillDecoration(
            hint: _confirmPasswordFocus.hasFocus ? '' : '••••••••',
            suffix: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.black,
              ),
              onPressed: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please confirm your password';
            if (value != _passwordController.text) return 'Passwords do not match';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : const Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account? ', style: TextStyle(color: Colors.black87)),
        TextButton(
          onPressed: () => Navigator.of(context).maybePop(),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text('Login', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
