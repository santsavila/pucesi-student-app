class ClassSchedule {
  final String subject;
  final String teacher;
  final String room;
  final String building;
  final String startTime;
  final String endTime;
  final String day;
  final String career;
  final String color;

  const ClassSchedule({
    required this.subject,
    required this.teacher,
    required this.room,
    required this.building,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.career,
    required this.color,
  });
}

class UniversityEvent {
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String location;
  final String category;
  final bool isImportant;

  const UniversityEvent({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    this.isImportant = false,
  });
}

class CampusLocation {
  final String name;
  final String description;
  final String category;
  final double lat;
  final double lng;
  final String floor;
  final String icon;
  final List<String> services;

  const CampusLocation({
    required this.name,
    required this.description,
    required this.category,
    required this.lat,
    required this.lng,
    required this.floor,
    required this.icon,
    this.services = const [],
  });
}

class OfficialLink {
  final String label;
  final String url;
  final String subtitle;

  const OfficialLink({
    required this.label,
    required this.url,
    required this.subtitle,
  });
}

class AppNotification {
  final String title;
  final String body;
  final DateTime timestamp;
  final String type;
  bool isRead;

  AppNotification({
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });
}
