import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/sample_data.dart';
import '../widgets/event_card.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'];

  @override
  void initState() {
    super.initState();
    final today = DateTime.now().weekday;
    final initialIndex = (today >= 1 && today <= 5) ? today - 1 : 0;
    _tabController = TabController(length: 5, vsync: this, initialIndex: initialIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        title: const Text('Mi Horario'),
        elevation: 0.5,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryBlue,
          unselectedLabelColor: AppTheme.mediumGray,
          indicatorColor: AppTheme.primaryBlue,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.w700),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          tabs: _days.map((d) => Tab(text: d.substring(0, d == 'Miércoles' ? 4 : 3))).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _days.map((day) {
          final classes = sampleSchedules.where((c) => c.day == day).toList()
            ..sort((a, b) => a.startTime.compareTo(b.startTime));
          if (classes.isEmpty) {
            return Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.free_breakfast_outlined, size: 64, color: AppTheme.mediumGray.withOpacity(0.5)),
                const SizedBox(height: 16),
                const Text('Sin clases este día', style: TextStyle(fontSize: 16, color: AppTheme.mediumGray)),
              ]),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: classes.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ClassCard(schedule: classes[i], showDay: false),
            ),
          );
        }).toList(),
      ),
    );
  }
}
