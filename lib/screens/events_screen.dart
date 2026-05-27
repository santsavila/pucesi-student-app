import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/sample_data.dart';
import '../models/models.dart';
import '../widgets/event_card.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});
  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  String _selectedCategory = 'Todos';
  final List<String> _categories = ['Todos', 'Académico', 'Taller', 'Conferencia', 'Deporte', 'Administrativo'];

  List<UniversityEvent> get _filtered => _selectedCategory == 'Todos'
      ? sampleEvents : sampleEvents.where((e) => e.category == _selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0.5,
        title: const Text('Eventos PUCESI'),
      ),
      body: Column(children: [
        Container(
          color: AppTheme.white,
          height: 72,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            itemCount: _categories.length,
            itemBuilder: (context, i) {
              final cat = _categories[i];
              final selected = cat == _selectedCategory;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = cat),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppTheme.primaryBlue.withOpacity(0.12) : AppTheme.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: selected ? AppTheme.primaryBlue.withOpacity(0.25) : AppTheme.lightGray),
                  ),
                  child: Text(
                    cat,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: selected ? AppTheme.primaryBlue : AppTheme.mediumGray,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: _filtered.isEmpty
              ? const Center(child: Text('Sin eventos en esta categoría', style: TextStyle(color: AppTheme.mediumGray)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filtered.length,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: EventCard(event: _filtered[i], expanded: true),
                  ),
                ),
        ),
      ]),
    );
  }
}
