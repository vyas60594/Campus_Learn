import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _branches = const [
    'Information Technology',
    'Computer Science',
    'Mechanical',
    'Civil',
    'Chemical',
    'Electronic and Communications',
  ];

  final List<String> _years = const ['1st', '2nd', '3rd', '4th'];

  String? _selectedBranch;
  String? _selectedYear;
  bool _isLoading = false;

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
              _buildTopBar(context),
              const SizedBox(height: 12),
              _buildHeader(),
              const SizedBox(height: 24),
              _buildCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Transform.translate(
          // Counter the 20px horizontal padding of the page to align to screen edge
          offset: const Offset(-20, 0),
          child: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 32),
            tooltip: 'Back',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Complete Your\nProfile',
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 8),
        _HeaderSubtitle(),
      ],
    );
  }

  Widget _buildCard() {
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Branch',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedBranch,
              isExpanded: true,
              decoration: _dropdownDecoration(hint: 'Select'),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              items: _branches
                  .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedBranch = val),
              validator: (val) => val == null || val.isEmpty
                  ? 'Please select your branch'
                  : null,
            ),
            const SizedBox(height: 18),
            const Text(
              'Year',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedYear,
              isExpanded: true,
              decoration: _dropdownDecoration(hint: 'Select'),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              items: _years
                  .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedYear = val),
              validator: (val) =>
                  val == null || val.isEmpty ? 'Please select your year' : null,
            ),
            const SizedBox(height: 20),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      isDense: true,
      hintStyle: TextStyle(color: Colors.grey[600]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _onSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Sign Up',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() => _isLoading = false);
    // TODO: Continue to app/home after capturing profile
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved: $_selectedBranch, $_selectedYear')),
    );
  }
}

class _HeaderSubtitle extends StatelessWidget {
  const _HeaderSubtitle();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
        children: [
          TextSpan(text: 'Please select your '),
          TextSpan(
            text: 'branch',
            style: TextStyle(color: Colors.blue),
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'year',
            style: TextStyle(color: Colors.blue),
          ),
          TextSpan(text: ' to '),
          TextSpan(
            text: 'personalize',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: ' your experience'),
        ],
      ),
    );
  }
}
