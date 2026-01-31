import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String description;
  final String statusText;
  final Color colorBase;
  final List<String> techStack;
  final IconData icon; // Placeholder para imagem
  // final String imageAsset; // Use isto no futuro
  final String? link;
  final IconData? linkIcon;
  final String buttonText;

  ProjectModel({
    required this.title,
    required this.description,
    required this.statusText,
    required this.colorBase,
    required this.techStack,
    required this.icon,
    this.link,
    this.linkIcon,
    this.buttonText = "Ver Projeto",
  });
}
