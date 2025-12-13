import 'package:flutter/material.dart';

/// Data model for skills
class Skill {
  final String name;
  final IconData? icon;

  const Skill({required this.name, this.icon});
}

/// Skill category grouping
class SkillCategory {
  final String name;
  final String description;
  final List<Skill> skills;
  final IconData icon;

  const SkillCategory({
    required this.name,
    required this.description,
    required this.skills,
    required this.icon,
  });
}

/// Skills data organized by category
const List<SkillCategory> skillsData = [
  SkillCategory(
    name: 'Core Technologies',
    description: 'Primary development stack',
    icon: Icons.code_rounded,
    skills: [
      Skill(name: 'Flutter'),
      Skill(name: 'Dart'),
      Skill(name: 'Material Design 3'),
      Skill(name: 'Custom Widgets'),
      Skill(name: 'Animations'),
    ],
  ),
  SkillCategory(
    name: 'State Management',
    description: 'Application state solutions',
    icon: Icons.hub_rounded,
    skills: [
      Skill(name: 'Provider'),
      Skill(name: 'Riverpod'),
      Skill(name: 'BLoC'),
      Skill(name: 'GetX'),
    ],
  ),
  SkillCategory(
    name: 'Backend & Database',
    description: 'Server-side integrations',
    icon: Icons.storage_rounded,
    skills: [
      Skill(name: 'Firebase'),
      Skill(name: 'Firestore'),
      Skill(name: 'REST APIs'),
      Skill(name: 'SQLite'),
      Skill(name: 'Hive'),
    ],
  ),
  SkillCategory(
    name: 'Architecture & Patterns',
    description: 'Code organization & best practices',
    icon: Icons.architecture_rounded,
    skills: [
      Skill(name: 'Clean Architecture'),
      Skill(name: 'MVVM'),
      Skill(name: 'Repository Pattern'),
      Skill(name: 'SOLID Principles'),
    ],
  ),
  SkillCategory(
    name: 'Testing & Quality',
    description: 'Code quality assurance',
    icon: Icons.verified_rounded,
    skills: [
      Skill(name: 'Unit Testing'),
      Skill(name: 'Widget Testing'),
      Skill(name: 'Integration Testing'),
    ],
  ),
  SkillCategory(
    name: 'Tools & Platforms',
    description: 'Development ecosystem',
    icon: Icons.build_rounded,
    skills: [
      Skill(name: 'Git'),
      Skill(name: 'GitHub'),
      Skill(name: 'VS Code'),
      Skill(name: 'Android Studio'),
      Skill(name: 'Figma'),
    ],
  ),
];
