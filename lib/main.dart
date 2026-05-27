import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/events_screen.dart';
import 'screens/map_screen.dart';
import 'screens/notifications_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
  runApp(const PucesiApp());
}

class PucesiApp extends StatelessWidget {
  const PucesiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PUCESI App',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ScheduleScreen(),
    EventsScreen(),
    MapScreen(),
    NotificationsScreen(),
  ];

  final List<({IconData icon, IconData activeIcon, String label})> _navItems = const [
    (icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Inicio'),
    (icon: Icons.schedule_outlined, activeIcon: Icons.schedule, label: 'Horario'),
    (icon: Icons.event_outlined, activeIcon: Icons.event, label: 'Eventos'),
    (icon: Icons.map_outlined, activeIcon: Icons.map, label: 'Campus'),
    (icon: Icons.notifications_outlined, activeIcon: Icons.notifications, label: 'Avisos'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          border: Border(top: BorderSide(color: AppTheme.lightGray, width: 1)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_navItems.length, (i) {
                final item = _navItems[i];
                final selected = i == _currentIndex;
                return GestureDetector(
                  onTap: () => setState(() => _currentIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(horizontal: selected ? 14 : 10, vertical: 9),
                    decoration: BoxDecoration(
                      color: selected ? AppTheme.primaryBlue.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          selected ? item.activeIcon : item.icon,
                          color: selected ? AppTheme.primaryBlue : AppTheme.mediumGray,
                          size: 20,
                        ),
                        if (selected) ...[
                          const SizedBox(width: 6),
                          Text(
                            item.label,
                            style: const TextStyle(
                              color: AppTheme.primaryBlue,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
