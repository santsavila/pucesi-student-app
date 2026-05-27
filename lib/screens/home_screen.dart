import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../data/sample_data.dart';
import '../widgets/event_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _openLink(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final messenger = ScaffoldMessenger.of(context);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace.')),
      );
    }
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Buenos días';
    if (hour < 19) return 'Buenas tardes';
    return 'Buenas noches';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = ['', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
    final todayName = days[now.weekday];
    final todayClasses = sampleSchedules.where((c) => c.day == todayName).toList();
    final unreadCount = sampleNotifications.where((n) => !n.isRead).length;
    final upcomingEvents = sampleEvents.where((e) => e.date.isAfter(now)).take(3).toList();

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      body: CustomScrollView(slivers: [

        // ── Hero Header ─────────────────────────────────────────────
        SliverAppBar(
          expandedHeight: 260,
          pinned: true,
          backgroundColor: AppTheme.primaryBlue,
          foregroundColor: AppTheme.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 6, top: 4),
              child: Stack(clipBehavior: Clip.none, children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, size: 28),
                  onPressed: () {},
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: AppTheme.danger,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$unreadCount',
                          style: const TextStyle(
                            color: AppTheme.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
              ]),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF152E58), AppTheme.accentBlue],
                ),
              ),
              child: Stack(children: [
                // Círculo decorativo derecho
                Positioned(
                  right: -50,
                  top: -20,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.white.withOpacity(0.07),
                    ),
                  ),
                ),
                // Círculo decorativo izquierdo
                Positioned(
                  left: -30,
                  bottom: -30,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.white.withOpacity(0.05),
                    ),
                  ),
                ),
                // Contenido del header
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 42, 22, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Saludo temporal
                      Row(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppTheme.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _greeting(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 10),
                      // Título principal
                      const Text(
                        'Bienvenido a PUCESI',
                        style: TextStyle(
                          fontSize: 30,
                          color: AppTheme.white,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'PUCESI, tu campus digital para clases, eventos y avisos oficiales.',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppTheme.white,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Chip de agenda del día
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.white.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: AppTheme.white.withOpacity(0.2)),
                        ),
                        child: Row(children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: AppTheme.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.today,
                                color: AppTheme.white, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '$todayName · ${todayClasses.isEmpty ? 'Sin clases hoy' : '${todayClasses.length} clase${todayClasses.length > 1 ? 's' : ''}'}',
                              style: const TextStyle(
                                color: AppTheme.white,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),

        // ── Contenido principal ──────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── Accesos directos ─────────────────────────────────
                _sectionHeader('Accesos directos', 'Navega rápido por PUCESI', Icons.grid_view_rounded),
                const SizedBox(height: 14),
                Row(children: [
                  Expanded(child: _quickItem(Icons.map_outlined, 'Mapa del campus', AppTheme.primaryBlue)),
                  const SizedBox(width: 12),
                  Expanded(child: _quickItem(Icons.schedule_outlined, 'Mi horario', AppTheme.accentBlue)),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: _quickItem(Icons.event_outlined, 'Eventos', AppTheme.success)),
                  const SizedBox(width: 12),
                  Expanded(child: _quickItem(Icons.notifications_active_outlined, 'Avisos', AppTheme.danger)),
                ]),

                const SizedBox(height: 28),

                // ── Clases de hoy ──────────────────────────────────
                _sectionHeader('Clases de hoy', todayName, Icons.schedule_rounded),
                const SizedBox(height: 12),
                if (todayClasses.isEmpty)
                  _emptyCard(
                    Icons.free_breakfast_outlined,
                    'Sin clases hoy',
                    'Disfruta tu día libre.',
                  )
                else
                  ...todayClasses.map((c) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ClassCard(schedule: c),
                      )),

                const SizedBox(height: 28),

                // ── Próximos eventos ───────────────────────────────
                _sectionHeader('Próximos eventos', 'Lo más relevante', Icons.event_rounded),
                const SizedBox(height: 12),
                ...upcomingEvents.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: EventCard(event: e),
                    )),

                const SizedBox(height: 28),

                // ── Enlaces oficiales ──────────────────────────────
                _sectionHeader('Enlaces oficiales', 'PUCESI en la web', Icons.open_in_new_rounded),
                const SizedBox(height: 12),
                ...officialLinks.map((link) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => _openLink(context, link.url),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            child: Row(children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceBlue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.open_in_new,
                                    color: AppTheme.primaryBlue, size: 20),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      link.label,
                                      style: const TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.darkGray,
                                        letterSpacing: 0.15,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      link.subtitle,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.mediumGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  color: AppTheme.mediumGray, size: 14),
                            ]),
                          ),
                        ),
                      ),
                    )),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  // ── Widgets auxiliares ─────────────────────────────────────────────

  Widget _quickItem(IconData icon, String label, Color color) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppTheme.darkGray,
            letterSpacing: 0.3,
          ),
        ),
      ]),
    );
  }

  Widget _sectionHeader(String title, String? subtitle, IconData icon) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: AppTheme.surfaceBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppTheme.primaryBlue, size: 17),
      ),
      const SizedBox(width: 12),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppTheme.darkGray,
            letterSpacing: 0.3,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 1),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.mediumGray,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ]),
    ]);
  }

  Widget _emptyCard(IconData icon, String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.surfaceGray,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 28, color: AppTheme.mediumGray),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: AppTheme.darkGray,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12.5,
            color: AppTheme.mediumGray,
          ),
        ),
      ]),
    );
  }
}
