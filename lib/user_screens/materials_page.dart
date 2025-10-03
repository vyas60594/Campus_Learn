// Clean, beginner-friendly Materials page with working filters and premium-but-simple UI.
import 'package:flutter/material.dart';

const Color kDarkCard = Color(0xFF273645);

enum MaterialType { pdf, image, doc }

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({super.key});

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

enum _MaterialFilter { all, pdf, image, doc }

class _MaterialsPageState extends State<MaterialsPage> {
  _MaterialFilter _filter = _MaterialFilter.all;
  String _subject = 'All';

  // Sample data
  final List<_MaterialItem> _all = const [
    _MaterialItem(
      type: MaterialType.pdf,
      title: 'Calculus Reference Sheet',
      stream: 'Mathematics',
      year: '1st Year',
      description: 'Quick reference for calculus formulas and concepts',
      uploaded: '8/22/2024',
      file: 'calc/calc-ref.pdf',
    ),
    _MaterialItem(
      type: MaterialType.pdf,
      title: 'Introduction to Data Structures',
      stream: 'Computer Science',
      year: '2nd Year',
      description: 'Comprehensive guide to basic data structures',
      uploaded: '8/22/2024',
      file: 'cs/data-structures.pdf',
    ),
    _MaterialItem(
      type: MaterialType.image,
      title: 'Circuit Diagram Examples',
      stream: 'Electronics',
      year: '2nd Year',
      description:
          'Collection of basic electronic circuit diagrams with explanations',
      uploaded: '8/25/2024',
      file: 'images/circuits.jpg',
    ),
    _MaterialItem(
      type: MaterialType.doc,
      title: 'Operating Systems Notes',
      stream: 'Computer Science',
      year: '3rd Year',
      description: 'Summary notes for process management and memory systems',
      uploaded: '8/21/2024',
      file: 'cs/os-notes.docx',
    ),
  ];

  // Build subjects list (beginners-friendly code)
  List<String> _buildSubjects() {
    final List<String> subjects = ['All'];
    for (final item in _all) {
      if (!subjects.contains(item.stream)) {
        subjects.add(item.stream);
      }
    }
    return subjects;
  }

  // Apply selected filters
  List<_MaterialItem> _filteredItems() {
    final String selectedSubject = _subject.trim().toLowerCase();
    final List<_MaterialItem> out = [];
    for (final item in _all) {
      // Type filter
      bool matchesType = false;
      if (_filter == _MaterialFilter.all) {
        matchesType = true;
      } else if (_filter == _MaterialFilter.pdf &&
          item.type == MaterialType.pdf) {
        matchesType = true;
      } else if (_filter == _MaterialFilter.image &&
          item.type == MaterialType.image) {
        matchesType = true;
      } else if (_filter == _MaterialFilter.doc &&
          item.type == MaterialType.doc) {
        matchesType = true;
      }
      if (!matchesType) continue;

      // Subject filter
      if (selectedSubject != 'all' &&
          item.stream.trim().toLowerCase() != selectedSubject) {
        continue;
      }

      out.add(item);
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final subjects = _buildSubjects();
    final items = _filteredItems();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Study Materials',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: kDarkCard,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Access and manage learning resources',
            style: TextStyle(color: Colors.grey.shade700),
          ),

          const SizedBox(height: 16),

          // Search + Filter button
          Row(
            children: [
              Expanded(child: _SearchPill(onTap: () {})),
              const SizedBox(width: 10),
              _FilterButton(onTap: () {}),
            ],
          ),

          const SizedBox(height: 14),

          // Type filter (segmented)
          _SegmentedFilter(
            value: _filter,
            onChanged: (v) => setState(() => _filter = v),
          ),

          const SizedBox(height: 12),

          // Subject chips
          _SubjectChips(
            subjects: subjects,
            selected: _subject,
            onSelect: (s) => setState(() => _subject = s),
          ),

          const SizedBox(height: 8),

          // Results or Empty
          if (items.isEmpty) ...[
            const _EmptyResults(),
          ] else ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '${items.length} results',
                style: TextStyle(
                    color: Colors.grey.shade700, fontWeight: FontWeight.w600),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) =>
                  Divider(color: Colors.grey.shade300, height: 24),
              itemBuilder: (context, i) => _MaterialRow(item: items[i]),
            ),
          ]
        ],
      ),
    );
  }
}

