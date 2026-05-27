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
      backgroundColor: AppTheme.scaffoldBackground,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 280,
          pinned: true,
          backgroundColor: AppTheme.primaryBlue,
          foregroundColor: AppTheme.white,
          elevation: 0,
          automaticallyImplyLeading: false,
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
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppTheme.primaryBlue, AppTheme.accentBlue],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -30,
                    top: 12,
                    child: Opacity(
                      opacity: 0.08,
                      child: Image.asset('assets/images/PUCE-IBARRA-1.png', width: 300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('PUCE Ibarra', style: TextStyle(fontSize: 13, color: AppTheme.white, letterSpacing: 0.7, fontWeight: FontWeight.w600)),
                                  SizedBox(height: 6),
                                  Text('Centro académico formal', style: TextStyle(fontSize: 26, color: AppTheme.white, fontWeight: FontWeight.w800, height: 1.1)),
                                ],
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 18, offset: const Offset(0, 10))]),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset('assets/images/PUCE-IBARRA-1.png', fit: BoxFit.contain),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(color: AppTheme.surfaceBlue, borderRadius: BorderRadius.circular(14)),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, color: AppTheme.white, size: 16),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Hoy es $todayName · agenda y avisos listos para revisar',
                                  style: const TextStyle(color: AppTheme.white, fontSize: 13, height: 1.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text('Funciones rápidas', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildQuickItem(Icons.map, 'Mapa', AppTheme.primaryBlue),
                  _buildQuickItem(Icons.calendar_month, 'Agenda', AppTheme.accentBlue),
                  _buildQuickItem(Icons.schedule, 'Horario', AppTheme.darkGray),
                  _buildQuickItem(Icons.notifications_active, 'Avisos', AppTheme.danger),
                ],
              ),
              const SizedBox(height: 22),
              _sectionHeader('Enlaces oficiales', 'Acceso directo a la web', Icons.link),
              const SizedBox(height: 12),
              Column(
                children: officialLinks.map((link) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Material(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(18),
                      elevation: 1,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () => _openLink(context, link.url),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          child: Row(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(color: AppTheme.surfaceGray, borderRadius: BorderRadius.circular(14)),
                                child: Icon(Icons.open_in_new, color: AppTheme.primaryBlue, size: 20),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(link.label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.darkGray)),
                                    const SizedBox(height: 4),
                                    Text(link.subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.mediumGray, height: 1.4)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, color: AppTheme.mediumGray, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              _sectionHeader('Clases de hoy', todayName, Icons.schedule),
              const SizedBox(height: 12),
              if (todayClasses.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 18, offset: const Offset(0, 10))]),
                  child: const Column(children: [
                    Icon(Icons.free_breakfast, size: 32, color: AppTheme.mediumGray),
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
