// Materials page: shows a simple list of study materials with filters.
import 'package:flutter/material.dart';

// Brand color used across this screen
const Color kDarkCard = Color(0xFF273645);

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

enum _MaterialFilter { all, pdf, image, doc }

class _MaterialScreenState extends State<MaterialScreen> {
  _MaterialFilter _filter = _MaterialFilter.all;
  String _subject = 'All';

  // This method prepares the list of items to show based on the selected
  // filter (All/PDF/Image/Docs) and the selected subject. It's written in a
  // very step-by-step, beginner-friendly way.
  List<_MaterialItem> get _items {
    final List<_MaterialItem> output = [];

    for (final item in _sampleMaterials) {
      // 1) Filter by type
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

      // 2) Filter by subject
      bool matchesSubject = (_subject == 'All') || (item.stream == _subject);
      if (!matchesSubject) continue;

      output.add(item);
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    // Build a simple list of subjects from data without using advanced set logic
    final List<String> subjects = ['All'];
    for (final item in _sampleMaterials) {
      if (!subjects.contains(item.stream)) {
        subjects.add(item.stream);
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
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
          Text('Access and manage learning resources',
              style: TextStyle(color: Colors.grey.shade700)),

          const SizedBox(height: 16),

          // Search + Filter row
          Row(
            children: [
              Expanded(child: _SearchPill(onTap: () {})),
              const SizedBox(width: 10),
              _FilterButton(onTap: () => _openFilterSheet(subjects)),
            ],
          ),

          const SizedBox(height: 14),

          // Results list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            separatorBuilder: (_, __) => Divider(
              color: Colors.grey.shade300,
              height: 24,
            ),
            itemBuilder: (context, index) {
              return _MaterialRow(item: _items[index]);
            },
          ),
        ],
      ),
    );
  }

  // Opens a beautifully-styled bottom sheet to pick Type and Subject
  void _openFilterSheet(List<String> subjects) async {
    _MaterialFilter tempType = _filter;
    String tempSubject = _subject;

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
                  // Grab handle + Title
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
                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller,
                      padding: const EdgeInsets.all(16),
                      child: StatefulBuilder(
                        builder: (context, setSheetState) {
                          Widget typeChip(String text, _MaterialFilter v) {
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
                              onSelected: (_) => setSheetState(() => tempType = v),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Type Section
                              Row(
                                children: const [
                                  Icon(Icons.tune_rounded, color: kDarkCard),
                                  SizedBox(width: 8),
                                  Text(
                                    'Type',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: kDarkCard,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  typeChip('All', _MaterialFilter.all),
                                  typeChip('PDF', _MaterialFilter.pdf),
                                  typeChip('Image', _MaterialFilter.image),
                                  typeChip('Docs', _MaterialFilter.doc),
                                ],
                              ),

                              const SizedBox(height: 18),
                              // Subject Section
                              Row(
                                children: const [
                                  Icon(Icons.category_rounded, color: kDarkCard),
                                  SizedBox(width: 8),
                                  Text(
                                    'Subject',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: kDarkCard,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final s in subjects)
                                    FilterChip(
                                      label: Text(s),
                                      selected: tempSubject == s,
                                      selectedColor: kDarkCard,
                                      labelStyle: TextStyle(
                                        color: tempSubject == s ? Colors.white : kDarkCard,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      backgroundColor: Colors.white,
                                      side: BorderSide(color: Colors.grey.shade300),
                                      onSelected: (_) => setSheetState(() => tempSubject = s),
                                    ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  const Divider(height: 1),
                  // Actions
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            // Reset to defaults
                            tempType = _MaterialFilter.all;
                            tempSubject = 'All';
                            // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
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
                          onPressed: () {
                            Navigator.pop(context, {
                              'type': tempType,
                              'subject': tempSubject,
                            });
                          },
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
        _filter = result['type'] as _MaterialFilter? ?? _filter;
        _subject = result['subject'] as String? ?? _subject;
      });
    }
  }
}

// --- UI pieces ---

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
              child: Text(
                'Search here',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),
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

// --- List Row UI ---

class _MaterialRow extends StatelessWidget {
  final _MaterialItem item;
  const _MaterialRow({required this.item});

  // Beginner-friendly mapping of type to color/icon
  Color get _color {
    if (item.type == MaterialType.pdf) {
      return const Color(0xFFE11D48);
    } else if (item.type == MaterialType.image) {
      return const Color(0xFF6366F1);
    } else {
      return const Color(0xFF0EA5E9); // doc
    }
  }

  IconData get _icon {
    if (item.type == MaterialType.pdf) {
      return Icons.picture_as_pdf_rounded;
    } else if (item.type == MaterialType.image) {
      return Icons.image_rounded;
    } else {
      return Icons.description_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Leading type circle
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(_icon, color: _color),
        ),
        const SizedBox(width: 12),
        // Content
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
                  PopupMenuButton<String>(
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'share', child: Text('Share')),
                      PopupMenuItem(
                          value: 'save', child: Text('Save for later')),
                    ],
                    onSelected: (_) {},
                    icon: const Icon(Icons.more_horiz, color: Colors.black54),
                  )
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '${item.stream} • ${item.year}',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
              ),
              const SizedBox(height: 6),
              Text(
                item.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade800),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.insert_drive_file_rounded,
                      size: 14, color: Colors.black54),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      item.file,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 12),
                    ),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Previewing ${item.title}...')),
                      );
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Downloading ${item.title}...')),
                      );
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
    );
  }
}

// (Removed unused _HeroPill widget to keep code simple.)


// --- Sample data ---

enum MaterialType { pdf, image, doc }

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

const _sampleMaterials = <_MaterialItem>[
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
    type: MaterialType.pdf,
    title: 'Calculus Reference Sheet',
    stream: 'Mathematics',
    year: '1st Year',
    description: 'Quick reference for calculus formulas and concepts',
    uploaded: '8/22/2024',
    file: 'calc/calc-ref.pdf',
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
