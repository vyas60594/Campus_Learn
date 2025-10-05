import 'package:flutter/material.dart';
import 'materials_page.dart';
import 'announcements_page.dart';
import 'qna_page.dart';
import 'profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Keeps track of the currently selected tab
  int _currentIndex = 0;

  // Colors to keep a consistent brand look
  static const Color darkCard = Color(0xFF273645);
  static const Color bg = Color(0xFFF4F6F8); // subtle page background

  // Example assets — replace these with your real paths in pubspec.yaml
  static const String avatarAsset = 'assets/images/avatar.png';
  static const String bookAsset = 'assets/images/icon_book.png';
  static const String announceAsset = 'assets/images/icon_announce.png';
  static const String qaAsset = 'assets/images/icon_qa.png';

  @override
  Widget build(BuildContext context) {
    // A simple list of tab widgets so it's easy to manage
    final List<Widget> tabs = [
      _HomeTab(
        avatarAsset: avatarAsset,
        bookAsset: bookAsset,
        announceAsset: announceAsset,
        qaAsset: qaAsset,
      ),
      const _MaterialsTab(),
      const _AnnouncementsTab(),
      const _QnATab(),
      const _ProfileTab(),
    ];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 16,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Premium brand mark
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: darkCard,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 14,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                ),
                const Positioned.fill(
                  child: Center(
                    child: Icon(Icons.school_rounded, color: Colors.white, size: 20),
                  ),
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 8,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFD54F),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            const Text(
              'CampusLearn',
              style: TextStyle(
                color: darkCard,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                setState(() => _currentIndex = 4); // go to Profile tab
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    avatarAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.person, color: darkCard),
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Divider(height: 0.5, thickness: 0.5),
        ),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        height: 70,
        backgroundColor: Colors.white,
        indicatorColor: darkCard.withOpacity(0.08),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book_rounded),
            label: 'Materials',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign_rounded),
            label: 'Updates',
          ),
          NavigationDestination(
            icon: Icon(Icons.question_answer_outlined),
            selectedIcon: Icon(Icons.question_answer_rounded),
            label: 'Q&A',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  
}

// --- Tabs ---

class _HomeTab extends StatelessWidget {
  final String avatarAsset;
  final String bookAsset;
  final String announceAsset;
  final String qaAsset;

  const _HomeTab({
    required this.avatarAsset,
    required this.bookAsset,
    required this.announceAsset,
    required this.qaAsset,
  });


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Animated Welcome Header
          const _WelcomeHeader(),

          const SizedBox(height: 16),

          // Search card
          const AnimatedEntrance(
            delay: Duration(milliseconds: 300),
            child: _SearchCard(),
          ),

          const SizedBox(height: 12),

          // Category chips
          AnimatedEntrance(
            delay: const Duration(milliseconds: 400),
            child: const _CategoryChips(
              categories: [
                'All',
                'Programming',
                'Math',
                'Electronics',
                'Physics',
                'English',
                'Business'
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Featured materials
          const _SectionHeader(title: 'Featured Materials', actionText: 'See all'),
          const SizedBox(height: 12),
          _FeaturedScroller(
            cards: [
              _FeaturedCardData(
                title: 'Python: OOP Essentials',
                subtitle: 'CS • Notes • 24 pages',
                icon: Icons.code_rounded,
                color: const Color(0xFF4F46E5),
              ),
              _FeaturedCardData(
                title: 'Digital Circuits Cheat Sheet',
                subtitle: 'ECE • PDF • 6 pages',
                icon: Icons.memory_rounded,
                color: const Color(0xFF0EA5E9),
              ),
              _FeaturedCardData(
                title: 'Calculus – Integrals',
                subtitle: 'Math • Notes • 18 pages',
                icon: Icons.functions_rounded,
                color: const Color(0xFF10B981),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Recent Updates refined
          const _SectionHeader(title: 'Recent Updates', actionText: 'View all'),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 18,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _UpdateItem(
                  icon: _AssetIcon(
                      path: bookAsset, fallbackIcon: Icons.menu_book_rounded),
                  title: 'Python Notes - Chapter 5',
                  subtitle: 'Computer Science',
                  time: '6 hours ago',
                ),
                _UpdateItem(
                  icon: _AssetIcon(
                      path: announceAsset,
                      fallbackIcon: Icons.campaign_rounded,
                      color: Colors.green),
                  title: 'Mid-term Exam Schedule Released',
                  subtitle: 'All Departments',
                  time: '2 hours ago',
                ),
                _UpdateItem(
                  icon: _AssetIcon(
                      path: qaAsset,
                      fallbackIcon: Icons.help_rounded,
                      color: Colors.purple),
                  title: 'New Q&A: OOPS Concept',
                  subtitle: 'Java',
                  time: '1 hour ago',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AssetIcon extends StatelessWidget {
  final String path;
  final IconData fallbackIcon;
  final Color? color;
  const _AssetIcon(
      {required this.path, required this.fallbackIcon, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: 24,
      height: 24,
      color: color,
      errorBuilder: (_, __, ___) =>
          Icon(fallbackIcon, color: color ?? const Color(0xFF273645)),
    );
  }
}

 

class _UpdateItem extends StatelessWidget {
  final _AssetIcon icon;
  final String title;
  final String subtitle;
  final String time;
  const _UpdateItem(
      {required this.icon,
      required this.title,
      required this.subtitle,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF7F8FA),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: icon,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF273645))),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),
            ),
            Text(time,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// --- New UI building blocks ---

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  const _SectionHeader({required this.title, required this.actionText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF273645),
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(actionText),
        )
      ],
    );
  }
}

class _SearchCard extends StatelessWidget {
  const _SearchCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.search_rounded, color: Colors.black54, size: 22),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Search subjects, notes, papers...',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF273645).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune_rounded, color: Color(0xFF273645)),
          ),
        ],
      ),
    );
  }
}

