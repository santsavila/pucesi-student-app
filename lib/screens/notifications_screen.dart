import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/sample_data.dart';
import '../models/models.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<AppNotification> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = List.from(sampleNotifications);
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'urgente':
        return AppTheme.danger;
      case 'evento':
        return AppTheme.accentBlue;
      default:
        return AppTheme.mediumGray;
    }
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'urgente':
        return Icons.warning_amber_rounded;
      case 'evento':
        return Icons.event;
      default:
        return Icons.notifications_none;
    }
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return 'Hace ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Hace ${diff.inHours}h';
    return 'Hace ${diff.inDays} día${diff.inDays > 1 ? 's' : ''}';
  }

  @override
  Widget build(BuildContext context) {
    final unread = _notifications.where((n) => !n.isRead).length;
    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0.5,
        title: const Text('Notificaciones'),
        actions: [
          if (unread > 0)
            TextButton(
              onPressed: () => setState(() {
                for (var n in _notifications) {
                  n.isRead = true;
                }
              }),
              child: const Text('Marcar todo', style: TextStyle(color: AppTheme.primaryBlue, fontSize: 13)),
            ),
        ],
      ),
      body: Column(children: [
        if (unread > 0)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: AppTheme.danger.withOpacity(0.08),
            child: Row(children: [
              const Icon(Icons.circle, size: 8, color: AppTheme.danger),
              const SizedBox(width: 8),
              Text(
                '$unread notificación${unread > 1 ? 'es' : ''} sin leer',
                style: const TextStyle(fontSize: 13, color: AppTheme.danger, fontWeight: FontWeight.w600),
              ),
            ]),
          ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              final n = _notifications[i];
              final color = _typeColor(n.type);
              return Dismissible(
                key: Key(n.title + i.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(color: AppTheme.danger.withOpacity(0.08), borderRadius: BorderRadius.circular(16)),
                  child: const Icon(Icons.delete_outline, color: AppTheme.danger),
                ),
                onDismissed: (_) => setState(() => _notifications.removeAt(i)),
                child: GestureDetector(
                  onTap: () => setState(() => _notifications[i].isRead = true),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.lightGray),
                    ),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: color.withOpacity(0.14), shape: BoxShape.circle),
                        child: Icon(_typeIcon(n.type), color: color, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            Expanded(
                              child: Text(
                                n.title,
                                style: TextStyle(fontSize: 13, fontWeight: n.isRead ? FontWeight.w500 : FontWeight.w700, color: AppTheme.darkGray),
                              ),
                            ),
                            if (!n.isRead)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                              ),
                          ]),
                          const SizedBox(height: 6),
                          Text(n.body, style: const TextStyle(fontSize: 12, color: AppTheme.mediumGray, height: 1.4)),
                          const SizedBox(height: 10),
                          Text(_timeAgo(n.timestamp), style: TextStyle(fontSize: 11, color: AppTheme.mediumGray.withOpacity(0.75))),
                        ]),
                      ),
                    ]),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
