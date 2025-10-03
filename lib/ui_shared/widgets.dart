import 'package:flutter/material.dart';
import 'app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final double height;
  const PrimaryButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.loading = false,
      this.height = 52});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.emphasis,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: 0,
        ),
        onPressed: loading ? null : onPressed,
        child: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white))
            : Text(label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? helper;
  final String? Function(String?)? validator;
  const EmailField(
      {super.key,
      required this.controller,
      this.label = 'Email address',
      this.helper,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      decoration: InputDecoration(
        labelText: label,
        hintText: 'you@example.com',
        helperText: helper,
        prefixIcon: const Icon(Icons.email_outlined),
        border: AppTheme.inputBorder(Colors.grey.shade300),
        enabledBorder: AppTheme.inputBorder(Colors.grey.shade300),
        focusedBorder: AppTheme.inputBorder(AppTheme.primary),
      ),
      validator: validator,
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;
  final String label;
  final String? Function(String?)? validator;
  const PasswordField(
      {super.key,
      required this.controller,
      required this.obscure,
      required this.onToggle,
      this.label = 'Password',
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        hintText: '•••••••',
        suffixIcon: IconButton(
          icon: Icon(obscure
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined),
          onPressed: onToggle,
        ),
        border: AppTheme.inputBorder(Colors.grey.shade300),
        enabledBorder: AppTheme.inputBorder(Colors.grey.shade300),
        focusedBorder: AppTheme.inputBorder(AppTheme.primary),
      ),
      validator: validator,
    );
  }
}

