/// Data model for work experience
class Experience {
  final String company;
  final String role;
  final String duration;
  final String location;
  final String description;
  final List<String> responsibilities;
  final List<String> technologies;

  const Experience({
    required this.company,
    required this.role,
    required this.duration,
    required this.location,
    required this.description,
    required this.responsibilities,
    required this.technologies,
  });
}

/// Experience data - Update with your real experience
const List<Experience> experienceData = [
  Experience(
    company: 'Freelance',
    role: 'Flutter Developer',
    duration: '2023 - Present',
    location: 'Morocco',
    description: 'Building mobile applications for clients using Flutter and Firebase.',
    responsibilities: [
      'Developing cross-platform mobile applications with Flutter',
      'Integrating Firebase services (Auth, Firestore, Storage)',
      'Implementing clean architecture and best practices',
      'Collaborating with clients to understand requirements',
      'Delivering production-ready applications',
    ],
    technologies: ['Flutter', 'Dart', 'Firebase', 'REST API'],
  ),
  Experience(
    company: 'Self-Learning & Projects',
    role: 'Flutter Developer',
    duration: '2022 - 2023',
    location: 'Morocco',
    description: 'Intensive learning and building personal projects to master Flutter development.',
    responsibilities: [
      'Completed multiple Flutter courses and certifications',
      'Built various personal projects to practice skills',
      'Learned state management patterns (Provider, BLoC, Riverpod)',
      'Studied clean architecture and design patterns',
      'Contributed to open-source Flutter projects',
    ],
    technologies: ['Flutter', 'Dart', 'Firebase', 'SQLite'],
  ),
];
