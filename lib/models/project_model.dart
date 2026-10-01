import 'package:flutter/material.dart';

class ProjectModel {
  final String id;
  final String title;
  final String category;
  final String organization; // 'SATRA Services' or 'My Own Project'
  final String subtitle;
  final String description;
  final String problemSolved;
  final String architecture;
  final List<String> keyFeatures;
  final List<String> technologies;
  final String impact;
  final IconData icon;
  final String? githubUrl;
  final String? liveUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final bool isPersonal;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.category,
    required this.organization,
    required this.subtitle,
    required this.description,
    required this.problemSolved,
    required this.architecture,
    required this.keyFeatures,
    required this.technologies,
    required this.impact,
    required this.icon,
    this.githubUrl,
    this.liveUrl,
    this.playStoreUrl,
    this.appStoreUrl,
    this.isPersonal = false,
  });

  bool get isSatra => !isPersonal;
  bool get isOwn => isPersonal;
}
