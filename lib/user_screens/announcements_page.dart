// Attractive, beginner-friendly Announcements page with search + simple filters.
import 'package:flutter/material.dart';

const Color kDarkCard = Color(0xFF273645);

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

enum _AnnFilterType { all, general, exam, event }

class _AnnouncementItem {
  final _AnnFilterType type;
  final String title;
  final String subtitle;
  final String time;
  final String body;
  const _AnnouncementItem({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.body,
  });
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  final List<_AnnouncementItem> _all = const [
    _AnnouncementItem(
      type: _AnnFilterType.general,
      title: 'Campus Wi‑Fi Maintenance',
      subtitle: 'IT Department',
      time: '1h ago',
      body:
          'Scheduled maintenance tonight from 11 PM to 2 AM. Internet access may be intermittent during this window.',
    ),
    _AnnouncementItem(
      type: _AnnFilterType.exam,
      title: 'Mid‑term Exam Schedule Released',
      subtitle: 'Examination Cell',
      time: 'Today',
      body:
          'Find the detailed date sheet on the portal. Please verify your subjects and report any clashes by Friday.',
    ),
    _AnnouncementItem(
      type: _AnnFilterType.event,
      title: 'Tech Fest 2025 – Registrations Open',
      subtitle: 'Student Council',
      time: 'Yesterday',
      body:
          'Participate in hackathons, design sprints, and workshops. Early bird registrations close next week.',
    ),
    _AnnouncementItem(
      type: _AnnFilterType.general,
      title: 'Library New Arrivals',
      subtitle: 'Central Library',
      time: '2d ago',
      body:
          'We have added 300+ new titles across CS, ECE, and Mathematics. Check the “New Arrivals” shelf.',
    ),
  ];

  _AnnFilterType _type = _AnnFilterType.all;
  String _query = '';

  List<_AnnouncementItem> get _items {
    final q = _query.trim().toLowerCase();
    final List<_AnnouncementItem> out = [];
    for (final a in _all) {
      // Filter by type
      bool matchesType = _type == _AnnFilterType.all || _type == a.type;
      if (!matchesType) continue;

      // Filter by search query (title/subtitle/body)
      if (q.isNotEmpty) {
        final hay = '${a.title} ${a.subtitle} ${a.body}'.toLowerCase();
        if (!hay.contains(q)) continue;
      }

      out.add(a);
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Announcements',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: kDarkCard,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 4),
          Text('Stay updated with campus notices and events',
              style: TextStyle(color: Colors.grey.shade700)),

          const SizedBox(height: 16),

          // Search + Filter row
          Row(
            children: [
              Expanded(
                child: _SearchField(
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
              const SizedBox(width: 10),
              _FilterButton(onTap: _openFilterSheet),
            ],
          ),

          const SizedBox(height: 14),

          if (items.isEmpty)
            const _EmptyResults()
          else ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '${items.length} updates',
                style: TextStyle(
                    color: Colors.grey.shade700, fontWeight: FontWeight.w600),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) => Divider(
                color: Colors.grey.shade300,
                height: 16,
              ),
              itemBuilder: (context, i) => _AnnCard(item: items[i]),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _openFilterSheet() async {
    _AnnFilterType temp = _type;
    final result = await showModalBottomSheet<_AnnFilterType>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.3,
          maxChildSize: 0.8,
          builder: (context, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 24,
                      offset: Offset(0, -8)),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 6),
                    child: Column(
                      children: [
                        Container(
                          width: 44,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Filter by type',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: kDarkCard,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller,
                      padding: const EdgeInsets.all(16),
                      child: StatefulBuilder(
                        builder: (context, setSheet) {
                          Widget chip(String text, _AnnFilterType v) {
                            final selected = temp == v;
                            return ChoiceChip(
                              selected: selected,
                              label: Text(text),
                              labelStyle: TextStyle(
                                color: selected ? Colors.white : kDarkCard,
                                fontWeight: FontWeight.w600,
                              ),
                              selectedColor: kDarkCard,
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.grey.shade300),
                              onSelected: (_) => setSheet(() => temp = v),
                            );
                          }

                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              chip('All', _AnnFilterType.all),
                              chip('General', _AnnFilterType.general),
                              chip('Exam', _AnnFilterType.exam),
                              chip('Event', _AnnFilterType.event),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            temp = _AnnFilterType.all;
                            (context as Element).markNeedsBuild();
                          },
                          child: const Text('Reset'),
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kDarkCard,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () => Navigator.pop(context, temp),
                          icon: const Icon(Icons.check_rounded, size: 18),
                          label: const Text('Apply'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() => _type = result);
    }
  }
}

class _SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const _SearchField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
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
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: kDarkCard),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search announcements...',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _AnnCard extends StatelessWidget {
  final _AnnouncementItem item;
  const _AnnCard({required this.item});

  Color get _accent {
    if (item.type == _AnnFilterType.exam) return const Color(0xFFE11D48);
    if (item.type == _AnnFilterType.event) return const Color(0xFF10B981);
    return const Color(0xFF0EA5E9); // general
  }

  IconData get _icon {
    if (item.type == _AnnFilterType.exam) return Icons.rule_rounded;
    if (item.type == _AnnFilterType.event) return Icons.event_rounded;
    return Icons.campaign_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(
              color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_icon, color: _accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: kDarkCard,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _accent.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item.type.name.toUpperCase(),
                        style: TextStyle(
                            color: _accent,
                            fontSize: 11,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  item.body,
                  style: TextStyle(color: Colors.grey.shade800),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.schedule_rounded,
                        size: 14, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(
                      item.time,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Saved "${item.title}"')),
                        );
                      },
                      icon: const Icon(Icons.bookmark_add_outlined),
                      label: const Text('Save'),
                    )
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

class _FilterButton extends StatelessWidget {
  final VoidCallback onTap;
  const _FilterButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 8)),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: const Icon(Icons.tune_rounded, color: kDarkCard),
      ),
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_rounded, size: 36, color: kDarkCard),
          const SizedBox(height: 8),
          const Text(
            'No announcements match your filters',
            style: TextStyle(fontWeight: FontWeight.w700, color: kDarkCard),
          ),
          const SizedBox(height: 4),
          Text(
            'Try changing the type or search to see more updates.',
            style: TextStyle(color: Colors.grey.shade700),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
