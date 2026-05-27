# pucesi_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 📱 PUCESI Student App

Aplicación móvil prototipo para estudiantes de la **Pontificia Universidad Católica del Ecuador Sede Ibarra (PUCESI)**.

Desarrollada en **Flutter** — corre en Android, iOS y Web.

---

## ✨ Funcionalidades

| Pantalla | Descripción |
|---|---|
| 🏠 **Inicio** | Clases del día, próximos eventos y acceso rápido |
| 📅 **Horario** | Horario semanal con tabs por día (Lun–Vie) |
| 🎉 **Eventos** | Eventos universitarios filtrables por categoría |
| 🗺️ **Campus** | Mapa con aulas, cafetería, biblioteca y espacios recreativos |
| 🔔 **Notificaciones** | Avisos importantes sin necesidad de revisar el correo |

---

## 🚀 Cómo correr el proyecto

### Requisitos
- Flutter SDK ≥ 3.0.0
- Git
- Chrome (para correrlo en web)

### Pasos

**1. Clonar el repositorio**
```bash
git clone https://github.com/santsavila/pucesi-student-app.git
cd pucesi-student-app
```

**2. Instalar Flutter** (si no lo tienes)
```bash
# En Mac
brew install --cask flutter

# Verificar instalación
flutter doctor
```

**3. Instalar dependencias**
```bash
flutter pub get
```

**4. Correr la app**
```bash
# En Chrome (recomendado para el prototipo)
flutter run -d chrome

# En dispositivo Android conectado
flutter run -d android

# En simulador iOS (solo Mac con Xcode)
flutter run -d ios
```

---

## 📁 Estructura del proyecto

```
lib/
├── main.dart                    # Punto de entrada + navegación
├── theme/
│   └── app_theme.dart           # Colores PUCESI y tema global
├── models/
│   └── models.dart              # Modelos de datos
├── data/
│   └── sample_data.dart         # Datos de ejemplo
├── screens/
│   ├── home_screen.dart         # Pantalla de inicio
│   ├── schedule_screen.dart     # Horario semanal
│   ├── events_screen.dart       # Eventos universitarios
│   ├── map_screen.dart          # Mapa del campus
│   └── notifications_screen.dart# Notificaciones
└── widgets/
    └── event_card.dart          # Widgets reutilizables
```

---

## 🎨 Diseño

- Colores oficiales PUCESI: **Azul** `#003DA5` y **Dorado** `#F5A623`
- Material Design 3
- Navegación inferior animada

---

## 🤝 Contribuir

```bash
# Crear rama para tu funcionalidad
git checkout -b feature/nombre-de-la-funcionalidad

# Hacer cambios y subir
git add .
git commit -m "feat: descripción del cambio"
git push origin feature/nombre-de-la-funcionalidad
```

Luego abrir un **Pull Request** en GitHub.

---

## 🗺️ Próximas mejoras

- [ ] Mapa interactivo con OpenStreetMap
- [ ] Notificaciones push con Firebase
- [ ] Login con cuenta institucional PUCESI
- [ ] Integración con sistema académico real
- [ ] Modo sin conexión

---

## 👥 Equipo

Proyecto académico — PUCESI, Ibarra, Ecuador 🇪🇨