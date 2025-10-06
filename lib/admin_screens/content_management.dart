import 'package:flutter/material.dart';
import '../ui_shared/app_theme.dart';

class ContentManagement extends StatefulWidget {
  const ContentManagement({super.key});

  @override
  State<ContentManagement> createState() => _ContentManagementState();
}

class _ContentManagementState extends State<ContentManagement> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Content Management',
          style: TextStyle(
            color: AppTheme.primary,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          // Tab bar
          Container(
            color: Colors.white,
            child: Row(
              children: [
                _buildTab(0, 'Materials', Icons.book),
                _buildTab(1, 'Announcements', Icons.campaign),
                _buildTab(2, 'Q&A', Icons.quiz),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: IndexedStack(
              index: _selectedTab,
              children: const [
                _MaterialsTab(),
                _AnnouncementsTab(),
                _QnATab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String label, IconData icon) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppTheme.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? AppTheme.primary : Colors.grey.shade600,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? AppTheme.primary : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MaterialsTab extends StatelessWidget {
  const _MaterialsTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Add material button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Navigate to add material screen
              },
              icon: const Icon(Icons.add),
              label: const Text('Add New Material'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Materials list
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Sample count
              itemBuilder: (context, index) {
                return _MaterialCard(
                  title: 'Sample Material ${index + 1}',
                  type: 'PDF',
                  uploadDate: '2024-01-${15 + index}',
                  onEdit: () {},
                  onDelete: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AnnouncementsTab extends StatelessWidget {
  const _AnnouncementsTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Add announcement button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Navigate to add announcement screen
              },
              icon: const Icon(Icons.add),
              label: const Text('Create Announcement'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Announcements list
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Sample count
              itemBuilder: (context, index) {
                return _AnnouncementCard(
                  title: 'Important Update ${index + 1}',
                  date: '2024-01-${20 + index}',
                  onEdit: () {},
                  onDelete: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _QnATab extends StatelessWidget {
  const _QnATab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Filter options
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: 'All',
                  decoration: InputDecoration(
                    labelText: 'Filter by Status',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: ['All', 'Answered', 'Unanswered'].map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Q&A list
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Sample count
              itemBuilder: (context, index) {
                return _QnACard(
                  question: 'Sample Question ${index + 1}',
                  author: 'Student ${index + 1}',
                  date: '2024-01-${25 + index}',
                  isAnswered: index % 2 == 0,
                  onAnswer: () {},
                  onDelete: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MaterialCard extends StatelessWidget {
  final String title;
  final String type;
  final String uploadDate;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _MaterialCard({
    required this.title,
    required this.type,
    required this.uploadDate,
    required this.onEdit,
    required this.onDelete,
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.picture_as_pdf, color: Colors.blue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Type: $type • Uploaded: $uploadDate',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') onEdit();
              if (value == 'delete') onDelete();
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
}

class _AnnouncementCard extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AnnouncementCard({
    required this.title,
    required this.date,
    required this.onEdit,
    required this.onDelete,
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.campaign, color: Colors.orange, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Posted: $date',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') onEdit();
              if (value == 'delete') onDelete();
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
}

class _QnACard extends StatelessWidget {
  final String question;
  final String author;
  final String date;
  final bool isAnswered;
  final VoidCallback onAnswer;
  final VoidCallback onDelete;

  const _QnACard({
    required this.question,
    required this.author,
    required this.date,
    required this.isAnswered,
    required this.onAnswer,
    required this.onDelete,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.quiz, color: Colors.purple, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isAnswered 
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isAnswered ? 'Answered' : 'Pending',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isAnswered ? Colors.green : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'By $author • $date',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (!isAnswered)
                ElevatedButton.icon(
                  onPressed: onAnswer,
                  icon: const Icon(Icons.reply, size: 16),
                  label: const Text('Answer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              const Spacer(),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
