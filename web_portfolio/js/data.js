const projectsData = [
    {
        title: 'E-Commerce Mobile App',
        description: 'A comprehensive Flutter E-commerce Application designed for scalability and real-time performance. Features a robust product catalog, secure user authentication (Firebase), and seamless shopping cart management.',
        fullDescription: `A comprehensive Flutter E-commerce Application designed for scalability and real-time performance. Features a robust product catalog, secure user authentication (Firebase), and seamless shopping cart management. Built using Provider state management to ensure fluid user interactions and optimized data flow across iOS and Android platforms.
                    
Key Features:
• Product catalog with categories and search
• Shopping cart with real-time updates
• User authentication and profile management
• Order tracking and history
• Push notifications for order updates`,
        technologies: ['Flutter', 'Dart', 'Firebase', 'Provider'],
        githubUrl: 'https://github.com/mel-adna/e-commerce-app',
        imageUrl: 'assets/apps_screenshots/e_commerce_app_screenshot.png',
        category: 'mobile',
    },
    {
        title: 'Task Management App',
        description: 'Clean and intuitive task management application with categories, priorities, and reminders.',
        fullDescription: `A productivity-focused task management app built with Flutter.

Key Features:
• Create, edit, and organize tasks
• Priority levels and due dates
• Category-based organization
• Local notifications for reminders
• Clean, minimal UI design`,
        technologies: ['Flutter', 'Dart', 'SQLite', 'BLoC'],
        githubUrl: 'https://github.com/mel-adna/task-manager-app',
        imageUrl: 'assets/apps_screenshots/task_manager_screenshot.png',
        category: 'mobile',
    },
    {
        title: 'Weather Application',
        description: 'A reliable, location-aware Weather Forecast App that delivers accurate, real-time meteorological data.',
        fullDescription: `A reliable, location-aware Weather Forecast App that delivers accurate, real-time meteorological data. Integrates with RESTful APIs to provide 7-day forecasts and current conditions. leveraging Riverpod for efficient state management and caching strategies to minimize API calls and enhance high-performance user experience.

Key Features:
• Current weather conditions
• 7-day weather forecast
• Location-based weather data
• Multiple city support
• Beautiful weather animations`,
        technologies: ['Flutter', 'Dart', 'REST API', 'Riverpod'],
        githubUrl: 'https://github.com/mel-adna/weather_app',
        imageUrl: 'assets/apps_screenshots/weather_app_screenshot.png',
        category: 'mobile',
    },
    {
        title: 'Chat Application',
        description: 'Real-time messaging app with Firebase backend, supporting text messages and media sharing.',
        fullDescription: `A feature-rich chat application with real-time messaging capabilities.

Key Features:
• Real-time messaging with Firebase
• User authentication
• One-on-one and group chats
• Media sharing (images)
• Message status indicators`,
        technologies: ['Flutter', 'Dart', 'Firebase', 'Firestore'],
        githubUrl: 'https://github.com/mel-adna/chat_app_2026',
        imageUrl: 'assets/apps_screenshots/chat_2026_screenshot.png',
        category: 'mobile',
    },
    {
        title: 'FatigueVision - Driver Safety System',
        description: 'Real-time mobile application designed to detect driver drowsiness and prevent accidents using computer vision and machine learning.',
        fullDescription: `FatigueVision is a real-time mobile application designed to detect driver drowsiness and prevent accidents using computer vision and machine learning.

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
• Output: Face landmarks for EAR calculation.`,
        technologies: ['Flutter', 'Dart', 'Riverpod', 'Google ML Kit', 'DDD', 'GoRouter'],
        githubUrl: 'https://github.com/mel-adna/FatigueVisionApp',
        imageUrl: 'assets/apps_screenshots/fatigue_vision_app.jpeg',
        category: 'mobile',
    },
    {
        title: 'Portfolio Website',
        description: 'This portfolio website built with Flutter Web, featuring responsive design and shadcn-inspired UI.',
        fullDescription: `A modern portfolio website showcasing Flutter Web capabilities.

Key Features:
• Responsive design (Mobile, Tablet, Desktop)
• Dark/Light mode support
• shadcn/ui-inspired components
• Smooth animations and transitions
• Contact form with validation`,
        technologies: ['Flutter Web', 'Dart', 'Responsive Design'],
        githubUrl: 'https://github.com/mel-adna/Portfolio_With_Flutter',
        demoUrl: 'https://mel-adna.github.io/',
        imageUrl: 'assets/apps_screenshots/web_site_screenshot.png',
        category: 'web',
    },
];