// Simple widgets
class _SearchPill extends StatelessWidget {
  final VoidCallback onTap;
  const _SearchPill({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 8)),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: kDarkCard),
            const SizedBox(width: 8),
            Expanded(
              child: Text('Search here',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
            ),
          ],
        ),
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

class _SegmentedFilter extends StatelessWidget {
  final _MaterialFilter value;
  final ValueChanged<_MaterialFilter> onChanged;
  const _SegmentedFilter({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Widget chip(String text, _MaterialFilter v) {
      final selected = value == v;
      return ChoiceChip(
        selected: selected,
        label: Text(text),
        labelStyle: TextStyle(
            color: selected ? Colors.white : kDarkCard,
            fontWeight: FontWeight.w600),
        selectedColor: kDarkCard,
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.grey.shade300),
        onSelected: (_) => onChanged(v),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        chip('All', _MaterialFilter.all),
        chip('PDF', _MaterialFilter.pdf),
        chip('Image', _MaterialFilter.image),
        chip('Docs', _MaterialFilter.doc),
      ],
    );
  }
}

class _SubjectChips extends StatelessWidget {
  final List<String> subjects;
  final String selected;
  final ValueChanged<String> onSelect;
  const _SubjectChips(
      {required this.subjects, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: subjects.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final s = subjects[i];
          final sel = s == selected;
          return InkWell(
            onTap: () => onSelect(s),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: sel ? kDarkCard : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: sel
                    ? const [
                        BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 12,
                            offset: Offset(0, 6))
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                s,
                style: TextStyle(
                    color: sel ? Colors.white : kDarkCard,
                    fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MaterialRow extends StatelessWidget {
  final _MaterialItem item;
  const _MaterialRow({required this.item});

  Color get _color {
    if (item.type == MaterialType.pdf) return const Color(0xFFE11D48);
    if (item.type == MaterialType.image) return const Color(0xFF6366F1);
    return const Color(0xFF0EA5E9);
  }

  IconData get _icon {
    if (item.type == MaterialType.pdf) return Icons.picture_as_pdf_rounded;
    if (item.type == MaterialType.image) return Icons.image_rounded;
    return Icons.description_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(
              color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 4))
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
                color: _color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(_icon, color: _color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: kDarkCard),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: _color.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(item.type.name.toUpperCase(),
                                style: TextStyle(
                                    color: _color,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text('${item.stream} • ${item.year}',
                    style:
                        TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                const SizedBox(height: 6),
                Text(item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade800)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.insert_drive_file_rounded,
                        size: 14, color: Colors.black54),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(item.file,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Previewing ${item.title}...')));
                      },
                      icon: const Icon(Icons.visibility_rounded, size: 18),
                      label: const Text('Preview'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kDarkCard,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Downloading ${item.title}...')));
                      },
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text('Download'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
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
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_rounded, size: 36, color: kDarkCard),
          const SizedBox(height: 8),
          const Text('No materials match your filters',
              style: TextStyle(fontWeight: FontWeight.w700, color: kDarkCard)),
          const SizedBox(height: 4),
          Text('Try changing the type or subject filters to see more results.',
              style: TextStyle(color: Colors.grey.shade700),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _MaterialItem {
  final MaterialType type;
  final String title;
  final String stream;
  final String year;
  final String description;
  final String uploaded;
  final String file;
  const _MaterialItem({
    required this.type,
    required this.title,
    required this.stream,
    required this.year,
    required this.description,
    required this.uploaded,
    required this.file,
  });
}
