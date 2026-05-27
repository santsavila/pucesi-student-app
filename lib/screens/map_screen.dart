import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/sample_data.dart';
import '../models/models.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _selectedCategory = 'todos';
  CampusLocation? _selectedLocation;

  final Map<String, Map<String, dynamic>> _categories = {
    'todos': {'label': 'Todo', 'icon': Icons.apps, 'color': AppTheme.primaryBlue},
    'aula': {'label': 'Aulas', 'icon': Icons.school, 'color': AppTheme.accentBlue},
    'biblioteca': {'label': 'Biblioteca', 'icon': Icons.library_books, 'color': AppTheme.success},
    'cafeteria': {'label': 'Cafetería', 'icon': Icons.restaurant, 'color': AppTheme.warning},
    'recreativo': {'label': 'Recreativo', 'icon': Icons.sports_soccer, 'color': const Color(0xFF8B5CF6)},
    'admin': {'label': 'Servicios', 'icon': Icons.admin_panel_settings, 'color': AppTheme.danger},
  };

  List<CampusLocation> get _filtered => _selectedCategory == 'todos'
      ? campusLocations : campusLocations.where((l) => l.category == _selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0.5,
        title: const Text('Mapa del Campus'),
      ),
      body: Column(children: [
        Container(
          color: AppTheme.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: _categories.entries.map((entry) {
              final selected = entry.key == _selectedCategory;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = entry.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppTheme.lightGray : AppTheme.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: selected ? AppTheme.primaryBlue.withOpacity(0.25) : AppTheme.lightGray),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(entry.value['icon'] as IconData, size: 16, color: selected ? AppTheme.primaryBlue : AppTheme.mediumGray),
                    const SizedBox(width: 8),
                    Text(entry.value['label'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: selected ? AppTheme.primaryBlue : AppTheme.mediumGray)),
                  ]),
                ),
              );
            }).toList()),
          ),
        ),
        if (_selectedLocation != null)
          Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.lightGray)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(_selectedLocation!.icon, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 10),
                Expanded(child: Text(_selectedLocation!.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.darkGray))),
                IconButton(onPressed: () => setState(() => _selectedLocation = null), icon: const Icon(Icons.close, size: 18), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
              ]),
              const SizedBox(height: 8),
              Text(_selectedLocation!.description, style: const TextStyle(fontSize: 12, color: AppTheme.mediumGray)),
              const SizedBox(height: 10),
              Wrap(spacing: 6, runSpacing: 4, children: _selectedLocation!.services.map((s) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: AppTheme.lightGray, borderRadius: BorderRadius.circular(12)),
                child: Text(s, style: const TextStyle(fontSize: 11, color: AppTheme.darkGray, fontWeight: FontWeight.w500)),
              )).toList()),
            ]),
          ),
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _filtered.length,
          itemBuilder: (context, i) {
            final loc = _filtered[i];
            final color = (_categories[loc.category]?['color'] as Color?) ?? AppTheme.primaryBlue;
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                onTap: () => setState(() => _selectedLocation = loc),
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text(loc.icon, style: TextStyle(fontSize: 20, color: color))),
                ),
                title: Text(loc.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.darkGray)),
                subtitle: Text(loc.floor, style: const TextStyle(fontSize: 12, color: AppTheme.mediumGray)),
                trailing: const Icon(Icons.chevron_right, color: AppTheme.mediumGray),
              ),
            );
          },
        )),
      ]),
    );
  }
}
