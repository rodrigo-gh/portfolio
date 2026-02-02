import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String description;
  final String statusText;
  final Color colorBase;
  final List<String> techStack;
  final IconData icon; // Placeholder para imagem
  // final String imageAsset; // Use isto no futuro
  final String? imageUrl;
  final List<String> galleryAssets;
  final String? details;
  final String? link;
  final String? repoLink;
  final IconData? linkIcon;
  final String buttonText;

  ProjectModel({
    required this.title,
    required this.description,
    required this.statusText,
    required this.colorBase,
    required this.techStack,
    required this.icon,
    this.imageUrl,
    this.galleryAssets = const [],
    this.details,
    this.link,
    this.repoLink,
    this.linkIcon,
    this.buttonText = "Ver Projeto",
  });
}
