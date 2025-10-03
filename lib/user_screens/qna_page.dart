// Attractive, beginner-friendly Q&A page with search and simple filters.
import 'package:flutter/material.dart';

const Color kDarkCard = Color(0xFF273645);

class QnAPage extends StatefulWidget {
  const QnAPage({super.key});

  @override
  State<QnAPage> createState() => _QnAPageState();
}

enum _QType { all, programming, math, electronics, general }

enum _SortBy { trending, newest, unanswered }

class _QuestionItem {
  final _QType type;
  final String title;
  final String author;
  final String time;
  final int answers;
  final int votes;
  final List<String> tags;
  const _QuestionItem({
    required this.type,
    required this.title,
    required this.author,
    required this.time,
    required this.answers,
    required this.votes,
    required this.tags,
  });
}

class _QnAPageState extends State<QnAPage> {
  final List<_QuestionItem> _all = const [
    _QuestionItem(
      type: _QType.programming,
      title: 'What is the difference between abstract class and interface in Java?',
      author: 'Aditi',
      time: '2h ago',
      answers: 5,
      votes: 12,
      tags: ['java', 'oop'],
    ),
    _QuestionItem(
      type: _QType.math,
      title: 'How to visualize eigenvectors and eigenvalues in simple terms?',
      author: 'Rahul',
      time: 'Today',
      answers: 2,
      votes: 9,
      tags: ['linear-algebra'],
    ),
    _QuestionItem(
      type: _QType.electronics,
      title: 'Why does increasing resistance decrease current in a circuit?',
      author: 'Sana',
      time: 'Yesterday',
      answers: 3,
      votes: 6,
      tags: ['ohms-law', 'circuits'],
    ),
    _QuestionItem(
      type: _QType.general,
      title: 'Tips to stay consistent while preparing for exams?',
      author: 'Ishaan',
      time: '2d ago',
      answers: 4,
      votes: 15,
      tags: ['study', 'productivity'],
    ),
  ];

  String _query = '';
  _QType _type = _QType.all;
  _SortBy _sort = _SortBy.trending;

  List<_QuestionItem> get _items {
    final q = _query.trim().toLowerCase();
    final List<_QuestionItem> filtered = [];

    for (final it in _all) {
      // Type filter
      final matchesType = _type == _QType.all || _type == it.type;
      if (!matchesType) continue;

      // Search query (in title + tags)
      if (q.isNotEmpty) {
        final hay = (it.title + ' ' + it.tags.join(' ')).toLowerCase();
        if (!hay.contains(q)) continue;
      }

      filtered.add(it);
    }

    // Sort
    filtered.sort((a, b) {
      if (_sort == _SortBy.trending) return b.votes.compareTo(a.votes);
      if (_sort == _SortBy.newest) return _timeRank(b.time).compareTo(_timeRank(a.time));
      // unanswered first
      return a.answers.compareTo(b.answers);
    });

    return filtered;
  }