const experienceData = [
    {
        company: 'Freelance',
        role: 'Flutter Developer',
        duration: '2025 - Present',
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
    },
    {
        company: '1337 Coding School (42 Network)',
        role: 'Software Engineering Student',
        duration: '2023 - Present',
        location: 'Morocco',
        description: 'Part of the prestigious 42 Network. Intensive peer-to-peer curriculum focused on deep computer science fundamentals.',
        responsibilities: [
            'Solved complex algorithmic challenges in C and C++',
            'Collaborated in a peer-learning environment with strict code reviews',
            'Built custom graphical engines and shell implementations',
            'Developed strong problem-solving and self-learning capabilities',
            'Mastered memory management and data structures',
        ],
        technologies: ['C', 'C++', 'Algorithms', 'Git', 'Shell'],
    },
    {
        company: 'Self-Learning & Projects',
        role: 'Flutter Developer',
        duration: '2022 - 2025',
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
    },
];

const skillsData = [
    {
        name: 'Core Technologies',
        description: 'Primary development stack',
        icon: 'code',
        skills: ['Flutter', 'Dart', 'Material Design 3', 'Custom Widgets', 'Animations'],
    },
    {
        name: 'State Management',
        description: 'Application state solutions',
        icon: 'hub',
        skills: ['Provider', 'Riverpod', 'BLoC', 'GetX'],
    },
    {
        name: 'Backend & Database',
        description: 'Server-side integrations',
        icon: 'storage',
        skills: ['Firebase', 'Firestore', 'REST APIs', 'SQLite', 'Hive'],
    },
    {
        name: 'Architecture & Patterns',
        description: 'Code organization & best practices',
        icon: 'architecture',
        skills: ['Clean Architecture', 'MVVM', 'Repository Pattern', 'SOLID Principles'],
    },
    {
        name: 'Testing & Quality',
        description: 'Code quality assurance',
        icon: 'verified',
        skills: ['Unit Testing', 'Widget Testing', 'Integration Testing'],
    },
    {
        name: 'Tools & Platforms',
        description: 'Development ecosystem',
        icon: 'build',
        skills: ['Git', 'GitHub', 'VS Code', 'Android Studio', 'Figma'],
    },
];

const aboutData = {
    title: "Freelance Flutter Developer & Software Engineer",
    description: `I am a results-driven Freelance Flutter Developer based in Morocco, transforming complex ideas into scalable, high-performance mobile apps. With a background in C++ from 1337 School (42 Network), I bring an engineering mindset to every project—ensuring your app is not just beautiful, but robust and efficient.

Specializing in Cross-platform Development, I help startups and businesses build seamless iOS and Android solutions. Whether you need a brand-new app or performance optimization, I bring technical precision and creative flair to bring your vision to life.`,
    highlights: [
        { icon: 'location_on', label: 'Based in Morocco' },
        { icon: 'code', label: 'Flutter • Dart • Firebase' },
        { icon: 'work', label: 'Open to Work' },
    ],
    stats: [
        { value: 'Flutter', label: 'Primary Framework' },
        { value: 'Dart', label: 'Main Language' },
        { value: 'Firebase', label: 'Backend Service' },
        { value: 'Morocco', label: 'Location' },
    ]
};

const contactData = {
    header: "Let's work together",
    description: "I'm always interested in hearing about new projects and opportunities. Whether you have a question or just want to say hi, feel free to reach out!",
    email: 'mohamedeladnani0@gmail.com',
    location: 'Morocco',
    availability: 'Open to new opportunities',
    socials: [
        { platform: 'GitHub', url: 'https://github.com/mel-adna', icon: 'fab fa-github' },
        { platform: 'LinkedIn', url: 'https://www.linkedin.com/in/mel-adna/', icon: 'fab fa-linkedin' },
    ]
};
