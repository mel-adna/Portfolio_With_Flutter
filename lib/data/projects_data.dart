/// Data model for projects
class Project {
  final String title;
  final String description;
  final String? fullDescription;
  final List<String> technologies;
  final String? githubUrl;
  final String? demoUrl;
  final String? imageUrl;
  final ProjectCategory category;

  const Project({
    required this.title,
    required this.description,
    this.fullDescription,
    required this.technologies,
    this.githubUrl,
    this.demoUrl,
    this.imageUrl,
    this.category = ProjectCategory.mobile,
  });
}

/// Project category for filtering
enum ProjectCategory { mobile, web, package }

/// Sample projects data - Update with your real projects
const List<Project> projectsData = [
  Project(
    title: 'E-Commerce Mobile App',
    description:
        'A full-featured mobile commerce application with product catalog, cart, and checkout functionality.',
    fullDescription:
        '''Built a comprehensive e-commerce mobile application using Flutter and Firebase.

Key Features:
• Product catalog with categories and search
• Shopping cart with real-time updates
• User authentication and profile management
• Order tracking and history
• Push notifications for order updates''',
    technologies: ['Flutter', 'Dart', 'Firebase', 'Provider'],
    githubUrl: 'https://github.com/mel-adna/e-commerce-app',
    imageUrl: 'assets/apps_screenshots/e_commerce_app_screenshot.png',
    category: ProjectCategory.mobile,
  ),
  Project(
    title: 'Task Management App',
    description:
        'Clean and intuitive task management application with categories, priorities, and reminders.',
    fullDescription:
        '''A productivity-focused task management app built with Flutter.

Key Features:
• Create, edit, and organize tasks
• Priority levels and due dates
• Category-based organization
• Local notifications for reminders
• Clean, minimal UI design''',
    technologies: ['Flutter', 'Dart', 'SQLite', 'BLoC'],
    githubUrl: 'https://github.com/mel-adna/task-manager-app',
    imageUrl: 'assets/apps_screenshots/task_manager_screenshot.png',
    category: ProjectCategory.mobile,
  ),
  Project(
    title: 'Weather Application',
    description:
        'Beautiful weather app with current conditions, forecasts, and location-based data.',
    fullDescription:
        '''A modern weather application with elegant UI and accurate forecasts.

Key Features:
• Current weather conditions
• 7-day weather forecast
• Location-based weather data
• Multiple city support
• Beautiful weather animations''',
    technologies: ['Flutter', 'Dart', 'REST API', 'Riverpod'],
    githubUrl: 'https://github.com/mel-adna/weather_app',
    imageUrl: 'assets/apps_screenshots/weather_app_screenshot.png',
    category: ProjectCategory.mobile,
  ),
  Project(
    title: 'Chat Application',
    description:
        'Real-time messaging app with Firebase backend, supporting text messages and media sharing.',
    fullDescription:
        '''A feature-rich chat application with real-time messaging capabilities.

Key Features:
• Real-time messaging with Firebase
• User authentication
• One-on-one and group chats
• Media sharing (images)
• Message status indicators''',
    technologies: ['Flutter', 'Dart', 'Firebase', 'Firestore'],
    githubUrl: 'https://github.com/mel-adna/chat_app_2026',
    imageUrl: 'assets/apps_screenshots/chat_2026_screenshot.png',
    category: ProjectCategory.mobile,
  ),
  Project(
    title: 'FatigueVision - Driver Safety System',
    description:
        'Real-time mobile application designed to detect driver drowsiness and prevent accidents using computer vision and machine learning.',
    fullDescription:
        '''FatigueVision is a real-time mobile application designed to detect driver drowsiness and prevent accidents using computer vision and machine learning.

🛠️ Technology Stack
This project is built using Flutter and leverages several powerful libraries to ensure performance and reliability:
• Framework: Flutter (SDK ^3.10.1)
• State Management: Riverpod
• Computer Vision: Google ML Kit
• Architecture: Domain-Driven Design (DDD)

🧠 How It Works (The Logic)
The core functionality revolves around the Eye Aspect Ratio (EAR), a scalar value that indicates the openness of the eye.

1. Face Detection & Landmark Extraction: The app uses Google ML Kit to detect faces and extract landmarks.
2. EAR Calculation: Calculates the ratio of distances between eyelid points to detect blinking/drowsiness.
3. Smoothing & Thresholds: Uses rolling average to prevent false positives.
4. Alert System: Triggers audio, haptic, and visual alerts when drowsiness is detected.

🤖 Interaction with Mobile Learning (On-Device ML)
• Input: Raw camera feed.
• Inference: ML Kit Face Detection runs on-device.
• Output: Face landmarks for EAR calculation.
    ''',
    technologies: [
      'Flutter',
      'Dart',
      'Riverpod',
      'Google ML Kit',
      'DDD',
      'GoRouter',
    ],
    githubUrl: 'https://github.com/mel-adna/FatigueVisionApp',
    imageUrl: 'assets/apps_screenshots/fatigue_vision_app.jpeg',
    category: ProjectCategory.mobile,
  ),
  Project(
    title: 'Portfolio Website',
    description:
        'This portfolio website built with Flutter Web, featuring responsive design and shadcn-inspired UI.',
    fullDescription:
        '''A modern portfolio website showcasing Flutter Web capabilities.

Key Features:
• Responsive design (Mobile, Tablet, Desktop)
• Dark/Light mode support
• shadcn/ui-inspired components
• Smooth animations and transitions
• Contact form with validation''',
    technologies: ['Flutter Web', 'Dart', 'Responsive Design'],
    githubUrl: 'https://github.com/mel-adna/Portfolio_With_Flutter',
    demoUrl: 'https://mel-adna.github.io/',
    imageUrl: 'assets/apps_screenshots/web_site_screenshot.png',
    category: ProjectCategory.web,
  ),
];
