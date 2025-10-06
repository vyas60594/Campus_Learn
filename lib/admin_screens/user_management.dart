import 'package:flutter/material.dart';
import '../ui_shared/app_theme.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  String _searchQuery = '';
  String _selectedFilter = 'All';

  // Sample user data - replace with real data from your backend
  final List<_User> _users = [
    _User(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      role: 'Student',
      status: 'Active',
      joinDate: '2024-01-15',
      avatar: 'assets/images/avatar1.png',
    ),
    _User(
      id: '2',
      name: 'Jane Smith',
      email: 'jane@example.com',
      role: 'Student',
      status: 'Active',
      joinDate: '2024-02-20',
      avatar: 'assets/images/avatar2.png',
    ),
    _User(
      id: '3',
      name: 'Dr. Mike Johnson',
      email: 'mike@example.com',
      role: 'Teacher',
      status: 'Active',
      joinDate: '2024-01-10',
      avatar: 'assets/images/avatar3.png',
    ),
    _User(
      id: '4',
      name: 'Sarah Wilson',
      email: 'sarah@example.com',
      role: 'Student',
      status: 'Inactive',
      joinDate: '2024-03-05',
      avatar: 'assets/images/avatar4.png',
    ),
  ];

  List<_User> get _filteredUsers {
    var filtered = _users.where((user) {
      final matchesSearch = user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.email.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == 'All' || user.role == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'User Management',
          style: TextStyle(
            color: AppTheme.primary,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add, color: AppTheme.primary),
            onPressed: () {
              // TODO: Add new user
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and filter section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search bar
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppTheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['All', 'Student', 'Teacher', 'Admin'].map((filter) {
                      final isSelected = _selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(filter),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() => _selectedFilter = filter);
                          },
                          selectedColor: AppTheme.primary.withOpacity(0.2),
                          checkmarkColor: AppTheme.primary,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          
          // Users list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                final user = _filteredUsers[index];
                return _UserCard(
                  user: user,
                  onEdit: () => _editUser(user),
                  onDelete: () => _deleteUser(user),
                  onToggleStatus: () => _toggleUserStatus(user),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editUser(_User user) {
    // TODO: Navigate to edit user screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit ${user.name}')),
    );
  }

  void _deleteUser(_User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _users.removeWhere((u) => u.id == user.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${user.name} deleted')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _toggleUserStatus(_User user) {
    setState(() {
      final index = _users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        _users[index] = _User(
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role,
          status: user.status == 'Active' ? 'Inactive' : 'Active',
          joinDate: user.joinDate,
          avatar: user.avatar,
        );
      }
    });
  }
}

class _User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String status;
  final String joinDate;
  final String avatar;

  _User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.joinDate,
    required this.avatar,
  });
}

class _UserCard extends StatelessWidget {
  final _User user;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleStatus;

  const _UserCard({
    required this.user,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 25,
            backgroundColor: AppTheme.primary.withOpacity(0.1),
            child: Text(
              user.name[0].toUpperCase(),
              style: const TextStyle(
                color: AppTheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getRoleColor(user.role).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        user.role,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _getRoleColor(user.role),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: user.status == 'Active' 
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        user.status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: user.status == 'Active' ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Action buttons
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  onEdit();
                  break;
                case 'toggle':
                  onToggleStatus();
                  break;
                case 'delete':
                  onDelete();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 18),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'toggle',
                child: Row(
                  children: [
                    Icon(
                      user.status == 'Active' ? Icons.pause : Icons.play_arrow,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(user.status == 'Active' ? 'Deactivate' : 'Activate'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 18, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Student':
        return Colors.blue;
      case 'Teacher':
        return Colors.green;
      case 'Admin':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
