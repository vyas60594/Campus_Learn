// Attractive, beginner-friendly Profile page matching the provided reference.
import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'login_screen.dart';

const Color kDarkCard = Color(0xFF273645);

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Demo user (replace with real user model later)
  String name = 'Rajan Vyas';
  String email = 'rajanvyas8@gmail.com';
  String branch = 'Computer Science';
  String year = '2nd Year';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: kDarkCard,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 4),
          Text('Manage your account information',
              style: TextStyle(color: Colors.grey.shade700)),

          const SizedBox(height: 16),

          // Avatar and basic info card
          _CardWrap(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundImage:
                      AssetImage('assets/images/user_dashboard/profile.jpeg'),
                  onBackgroundImageError: (_, __) {},
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: kDarkCard,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(color: Colors.black54),
                )
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Details list card
          _CardWrap(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _DetailRow(
                  icon: Icons.person_outline,
                  label: 'Full Name',
                  value: name,
                ),
                const SizedBox(height: 10),
                _DetailRow(
                  icon: Icons.alternate_email_rounded,
                  label: 'Email',
                  value: email,
                ),
                const SizedBox(height: 10),
                _DetailRow(
                  icon: Icons.school_rounded,
                  label: 'Branch',
                  value: branch,
                ),
                const SizedBox(height: 10),
                _DetailRow(
                  icon: Icons.date_range_rounded,
                  label: 'Year',
                  value: year,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push<Map<String, dynamic>>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditProfilePage(
                          name: name,
                          email: email,
                          branch: branch,
                          year: year,
                        ),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        name = (result['name'] as String?) ?? name;
                        email = (result['email'] as String?) ?? email;
                        branch = (result['branch'] as String?) ?? branch;
                        year = (result['year'] as String?) ?? year;
                      });
                    }
                  },
                  icon: const Icon(Icons.edit_rounded),
                  label: const Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3865F3),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to LoginScreen and clear navigation stack
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE11D48),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardWrap extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  const _CardWrap({required this.child, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DetailRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kDarkCard.withOpacity(0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: kDarkCard),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: kDarkCard,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
