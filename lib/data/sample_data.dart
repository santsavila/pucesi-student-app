import '../models/models.dart';

final List<ClassSchedule> sampleSchedules = [
  const ClassSchedule(subject: 'Programación Móvil', teacher: 'Ing. Carlos Velásquez', room: 'Lab 301', building: 'Bloque C', startTime: '07:00', endTime: '09:00', day: 'Lunes', career: 'Ingeniería en Sistemas', color: '0xFF003DA5'),
  const ClassSchedule(subject: 'Bases de Datos II', teacher: 'Ing. María Ponce', room: 'Aula 204', building: 'Bloque A', startTime: '09:00', endTime: '11:00', day: 'Lunes', career: 'Ingeniería en Sistemas', color: '0xFF0057D8'),
  const ClassSchedule(subject: 'Cálculo Diferencial', teacher: 'Msc. Roberto Terán', room: 'Aula 105', building: 'Bloque B', startTime: '11:00', endTime: '13:00', day: 'Martes', career: 'Ingeniería en Sistemas', color: '0xFF7C3AED'),
  const ClassSchedule(subject: 'Inglés Técnico III', teacher: 'Lic. Sandra Morales', room: 'Aula 308', building: 'Bloque D', startTime: '14:00', endTime: '16:00', day: 'Martes', career: 'Ingeniería en Sistemas', color: '0xFF059669'),
  const ClassSchedule(subject: 'Ingeniería de Software', teacher: 'Ing. Patricio Suárez', room: 'Lab 302', building: 'Bloque C', startTime: '07:00', endTime: '09:00', day: 'Miércoles', career: 'Ingeniería en Sistemas', color: '0xFFD97706'),
  const ClassSchedule(subject: 'Redes de Computadoras', teacher: 'Ing. Luis Chamorro', room: 'Lab 201', building: 'Bloque C', startTime: '09:00', endTime: '11:00', day: 'Jueves', career: 'Ingeniería en Sistemas', color: '0xFFDC2626'),
  const ClassSchedule(subject: 'Ética Profesional', teacher: 'PhD. Ana Rosero', room: 'Aula 110', building: 'Bloque A', startTime: '11:00', endTime: '13:00', day: 'Viernes', career: 'Ingeniería en Sistemas', color: '0xFF0891B2'),
];

final List<UniversityEvent> sampleEvents = [
  UniversityEvent(title: 'Semana de Ingeniería 2025', description: 'Feria tecnológica con exposición de proyectos estudiantiles, talleres de innovación y conferencias de empresas de tecnología del Ecuador.', date: DateTime(2025, 6, 10), time: '08:00 - 18:00', location: 'Auditorio Central PUCESI', category: 'Académico', isImportant: true),
  UniversityEvent(title: 'Matrícula Período Académico 2025-2', description: 'Proceso de matrícula para el segundo período académico 2025. Revisar requisitos en secretaría.', date: DateTime(2025, 6, 15), time: '08:00 - 16:00', location: 'Secretaría General', category: 'Administrativo', isImportant: true),
  UniversityEvent(title: 'Taller: Desarrollo con Flutter', description: 'Taller práctico sobre desarrollo de aplicaciones móviles multiplataforma con Flutter y Dart. Cupos limitados.', date: DateTime(2025, 6, 18), time: '14:00 - 17:00', location: 'Lab 301 - Bloque C', category: 'Taller', isImportant: false),
  UniversityEvent(title: 'Campeonato Interfacultades de Fútbol', description: 'Inicia el campeonato interfacultades. Inscribe tu equipo hasta el 12 de junio en Bienestar Estudiantil.', date: DateTime(2025, 6, 20), time: '15:00', location: 'Canchas Deportivas PUCESI', category: 'Deporte', isImportant: false),
  UniversityEvent(title: 'Conferencia: IA en la Industria', description: 'Charla magistral con expertos en Inteligencia Artificial y su impacto en la industria ecuatoriana.', date: DateTime(2025, 6, 25), time: '10:00 - 12:00', location: 'Auditorio Principal', category: 'Conferencia', isImportant: true),
  UniversityEvent(title: 'Exámenes Finales', description: 'Período de exámenes finales del primer semestre 2025. Consultar calendario en el sistema académico.', date: DateTime(2025, 7, 1), time: 'Según horario asignado', location: 'Aulas asignadas', category: 'Académico', isImportant: true),
];

