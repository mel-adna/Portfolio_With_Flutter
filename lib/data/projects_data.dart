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
    description: 'A full-featured mobile commerce application with product catalog, cart, and checkout functionality.',
    fullDescription: '''Built a comprehensive e-commerce mobile application using Flutter and Firebase.

Key Features:
• Product catalog with categories and search
• Shopping cart with real-time updates
• User authentication and profile management
• Order tracking and history
• Push notifications for order updates''',
    technologies: ['Flutter', 'Dart', 'Firebase', 'Provider'],
    githubUrl: 'https://github.com/mel-adna',
    category: ProjectCategory.mobile,
  ),
  Project(
    title: 'Task Management App',
    description: 'Clean and intuitive task management application with categories, priorities, and reminders.',
    fullDescription: '''A productivity-focused task management app built with Flutter.

Key Features:
• Create, edit, and organize tasks
• Priority levels and due dates
• Category-based organization
• Local notifications for reminders
• Clean, minimal UI design''',
    technologies: ['Flutter', 'Dart', 'SQLite', 'BLoC'],
    githubUrl: 'https://github.com/mel-adna',
    category: ProjectCategory.mobile,
  ),
  Project(
    title: 'Weather Application',
    description: 'Beautiful weather app with current conditions, forecasts, and location-based data.',
    fullDescription: '''A modern weather application with elegant UI and accurate forecasts.

Key Features:
• Current weather conditions
• 7-day weather forecast
• Location-based weather data
• Multiple city support
• Beautiful weather animations''',
    technologies: ['Flutter', 'Dart', 'REST API', 'Riverpod'],
    githubUrl: 'https://github.com/mel-adna',
    category: ProjectCategory.mobile,
  ),
  Project(
    title: 'Chat Application',
    description: 'Real-time messaging app with Firebase backend, supporting text messages and media sharing.',
    fullDescription: '''A feature-rich chat application with real-time messaging capabilities.

Key Features:
• Real-time messaging with Firebase
• User authentication
• One-on-one and group chats
• Media sharing (images)
• Message status indicators''',
    technologies: ['Flutter', 'Dart', 'Firebase', 'Firestore'],
    githubUrl: 'https://github.com/mel-adna',
    category: ProjectCategory.mobile,
  ),
  Project(
    title: 'Portfolio Website',
    description: 'This portfolio website built with Flutter Web, featuring responsive design and shadcn-inspired UI.',
    fullDescription: '''A modern portfolio website showcasing Flutter Web capabilities.

Key Features:
• Responsive design (Mobile, Tablet, Desktop)
• Dark/Light mode support
• shadcn/ui-inspired components
• Smooth animations and transitions
• Contact form with validation''',
    technologies: ['Flutter Web', 'Dart', 'Responsive Design'],
    githubUrl: 'https://github.com/mel-adna/Portfolio_With_Flutter',
    demoUrl: 'https://mel-adna.github.io/Portfolio_With_Flutter',
    category: ProjectCategory.web,
  ),
];
