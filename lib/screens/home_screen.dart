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

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = ['', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
    final todayName = days[now.weekday];
    final todayClasses = sampleSchedules.where((c) => c.day == todayName).toList();
    final unreadCount = sampleNotifications.where((n) => !n.isRead).length;
    final upcomingEvents = sampleEvents.where((e) => e.date.isAfter(now)).take(3).toList();

    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 240,
          pinned: true,
          backgroundColor: AppTheme.white,
          foregroundColor: AppTheme.darkGray,
          elevation: 0.5,
          actions: [
            Stack(clipBehavior: Clip.none, children: [
              IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
              if (unreadCount > 0)
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(color: AppTheme.danger, shape: BoxShape.circle),
                    child: Center(
                      child: Text('$unreadCount', style: const TextStyle(color: AppTheme.white, fontSize: 10, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
            ]),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppTheme.white, AppTheme.lightBlue],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -10,
                    top: 16,
                    child: Opacity(
                      opacity: 0.08,
                      child: Image.asset('assets/images/PUCE-IBARRA-1.png', width: 260),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 72, 20, 16),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                      Row(children: [
                        Image.asset('assets/images/PUCE-IBARRA-1.png', width: 120),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                          Text('Institucional PUCE Ibarra', style: TextStyle(fontSize: 13, color: AppTheme.primaryBlue, fontWeight: FontWeight.w700)),
                          SizedBox(height: 4),
                          Text('Información académica y acceso rápido', style: TextStyle(fontSize: 11, color: AppTheme.mediumGray)),
                        ])),
                      ]),
                      const SizedBox(height: 18),
                      const Text('Resumen académico de hoy', style: TextStyle(fontSize: 14, color: AppTheme.mediumGray, letterSpacing: 0.2)),
                      const SizedBox(height: 6),
                      Text('Hoy es $todayName', style: const TextStyle(fontSize: 18, color: AppTheme.darkGray, fontWeight: FontWeight.w700)),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                _buildQuickItem(Icons.map, 'Mapa', AppTheme.primaryBlue),
                const SizedBox(width: 8),
                _buildQuickItem(Icons.calendar_month, 'Agenda', AppTheme.accentBlue),
                const SizedBox(width: 8),
                _buildQuickItem(Icons.schedule, 'Horario', AppTheme.mediumGray),
                const SizedBox(width: 8),
                _buildQuickItem(Icons.notifications_active, 'Avisos', AppTheme.danger),
              ]),
              const SizedBox(height: 22),
              _sectionHeader('Enlaces oficiales', 'PUCESI web', Icons.link),
              const SizedBox(height: 12),
              Column(
                children: officialLinks.map((link) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _openLink(context, link.url),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppTheme.lightGray),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.open_in_new, color: AppTheme.primaryBlue, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(link.label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.darkGray)),
                                const SizedBox(height: 4),
                                Text(link.subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.mediumGray)),
                              ]),
                            ),
                            const Icon(Icons.chevron_right, color: AppTheme.mediumGray),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),
              _sectionHeader('Clases de hoy', todayName, Icons.schedule),
              const SizedBox(height: 12),
              if (todayClasses.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.lightGray)),
                  child: const Column(children: [
                    Icon(Icons.free_breakfast, size: 34, color: AppTheme.mediumGray),
                    SizedBox(height: 10),
                    Text('No tienes clases hoy.', style: TextStyle(color: AppTheme.mediumGray, fontSize: 14)),
                  ]),
                )
              else
                ...todayClasses.map((c) => Padding(padding: const EdgeInsets.only(bottom: 12), child: ClassCard(schedule: c))),
              const SizedBox(height: 24),
              _sectionHeader('Próximos eventos', 'Esta semana', Icons.event),
              const SizedBox(height: 12),
              ...upcomingEvents.map((e) => Padding(padding: const EdgeInsets.only(bottom: 12), child: EventCard(event: e))),
              const SizedBox(height: 70),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _buildQuickItem(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.lightGray),
        ),
        child: Column(children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.darkGray)),
        ]),
      ),
    );
  }

  Widget _sectionHeader(String title, String subtitle, IconData icon) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: AppTheme.lightBlue, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: AppTheme.primaryBlue, size: 18),
      ),
      const SizedBox(width: 12),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.darkGray)),
        const SizedBox(height: 2),
        Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.mediumGray)),
      ]),
    ]);
  }
}