  // Very simple "time rank" for demo purposes
  int _timeRank(String t) {
    if (t.contains('Today')) return 100;
    if (t.contains('h ago')) return 90;
    if (t.contains('Yesterday')) return 80;
    if (t.contains('d ago')) return 70;
    return 0;
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
            'Q&A',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: kDarkCard,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 4),
          Text('Ask questions and help others by answering',
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

          // Ask CTA
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Open Ask Question dialog...')),
                );
              },
              icon: const Icon(Icons.edit_rounded, size: 18),
              label: const Text('Ask a question'),
              style: ElevatedButton.styleFrom(
                backgroundColor: kDarkCard,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          const SizedBox(height: 10),

          if (items.isEmpty)
            const _EmptyResults()
          else ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '${items.length} questions',
                style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) => Divider(color: Colors.grey.shade300, height: 16),
              itemBuilder: (context, i) => _QuestionCard(item: items[i]),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _openFilterSheet() async {
    _QType tempType = _type;
    _SortBy tempSort = _sort;

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.55,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: const [
                  BoxShadow(color: Color(0x33000000), blurRadius: 24, offset: Offset(0, -8)),
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
                          'Filters',
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
                          Widget typeChip(String text, _QType v) {
                            final selected = tempType == v;
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
                              onSelected: (_) => setSheet(() => tempType = v),
                            );
                          }

                          Widget sortChip(String text, _SortBy v) {
                            final selected = tempSort == v;
                            return FilterChip(
                              selected: selected,
                              label: Text(text),
                              selectedColor: kDarkCard,
                              labelStyle: TextStyle(
                                color: selected ? Colors.white : kDarkCard,
                                fontWeight: FontWeight.w600,
                              ),
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.grey.shade300),
                              onSelected: (_) => setSheet(() => tempSort = v),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.category_rounded, color: kDarkCard),
                                  SizedBox(width: 8),
                                  Text('Topic', style: TextStyle(fontWeight: FontWeight.w800, color: kDarkCard)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  typeChip('All', _QType.all),
                                  typeChip('Programming', _QType.programming),
                                  typeChip('Math', _QType.math),
                                  typeChip('Electronics', _QType.electronics),
                                  typeChip('General', _QType.general),
                                ],
                              ),

                              const SizedBox(height: 18),
                              Row(
                                children: const [
                                  Icon(Icons.sort_rounded, color: kDarkCard),
                                  SizedBox(width: 8),
                                  Text('Sort by', style: TextStyle(fontWeight: FontWeight.w800, color: kDarkCard)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  sortChip('Trending', _SortBy.trending),
                                  sortChip('Newest', _SortBy.newest),
                                  sortChip('Unanswered', _SortBy.unanswered),
                                ],
                              ),
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
                            tempType = _QType.all;
                            tempSort = _SortBy.trending;
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
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () => Navigator.pop(context, {
                            'type': tempType,
                            'sort': tempSort,
                          }),
                          icon: const Icon(Icons.check_rounded, size: 18),
                          label: const Text('Apply'),
                        ),
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
      setState(() {
        _type = result['type'] as _QType? ?? _type;
        _sort = result['sort'] as _SortBy? ?? _sort;
      });
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
          BoxShadow(color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 8)),
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
                hintText: 'Search questions... (e.g., OOP, eigenvectors)',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final _QuestionItem item;
  const _QuestionCard({required this.item});

  Color get _accent {
    if (item.type == _QType.programming) return const Color(0xFF4F46E5);
    if (item.type == _QType.math) return const Color(0xFF10B981);
    if (item.type == _QType.electronics) return const Color(0xFF0EA5E9);
    return const Color(0xFFEAB308); // general
  }

  IconData get _icon {
    if (item.type == _QType.programming) return Icons.code_rounded;
    if (item.type == _QType.math) return Icons.functions_rounded;
    if (item.type == _QType.electronics) return Icons.memory_rounded;
    return Icons.chat_bubble_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meta column (votes/answers)
          Column(
            children: [
              _MetaPill(icon: Icons.arrow_upward_rounded, value: item.votes.toString()),
              const SizedBox(height: 8),
              _MetaPill(icon: Icons.forum_rounded, value: item.answers.toString()),
            ],
          ),
          const SizedBox(width: 12),
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: _accent.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(_icon, color: _accent),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.w800, color: kDarkCard),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final t in item.tags)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: _accent.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          t,
                          style: TextStyle(color: _accent, fontSize: 11, fontWeight: FontWeight.w700),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: kDarkCard.withOpacity(0.12),
                      child: const Icon(Icons.person, size: 14, color: kDarkCard),
                    ),
                    const SizedBox(width: 6),
                    // Flexible left meta cluster to avoid overflow
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              item.author,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: kDarkCard, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text('•', style: TextStyle(color: Colors.black54)),
                          const SizedBox(width: 8),
                          const Icon(Icons.schedule_rounded,
                              size: 14, color: Colors.black54),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              item.time,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Following: "${item.title}"')),
                        );
                      },
                      child: const Text('Follow'),
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

class _MetaPill extends StatelessWidget {
  final IconData icon;
  final String value;
  const _MetaPill({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.black54),
          const SizedBox(width: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
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
            BoxShadow(color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 8)),
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_rounded, size: 36, color: kDarkCard),
          const SizedBox(height: 8),
          const Text('No questions match your filters', style: TextStyle(fontWeight: FontWeight.w700, color: kDarkCard)),
          const SizedBox(height: 4),
          Text('Try changing topic, sort or search query to see more results.', style: TextStyle(color: Colors.grey.shade700), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
