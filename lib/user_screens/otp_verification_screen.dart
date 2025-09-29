import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'new_password_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const int _digits = 4;
  final List<TextEditingController> _controllers =
      List.generate(_digits, (_) => TextEditingController());
  final List<FocusNode> _nodes = List.generate(_digits, (_) => FocusNode());
  bool _verifying = false;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  String get _code => _controllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.length == 1 && index < _digits - 1) {
      _nodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _nodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  Future<void> _verify() async {
    if (_code.length != _digits) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 4-digit code.')),
      );
      return;
    }
    setState(() => _verifying = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _verifying = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Code verified (demo). Proceed to reset.')),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewPasswordScreen(email: widget.email),
      ),
    );
  }

  void _resend() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Resent email to ${widget.email} (demo)')),
    );
  }

  String _maskedEmail(String email) {
    final at = email.indexOf('@');
    if (at <= 2) return email;
    final start = email.substring(0, 2);
    final end = email.substring(at);
    return '$start•••$end';
  }

  @override
  Widget build(BuildContext context) {
    const Color darkCard = Color(0xFF000000); // matches screenshot dark button
    final masked = _maskedEmail(widget.email);

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
                  'Check your email',
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
                    children: [
                      const TextSpan(text: 'We sent a reset link to '),
                      TextSpan(
                          text: masked,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black87)),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Enter the 4 digit code mentioned in the email',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 22),
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Dynamically shrink box width if screen is narrow
                    final totalSpacing = 14.0 * (_digits - 1);
                    final maxWidthPer =
                        ((constraints.maxWidth - totalSpacing) / _digits)
                            .clamp(44.0, 64.0);
                    return Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      children: List.generate(_digits, (i) {
                        return SizedBox(
                          width: maxWidthPer,
                          height: 56,
                          child: TextField(
                            controller: _controllers[i],
                            focusNode: _nodes[i],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(1),
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFF5F6F7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.black87, width: 1.5),
                              ),
                            ),
                            onChanged: (v) => _onChanged(i, v),
                          ),
                        );
                      }),
                    );
                  },
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkCard,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      elevation: 0,
                    ),
                    onPressed: _verifying ? null : _verify,
                    child: _verifying
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : const Text('Verify code',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Text('Haven\'t got the email yet?',
                        style: TextStyle(color: Colors.grey.shade600)),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: _resend,
                      child: const Text(
                        'Resend email',
                        style: TextStyle(
                            color: Color(0xFF4E7AC7),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
