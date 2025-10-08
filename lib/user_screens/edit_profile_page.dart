// Beginner-friendly Edit Profile form page.
import 'package:flutter/material.dart';

const Color kDarkCard = Color(0xFF273645);

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String branch;
  final String year;
  const EditProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.branch,
    required this.year,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameC;
  late TextEditingController _emailC;
  late String _branch;
  late String _year;

  final List<String> _branches = const [
    'Computer Science',
    'Electronics',
    'Mechanical',
    'Civil',
    'Electrical',
  ];

  final List<String> _years = const [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
  ];

  @override
  void initState() {
    super.initState();
    _nameC = TextEditingController(text: widget.name);
    _emailC = TextEditingController(text: widget.email);
    _branch = widget.branch;
    _year = widget.year;
  }

  @override
  void dispose() {
    _nameC.dispose();
    _emailC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Profile',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: kDarkCard),
              ),
              const SizedBox(height: 4),
              Text('Edit  your account information',
                  style: TextStyle(color: Colors.grey.shade700)),
              const SizedBox(height: 16),

              // Avatar card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 18,
                        offset: Offset(0, 10)),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundImage: AssetImage(
                              'assets/images/user_dashboard/profile.jpeg'),
                          onBackgroundImageError: (_, __) {},
                        ),
                        Positioned(
                          right: -4,
                          bottom: -4,
                          child: Material(
                            color: const Color(0xFF3865F3),
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: _changeAvatar,
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.edit_rounded,
                                    color: Colors.white, size: 18),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(widget.name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: kDarkCard)),
                    const SizedBox(height: 4),
                    Text(widget.email,
                        style: const TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Name
              _LabeledField(
                label: 'Full Name',
                child: TextFormField(
                  controller: _nameC,
                  textInputAction: TextInputAction.next,
                  decoration: _roundedDecoration('Enter your full name'),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Please enter your name'
                      : null,
                ),
              ),
              const SizedBox(height: 12),

              // Email
              _LabeledField(
                label: 'Email',
                child: TextFormField(
                  controller: _emailC,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: _roundedDecoration('Enter your email'),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty)
                      return 'Please enter your email';
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Branch
              _LabeledField(
                label: 'Branch',
                child: DropdownButtonFormField<String>(
                  value: _branch.isNotEmpty ? _branch : null,
                  items: _branches
                      .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                      .toList(),
                  onChanged: (v) => setState(() => _branch = v ?? _branch),
                  decoration: _roundedDecoration(null),
                ),
              ),
              const SizedBox(height: 12),

              // Year
              _LabeledField(
                label: 'Year',
                child: DropdownButtonFormField<String>(
                  value: _year.isNotEmpty ? _year : null,
                  items: _years
                      .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                      .toList(),
                  onChanged: (v) => setState(() => _year = v ?? _year),
                  decoration: _roundedDecoration(null),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF22C55E), // green
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _save,
                      icon: const Icon(Icons.edit_note_rounded),
                      label: const Text('Save'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, {
      'name': _nameC.text.trim(),
      'email': _emailC.text.trim(),
      'branch': _branch,
      'year': _year,
    });
  }

  // --- Helpers inside state ---
  InputDecoration _roundedDecoration(String? hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kDarkCard, width: 1.4),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  void _changeAvatar() {
    // Placeholder: add image_picker later to allow real avatar upload
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Avatar picker coming soon (requires image_picker).'),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: kDarkCard,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}
