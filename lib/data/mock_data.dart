import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/data/models/experience_model.dart';
import 'package:portfolio/data/models/project_model.dart';

final List<ProjectModel> productionProjects = [
  ProjectModel(
    title: "Gerenciador de Eventos",
    description:
        "Sistema criado primariamente para auxiliar na gestão de eventos da paróquia Santô Antônio do Orleans, mas que pode ser utilizado para a gestão de eventos de qualquer organização.",
    statusText: "WEB",
    colorBase: Colors.blue.shade700,
    techStack: [
      "Flutter Web",
      "Firebase"
    ], // TODO: Completar com o resto das tecnologias
    icon: Icons.business_center,
    link: "https://function-admin-panel.web.app/", // Updated to a real-looking link or keep existing
    repoLink: "https://github.com/seu-user/gerenciador",
    linkIcon: Icons.public,
    buttonText: "Acessar Sistema",
  ),
];

final List<ProjectModel> developmentProjects = [
  ProjectModel(
    title: "Simple Fit",
    description:
        "Aplicativo que visa faciliar o acompanhamento de treinos personalizados.",
    statusText: "BETA na Playstore",
    colorBase: Colors.green.shade600,
    techStack: ["Flutter", "Clean Arch", "Charts"],
    icon: Icons.eco,
    link: "https://play.google.com/store/apps/details?id=com.simplefit",
    repoLink: "https://github.com/seu-user/simple-fit",
    linkIcon: FontAwesomeIcons.googlePlay,
    buttonText: "Baixar App",
  ),
  ProjectModel(
    title: "Faz a Média",
    description:
        "Aplicativo que visa auxiliar o calculo do consumo médio de combustivel do veiculo. Possui funcionalidades como o compatilhamento de veículos entre usuários e o registro de abastecimentos.",
    statusText: "EM DESENVOLVIMENTO",
    colorBase: Colors.purple.shade600,
    techStack: ["Flutter", "Clean Arch", "Charts"],
    icon: Icons.school,
    link: null, // Sem link público ainda
    repoLink: "https://github.com/seu-user/faz-a-media",
    linkIcon: Icons.lock,
    buttonText: "Em Breve",
  ),
];

// EXPERIÊNCIA PROFISSIONAL
// Positivo Tecnologia
// Analista de Desenvolvimento — 03/2024 – Atualmente
// Estágio — 11/2023 – 03/2024
// • Desenvolvimento mobile em Flutter (Dart)
// • Desenvolvimento nativo Android/iOS (Kotlin e Swift)
// • Aplicação de Clean Architecture e Atomic Design
// • Metodologia Scrum
// • Integração com APIs REST
// • Noções básicas de AWS
// • Firebase
// Data Company Sistemas
// Desenvolvedor de Sistemas — 09/2022 – 11/2023
// • Desenvolvimento mobile com Flutter (Dart)
// • Desenvolvimento web com JavaScript/TypeScript (Node.js)
// • Testes unitários e de integração
// • Documentação técnica (Docusaurus)


const List<ExperienceModel> experiences = [
  ExperienceModel(
    title: "Analista de Desenvolvimento",
    organization: "Positivo Tecnologia",
    dateRange: "2024 - Atualmente",
    description:
        "Desenvolvimento mobile em Flutter (Dart)\nDesenvolvimento nativo Android/iOS (Kotlin e Swift)\nAplicação de Clean Architecture e Atomic Design\nMetodologia Scrum\nIntegração com APIs REST\nNoções básicas de AWS\nFirebase",
  ),
  ExperienceModel(
    title: "Estágio",
    organization: "Positivo Tecnologia",
    dateRange: "2023 - 2024",
    description:
        "Desenvolvimento mobile em Flutter (Dart)\nDesenvolvimento nativo Android/iOS (Kotlin e Swift)\nAplicação de Clean Architecture e Atomic Design\nMetodologia Scrum\nIntegração com APIs REST\nNoções básicas de AWS\nFirebase",
  ),
  ExperienceModel(
    title: "Desenvolvedor de Sistemas",
    organization: "Data Company Sistemas",
    dateRange: "2022 - 2023",
    description:
        "Desenvolvimento mobile com Flutter (Dart)\nDesenvolvimento web com JavaScript/TypeScript (Node.js)\nTestes unitários e de integração\nDocumentação técnica (Docusaurus)",
  ),
];

// FORMAÇÃO ACADÊMICA
// - Pós-graduação em Programação para Dispositivos Móveis UTFPR – Início previsto – 04/2026
// - Tecnólogo em Análise e desenvolvimento de Sistemas – PUCPR - Início – 01/2023 – Concluído – 09/2025
// - Bacharelado em Ciência da Computação – UDESC - Início – 06/2019 – Trancado em – 01/2023
// • Monitor da disciplina de algoritmos por 2 anos, Iniciação científica com foco em Aprendizado de Máquina

const List<ExperienceModel> academicBackground = [
  ExperienceModel(
    title: "Pós-graduação em Programação para Dispositivos Móveis",
    organization: "UTFPR",
    dateRange: "2026 - Presente",
    description:
        "Pós-graduação em Programação para Dispositivos Móveis UTFPR – Início previsto – 04/2026",
  ),
  ExperienceModel(
    title: "Tecnólogo em Análise e desenvolvimento de Sistemas",
    organization: "PUCPR",
    dateRange: "2023 - 2025",
    description:
        "Tecnólogo em Análise e desenvolvimento de Sistemas – PUCPR - Início – 01/2023 – Concluído – 09/2025",
  ),
  ExperienceModel(
    title: "Bacharelado em Ciência da Computação",
    organization: "UDESC",
    dateRange: "2017 - 2021",
    description:
        "Bacharelado em Ciência da Computação – UDESC - Início – 06/2019 – Trancado em – 01/2023",
  ),
];
