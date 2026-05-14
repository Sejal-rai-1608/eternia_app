// ==========================================================
// SEARCH SCREEN - PREMIUM ADAPTIVE
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eternia_ef/utils/eternia_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String _query = "";

  final List<Map<String, dynamic>> _categories = [
    {"title": "Counselors", "icon": Icons.psychology_outlined, "count": "24"},
    {"title": "Peer Groups", "icon": Icons.people_outline, "count": "18"},
    {"title": "Meditations", "icon": Icons.spa_outlined, "count": "42"},
    {"title": "Articles", "icon": Icons.article_outlined, "count": "86"},
    {"title": "Exercises", "icon": Icons.fitness_center_outlined, "count": "31"},
    {"title": "Sounds", "icon": Icons.headphones_outlined, "count": "56"},
  ];

  final List<String> _recent = ["Anxiety management", "Sleep meditation", "Dr. Aria Vance", "Breathing techniques"];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = EterniaTheme.of(context);
    final query = _query.trim().toLowerCase();
    final recent = query.isEmpty
        ? _recent
        : _recent.where((term) => term.toLowerCase().contains(query)).toList();
    final categories = query.isEmpty
        ? _categories
        : _categories.where((cat) => (cat["title"] as String).toLowerCase().contains(query)).toList();

    return Scaffold(
      backgroundColor: theme.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconSecondary, size: 20),
              ),
              const SizedBox(height: 20),
              Text("Search", style: GoogleFonts.cormorantGaramond(color: theme.primary, fontSize: 38, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // SEARCH BAR
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: theme.cardSolid,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: theme.border),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: theme.textTertiary, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) => setState(() => _query = value),
                        style: GoogleFonts.poppins(color: theme.textPrimary, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "Search Eternia...",
                          hintStyle: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // RECENT SEARCHES
              Text("RECENT", style: GoogleFonts.poppins(color: theme.primary.withOpacity(0.5), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: recent.map((term) => GestureDetector(
                  onTap: () {
                    _searchController.text = term;
                    _searchController.selection = TextSelection.collapsed(offset: term.length);
                    setState(() => _query = term);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: theme.cardSolid,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: theme.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.history, color: theme.textTertiary, size: 14),
                        const SizedBox(width: 8),
                        Text(term, style: GoogleFonts.poppins(color: theme.textSecondary, fontSize: 11)),
                      ],
                    ),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 32),

              // CATEGORIES
              Text("EXPLORE", style: GoogleFonts.poppins(color: theme.primary.withOpacity(0.5), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.5,
                children: categories.map((cat) => GestureDetector(
                  onTap: () {
                    final title = cat["title"] as String;
                    _searchController.text = title;
                    _searchController.selection = TextSelection.collapsed(offset: title.length);
                    setState(() => _query = title);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: theme.cardSolid,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: theme.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(cat["icon"] as IconData, color: theme.primary, size: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cat["title"] as String, style: GoogleFonts.poppins(color: theme.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                            Text("${cat["count"]} items", style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 9)),
                          ],
                        ),
                      ],
                    ),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