class _CategoryChips extends StatelessWidget {
  final List<String> categories;
  const _CategoryChips({required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isPrimary = index == 0; // "All"
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isPrimary ? const Color(0xFF273645) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: isPrimary
                  ? const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ]
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              categories[index],
              style: TextStyle(
                color: isPrimary ? Colors.white : const Color(0xFF273645),
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }
}


class _FeaturedCardData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  _FeaturedCardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}


class _QuickActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
            child:
                _ActionCard(icon: Icons.menu_book_rounded, title: 'Materials')),
        SizedBox(width: 12),
        Expanded(
            child: _ActionCard(
                icon: Icons.campaign_rounded, title: 'Announcements')),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ActionCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF273645),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.star, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF273645),
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: Colors.black54),
        ],
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _AnnouncementCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF273645)),
            ),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
          ],
        ),
      ),
    );
  }
}

class _QAItem extends StatelessWidget {
  final String question;
  final int answersCount;

  const _QAItem({required this.question, required this.answersCount});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF273645),
        child: const Icon(Icons.question_mark_rounded, color: Colors.white),
      ),
      title: Text(
        question,
        style: const TextStyle(
            fontWeight: FontWeight.w600, color: Color(0xFF273645)),
      ),
      subtitle: Text('$answersCount answers',
          style: TextStyle(color: Colors.grey.shade600)),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}

class _MaterialsTab extends StatelessWidget {
  const _MaterialsTab();

  @override
  Widget build(BuildContext context) {
    return const MaterialsPage();
  }
}

class _AnnouncementsTab extends StatelessWidget {
  const _AnnouncementsTab();

  @override
  Widget build(BuildContext context) {
    return const AnnouncementsPage();
  }
}

class _QnATab extends StatelessWidget {
  const _QnATab();

  @override
  Widget build(BuildContext context) {
    return const QnAPage();
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}

// --- NEW ANIMATED AND PROFESSIONAL WIDGETS ---

/// A reusable widget that animates its child's entrance with a fade and slide effect.
class AnimatedEntrance extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;

  const AnimatedEntrance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 400),
    this.offset = const Offset(0, 32),
  });

  @override
  State<AnimatedEntrance> createState() => _AnimatedEntranceState();
}

class _AnimatedEntranceState extends State<AnimatedEntrance>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _offset = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _offset,
        child: widget.child,
      ),
    );
  }
}


class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return AnimatedEntrance(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back,',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Rajan Vyas',
              style: TextStyle(
                color: Color(0xFF273645),
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedScroller extends StatelessWidget {
  final List<_FeaturedCardData> cards;
  const _FeaturedScroller({required this.cards});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final cardData = cards[index];
          return AnimatedEntrance(
            delay: Duration(milliseconds: 100 * index),
            child: _FeaturedCard(data: cardData),
          );
        },
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final _FeaturedCardData data;
  const _FeaturedCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: data.color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: data.color.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(data.icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Color(0xFF273645),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  data.subtitle,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.star_rounded, color: Color(0xFFFFB020), size: 18),
                    SizedBox(width: 4),
                    Text('4.8', style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(width: 8),
                    Text('• 2.3k views', style: TextStyle(color: Colors.black54)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

