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

  static const Map<String, Map<String, dynamic>> _categories = {
    'todos':      {'label': 'Todo',       'icon': Icons.apps,                'color': AppTheme.primaryBlue},
    'aula':       {'label': 'Aulas',      'icon': Icons.school,              'color': AppTheme.accentBlue},
    'biblioteca': {'label': 'Biblioteca', 'icon': Icons.library_books,       'color': AppTheme.success},
    'cafeteria':  {'label': 'Cafetería',  'icon': Icons.restaurant,          'color': AppTheme.warning},
    'recreativo': {'label': 'Recreativo', 'icon': Icons.sports_soccer,       'color': Color(0xFF7C3AED)},
    'admin':      {'label': 'Servicios',  'icon': Icons.admin_panel_settings, 'color': AppTheme.danger},
  };

  // Color único por edificio
  Color _colorFor(CampusLocation loc) {
    if (loc.name.startsWith('Bloque A'))    return const Color(0xFF1E40AF);
    if (loc.name.startsWith('Bloque B'))    return const Color(0xFF2563EB);
    if (loc.name.startsWith('Bloque C'))    return const Color(0xFF4F46E5);
    if (loc.name.startsWith('Biblioteca'))  return const Color(0xFF059669);
    if (loc.name.startsWith('Cafetería'))   return const Color(0xFFD97706);
    if (loc.name.startsWith('Auditorio'))   return const Color(0xFF7C3AED);
    if (loc.name.startsWith('Canchas'))     return const Color(0xFF0891B2);
    if (loc.name.startsWith('Secretaría'))  return const Color(0xFFDC2626);
    if (loc.name.startsWith('Bienestar'))   return const Color(0xFFDB2777);
    if (loc.name.startsWith('Parqueadero')) return const Color(0xFF6B7280);
    return AppTheme.primaryBlue;
  }

  // Nombre corto para mostrar en el bloque del mapa
  String _shortName(String name) {
    if (name.contains(' - ')) {
      final parts = name.split(' - ');
      return '${parts[0]}\n${parts[1]}';
    }
    final words = name.split(' ');
    if (words.length <= 2) return name;
    return '${words[0]}\n${words[1]}';
  }

  List<CampusLocation> get _filtered => _selectedCategory == 'todos'
      ? campusLocations
      : campusLocations.where((l) => l.category == _selectedCategory).toList();

  // Encuentra un edificio por prefijo de nombre
  CampusLocation _find(String prefix) => campusLocations.firstWhere(
        (l) => l.name.startsWith(prefix),
        orElse: () => campusLocations.first,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          // ── AppBar ──────────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: AppTheme.primaryBlue,
            foregroundColor: AppTheme.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text(
              'Mapa del Campus',
              style: TextStyle(
                color: AppTheme.white,
                fontWeight: FontWeight.w800,
                fontSize: 20,
                letterSpacing: 0.4,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header + estadísticas ───────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Campus PUCESI',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.darkGray,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Ibarra · Ecuador',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.mediumGray,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _statBadge('${campusLocations.length}', 'lugares'),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ── Mapa visual ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildVisualMap(),
                ),

                // ── Leyenda de colores ───────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Wrap(
                    spacing: 14,
                    runSpacing: 6,
                    children: [
                      _legendDot('Aulas',      const Color(0xFF2563EB)),
                      _legendDot('Biblioteca', const Color(0xFF059669)),
                      _legendDot('Cafetería',  const Color(0xFFD97706)),
                      _legendDot('Recreativo', const Color(0xFF7C3AED)),
                      _legendDot('Servicios',  const Color(0xFFDC2626)),
                    ],
                  ),
                ),

                // ── Detalle del edificio seleccionado ────────────────
                if (_selectedLocation != null) ...[
                  const SizedBox(height: 16),
                  _buildLocationDetail(_selectedLocation!),
                ],

                const SizedBox(height: 16),

                // ── Filtros por categoría ────────────────────────────
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: _categories.entries.map((entry) {
                      final selected = entry.key == _selectedCategory;
                      final color = entry.value['color'] as Color;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedCategory = entry.key),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                selected ? color : AppTheme.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                entry.value['icon'] as IconData,
                                size: 14,
                                color: selected
                                    ? AppTheme.white
                                    : AppTheme.mediumGray,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                entry.value['label'] as String,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                  color: selected
                                      ? AppTheme.white
                                      : AppTheme.mediumGray,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 14),

                // ── Lista de ubicaciones ────────────────────────────
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: _filtered.length,
                  itemBuilder: (context, i) {
                    final loc = _filtered[i];
                    final color = _colorFor(loc);
                    final isSelected = _selectedLocation?.name == loc.name;
                    return GestureDetector(
                      onTap: () => setState(() =>
                          _selectedLocation = isSelected ? null : loc),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? color.withOpacity(0.07)
                              : AppTheme.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? color.withOpacity(0.6)
                                : Colors.transparent,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(loc.icon,
                                  style: const TextStyle(fontSize: 22)),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  loc.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14.5,
                                    color: AppTheme.darkGray,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  loc.floor,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.mediumGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.chevron_right,
                                color: color, size: 16),
                          ),
                        ]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Mapa visual del campus ─────────────────────────────────────────
  Widget _buildVisualMap() {
    final bloqueA    = _find('Bloque A');
    final bloqueB    = _find('Bloque B');
    final bloqueC    = _find('Bloque C');
    final biblioteca = _find('Biblioteca');
    final cafeteria  = _find('Cafetería');
    final auditorio  = _find('Auditorio');
    final canchas    = _find('Canchas');
    final secretaria = _find('Secretaría');
    final bienestar  = _find('Bienestar');
    final parqueadero= _find('Parqueadero');

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE8F3E5), Color(0xFFDDE8DA)],
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFBFD1BC), width: 1),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Etiqueta de zona
            _zoneLabel('ZONA ACADÉMICA', Icons.school),
            const SizedBox(height: 6),
            // Fila 1: Bloques A, B, C
            Row(children: [
              Expanded(flex: 4, child: _mapBuilding(bloqueA)),
              const SizedBox(width: 5),
              Expanded(flex: 4, child: _mapBuilding(bloqueB)),
              const SizedBox(width: 5),
              Expanded(flex: 5, child: _mapBuilding(bloqueC)),
            ]),
            _streetDivider(),
            // Fila 2: Biblioteca y Cafetería
            Row(children: [
              Expanded(flex: 5, child: _mapBuilding(biblioteca)),
              const SizedBox(width: 5),
              Expanded(flex: 5, child: _mapBuilding(cafeteria)),
            ]),
            _streetDivider(),
            // Fila 3: Auditorio y Canchas
            _zoneLabel('ZONA RECREATIVA', Icons.sports_soccer),
            const SizedBox(height: 6),
            Row(children: [
              Expanded(flex: 4, child: _mapBuilding(auditorio)),
              const SizedBox(width: 5),
              Expanded(flex: 6, child: _mapBuilding(canchas)),
            ]),
            _streetDivider(),
            // Fila 4: Servicios
            _zoneLabel('SERVICIOS', Icons.admin_panel_settings),
            const SizedBox(height: 6),
            Row(children: [
              Expanded(flex: 4, child: _mapBuilding(secretaria)),
              const SizedBox(width: 5),
              Expanded(flex: 4, child: _mapBuilding(bienestar)),
              const SizedBox(width: 5),
              Expanded(flex: 3, child: _mapBuilding(parqueadero)),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _mapBuilding(CampusLocation loc) {
    final color = _colorFor(loc);
    final isSelected = _selectedLocation?.name == loc.name;
    final isFiltered =
        _selectedCategory != 'todos' && loc.category != _selectedCategory;

    return GestureDetector(
      onTap: () =>
          setState(() => _selectedLocation = isSelected ? null : loc),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 66,
        decoration: BoxDecoration(
          color: isFiltered
              ? const Color(0xFFD0DDD0)
              : (isSelected
                  ? color.withOpacity(0.28)
                  : color.withOpacity(0.14)),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isFiltered
                ? const Color(0xFFB0C4B0)
                : (isSelected ? color : color.withOpacity(0.55)),
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                loc.icon,
                style: TextStyle(fontSize: isFiltered ? 14 : 16),
              ),
              const SizedBox(height: 2),
              Text(
                _shortName(loc.name),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 7.5,
                  fontWeight: FontWeight.w700,
                  color: isFiltered
                      ? const Color(0xFF8B9B8B)
                      : color,
                  height: 1.2,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _streetDivider() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          height: 7,
          decoration: BoxDecoration(
            color: const Color(0xFFBACABA),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Container(
              height: 1.5,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: const Color(0xFFA8B8A8).withOpacity(0.5),
            ),
          ),
        ),
      );

  Widget _zoneLabel(String label, IconData icon) => Row(
        children: [
          Icon(icon, size: 10, color: AppTheme.mediumGray.withOpacity(0.6)),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: AppTheme.mediumGray.withOpacity(0.7),
              letterSpacing: 1.0,
            ),
          ),
        ],
      );

  // ── Detalle de ubicación seleccionada ──────────────────────────────
  Widget _buildLocationDetail(CampusLocation loc) {
    final color = _colorFor(loc);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.25), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(loc.icon,
                      style: const TextStyle(fontSize: 26)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkGray,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      loc.floor,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.mediumGray,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedLocation = null),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    color: AppTheme.lightGray,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close,
                      size: 15, color: AppTheme.mediumGray),
                ),
              ),
            ]),
            const SizedBox(height: 12),
            Text(
              loc.description,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.mediumGray,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: loc.services
                  .map(
                    (s) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 6),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.09),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        s,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: color,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.directions, size: 16),
                  label: const Text('Ver ruta'),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.info_outline, size: 16),
                label: const Text('Info'),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  // ── Widgets auxiliares ─────────────────────────────────────────────
  Widget _statBadge(String value, String label) => Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppTheme.primaryBlue,
                letterSpacing: 0.3,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.accentBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );

  Widget _legendDot(String label, Color color) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.mediumGray,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
}