final List<CampusLocation> campusLocations = [
  const CampusLocation(name: 'Bloque A - Aulas', description: 'Aulas de Administración, Derecho y Ciencias Humanas', category: 'aula', lat: 0.3517, lng: -78.1226, floor: 'Planta baja, 1° y 2° piso', icon: '🏫', services: ['Aulas de clase', 'Sala de profesores', 'Baños']),
  const CampusLocation(name: 'Bloque B - Aulas', description: 'Aulas de Ingeniería Civil y Arquitectura', category: 'aula', lat: 0.3519, lng: -78.1224, floor: 'Planta baja y 1° piso', icon: '🏫', services: ['Aulas de clase', 'Sala de dibujo técnico']),
  const CampusLocation(name: 'Bloque C - Laboratorios', description: 'Laboratorios de Computación e Ingeniería en Sistemas', category: 'aula', lat: 0.3521, lng: -78.1222, floor: '1°, 2° y 3° piso', icon: '💻', services: ['Lab. de programación', 'Lab. de redes', 'Lab. de electrónica']),
  const CampusLocation(name: 'Biblioteca Central', description: 'Biblioteca universitaria con recursos físicos y digitales', category: 'biblioteca', lat: 0.3515, lng: -78.1228, floor: 'Planta baja y 1° piso', icon: '📚', services: ['Préstamo de libros', 'Sala de estudio', 'Acceso a bases de datos', 'Impresión']),
  const CampusLocation(name: 'Cafetería Principal', description: 'Servicio de alimentación principal del campus', category: 'cafeteria', lat: 0.3513, lng: -78.1225, floor: 'Planta baja', icon: '🍽️', services: ['Desayuno 07:00-09:00', 'Almuerzo 12:00-14:00', 'Menú del día']),
  const CampusLocation(name: 'Canchas Deportivas', description: 'Canchas de fútbol, básquet y vóley', category: 'recreativo', lat: 0.3510, lng: -78.1220, floor: 'Planta baja (exterior)', icon: '⚽', services: ['Cancha de fútbol', 'Cancha de básquet', 'Cancha de vóley']),
  const CampusLocation(name: 'Auditorio Central', description: 'Auditorio para eventos académicos y culturales', category: 'recreativo', lat: 0.3516, lng: -78.1230, floor: 'Planta baja', icon: '🎭', services: ['Capacidad 300 personas', 'Equipo audiovisual']),
  const CampusLocation(name: 'Secretaría General', description: 'Trámites académicos y administrativos', category: 'admin', lat: 0.3514, lng: -78.1227, floor: 'Planta baja - Edificio principal', icon: '🏛️', services: ['Certificados', 'Matrículas', 'Horarios', 'Atención: 08:00-16:00']),
  const CampusLocation(name: 'Bienestar Estudiantil', description: 'Apoyo psicológico, médico y servicios al estudiante', category: 'admin', lat: 0.3512, lng: -78.1229, floor: '1° piso - Edificio principal', icon: '❤️', services: ['Atención médica', 'Psicología', 'Becas']),
  const CampusLocation(name: 'Parqueadero', description: 'Estacionamiento para estudiantes y docentes', category: 'recreativo', lat: 0.3508, lng: -78.1223, floor: 'Exterior', icon: '🚗', services: ['Parqueadero gratuito', 'Seguridad 24h']),
];

final List<OfficialLink> officialLinks = [
  const OfficialLink(
    label: 'Sitio oficial PUCESI',
    url: 'https://www.pucesi.edu.ec/',
    subtitle: 'Página principal de PUCESI',
  ),
  const OfficialLink(
    label: 'Noticias',
    url: 'https://www.pucesi.edu.ec/web/noticias',
    subtitle: 'Últimas noticias y avisos institucionales',
  ),
  const OfficialLink(
    label: 'Grados y posgrados',
    url: 'https://www.pucesi.edu.ec/webs2/index.php/grados/',
    subtitle: 'Carreras de grado y posgrado',
  ),
  const OfficialLink(
    label: 'Campus virtual',
    url: 'https://www.pucei.edu.ec:441/DirectorioAplicaciones/',
    subtitle: 'Acceso a aplicaciones internas',
  ),
];

final List<AppNotification> sampleNotifications = [
  AppNotification(title: '⚠️ Matrícula cierra en 3 días', body: 'Recuerda que el proceso de matrícula para el período 2025-2 cierra el 15 de junio. No pierdas tu cupo.', timestamp: DateTime.now().subtract(const Duration(hours: 2)), type: 'urgente', isRead: false),
  AppNotification(title: 'Nuevo evento: Semana de Ingeniería', body: 'Se ha publicado el programa de la Semana de Ingeniería 2025. Revisa los talleres disponibles.', timestamp: DateTime.now().subtract(const Duration(hours: 5)), type: 'evento', isRead: false),
  AppNotification(title: 'Cambio de aula', body: 'La clase de Programación Móvil del miércoles se traslada al Lab 202 por mantenimiento del Lab 301.', timestamp: DateTime.now().subtract(const Duration(days: 1)), type: 'aviso', isRead: true),
  AppNotification(title: 'Biblioteca - Libros disponibles', body: 'Los libros que solicitaste ya están disponibles para retirar. Tienes 48h para recogerlos.', timestamp: DateTime.now().subtract(const Duration(days: 2)), type: 'aviso', isRead: true),
];
