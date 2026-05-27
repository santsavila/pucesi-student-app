import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class ClassCard extends StatelessWidget {
  final ClassSchedule schedule;
  final bool showDay;
  const ClassCard({super.key, required this.schedule, this.showDay = true});

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(schedule.color));
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.lightGray, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(schedule.startTime, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
              Container(height: 20, width: 1, color: AppTheme.mediumGray.withOpacity(0.25), margin: const EdgeInsets.symmetric(vertical: 3)),
              Text(schedule.endTime, style: const TextStyle(fontSize: 11, color: AppTheme.mediumGray)),
            ]),
            const SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (showDay)
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: AppTheme.lightGray, borderRadius: BorderRadius.circular(8)),
                    child: Text(schedule.day, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.mediumGray)),
                  ),
                Text(schedule.subject, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.darkGray)),
                const SizedBox(height: 4),
                Text(schedule.teacher, style: const TextStyle(fontSize: 12, color: AppTheme.mediumGray)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: AppTheme.lightGray, borderRadius: BorderRadius.circular(10)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.room, size: 12, color: AppTheme.mediumGray),
                    const SizedBox(width: 6),
                    Text('${schedule.room} · ${schedule.building}', style: const TextStyle(fontSize: 11, color: AppTheme.mediumGray, fontWeight: FontWeight.w500)),
                  ]),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final UniversityEvent event;
  final bool expanded;
  const EventCard({super.key, required this.event, this.expanded = false});

  Color get _categoryColor {
    switch (event.category) {
      case 'Académico':
        return AppTheme.primaryBlue;
      case 'Taller':
        return const Color(0xFF7C3AED);
      case 'Conferencia':
        return AppTheme.accentBlue;
      case 'Deporte':
        return AppTheme.success;
      case 'Administrativo':
        return AppTheme.danger;
      default:
        return AppTheme.mediumGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _categoryColor;
    final months = ['', 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.lightGray, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 58,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
              child: Column(children: [
                Text('${event.date.day}', style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(months[event.date.month], style: TextStyle(color: color.withOpacity(0.8), fontSize: 11)),
              ]),
            ),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (event.isImportant)
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppTheme.gold.withOpacity(0.16), borderRadius: BorderRadius.circular(10)),
                  child: const Text('Importante', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF92400E))),
                ),
              Text(event.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.darkGray)),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.lightGray,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.lightGray),
              ),
              child: Text(event.category, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
            ),
          ]),
          if (expanded) ...[
            const SizedBox(height: 14),
            Text(event.description, style: const TextStyle(fontSize: 13, color: AppTheme.mediumGray, height: 1.6)),
          ],
          const SizedBox(height: 14),
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: AppTheme.lightGray, borderRadius: BorderRadius.circular(10)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.access_time, size: 12, color: AppTheme.mediumGray),
                const SizedBox(width: 6),
                Text(event.time, style: const TextStyle(fontSize: 11, color: AppTheme.mediumGray)),
              ]),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: AppTheme.lightGray, borderRadius: BorderRadius.circular(10)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.location_on, size: 12, color: color),
                  const SizedBox(width: 6),
                  Flexible(child: Text(event.location, style: TextStyle(fontSize: 11, color: color), overflow: TextOverflow.ellipsis)),
                ]),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}

class NotificationBadge extends StatelessWidget {
  final int count;
  const NotificationBadge({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      const Icon(Icons.notifications_outlined, color: AppTheme.white),
      if (count > 0)
        Positioned(
          right: -4,
          top: -4,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(color: AppTheme.gold, shape: BoxShape.circle),
            child: Text('$count', style: const TextStyle(color: AppTheme.white, fontSize: 9, fontWeight: FontWeight.w700)),
          ),
        ),
    ]);
  }
}
