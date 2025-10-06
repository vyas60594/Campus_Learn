import 'package:flutter/material.dart';
import '../ui_shared/app_theme.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({super.key});

  @override
  State<AdminSettings> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = false;
  String _selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Admin Settings',
          style: TextStyle(
            color: AppTheme.primary,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            _SettingsSection(
              title: 'Profile',
              children: [
                _SettingsTile(
                  icon: Icons.person,
                  title: 'Admin Profile',
                  subtitle: 'Manage your admin account details',
                  onTap: () {
                    // TODO: Navigate to profile edit
                  },
                ),
                _SettingsTile(
                  icon: Icons.security,
                  title: 'Change Password',
                  subtitle: 'Update your admin password',
                  onTap: () {
                    // TODO: Navigate to change password
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Notifications Section
            _SettingsSection(
              title: 'Notifications',
              children: [
                _SwitchTile(
                  icon: Icons.notifications,
                  title: 'Enable Notifications',
                  subtitle: 'Receive notifications for important events',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
                ),
                if (_notificationsEnabled) ...[
                  _SwitchTile(
                    icon: Icons.email,
                    title: 'Email Notifications',
                    subtitle: 'Get notified via email',
                    value: _emailNotifications,
                    onChanged: (value) {
                      setState(() => _emailNotifications = value);
                    },
                  ),
                  _SwitchTile(
                    icon: Icons.phone_android,
                    title: 'Push Notifications',
                    subtitle: 'Get notified on your device',
                    value: _pushNotifications,
                    onChanged: (value) {
                      setState(() => _pushNotifications = value);
                    },
                  ),
                ],
              ],
            ),

            const SizedBox(height: 24),

            // App Settings Section
            _SettingsSection(
              title: 'App Settings',
              children: [
                _DropdownTile(
                  icon: Icons.palette,
                  title: 'Theme',
                  subtitle: 'Choose your preferred theme',
                  value: _selectedTheme,
                  items: ['Light', 'Dark', 'System'],
                  onChanged: (value) {
                    setState(() => _selectedTheme = value!);
                  },
                ),
                _SettingsTile(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: 'English (US)',
                  onTap: () {
                    // TODO: Show language picker
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // System Section
            _SettingsSection(
              title: 'System',
              children: [
                _SettingsTile(
                  icon: Icons.backup,
                  title: 'Backup Data',
                  subtitle: 'Create a backup of all platform data',
                  onTap: () {
                    _showBackupDialog();
                  },
                ),
                _SettingsTile(
                  icon: Icons.restore,
                  title: 'Restore Data',
                  subtitle: 'Restore from a previous backup',
                  onTap: () {
                    _showRestoreDialog();
                  },
                ),
                _SettingsTile(
                  icon: Icons.analytics,
                  title: 'System Logs',
                  subtitle: 'View system activity and error logs',
                  onTap: () {
                    // TODO: Navigate to system logs
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Danger Zone
            _SettingsSection(
              title: 'Danger Zone',
              children: [
                _SettingsTile(
                  icon: Icons.logout,
                  title: 'Logout',
                  subtitle: 'Sign out of admin panel',
                  textColor: Colors.orange,
                  onTap: () {
                    _showLogoutDialog();
                  },
                ),
                _SettingsTile(
                  icon: Icons.delete_forever,
                  title: 'Delete All Data',
                  subtitle: 'Permanently delete all platform data',
                  textColor: Colors.red,
                  onTap: () {
                    _showDeleteDataDialog();
                  },
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Backup Data'),
        content: const Text(
            'This will create a backup of all platform data. This may take a few minutes.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Backup started...')),
              );
            },
            child: const Text('Start Backup'),
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore Data'),
        content: const Text(
            'This will restore data from a previous backup. All current data will be replaced.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Restore started...')),
              );
            },
            child: const Text('Restore'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content:
            const Text('Are you sure you want to logout from the admin panel?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement logout logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete All Data'),
        content: const Text(
            'This action cannot be undone. All users, materials, announcements, and Q&A data will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data deletion started...')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child:
                const Text('Delete All', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppTheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? textColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (textColor ?? AppTheme.primary).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: textColor ?? AppTheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: textColor ?? AppTheme.primary,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppTheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: AppTheme.primary,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primary,
      ),
    );
  }
}

class _DropdownTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppTheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: AppTheme.primary,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        underline: const SizedBox(),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}
