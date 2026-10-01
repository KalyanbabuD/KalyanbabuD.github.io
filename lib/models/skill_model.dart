import 'package:flutter/material.dart';

class SkillCategory {
  final String title;
  final String description;
  final IconData icon;
  final List<String> skills;

  const SkillCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.skills,
  });
}
