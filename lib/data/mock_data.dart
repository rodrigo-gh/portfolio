import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/data/models/experience_model.dart';
import 'package:portfolio/data/models/project_model.dart';

final List<ProjectModel> productionProjects = [
  ProjectModel(
    title: "Gerenciador de Eventos Organizacional",
    description:
        "Sistema centralizado para gestão e escalas de eventos, focado em produtividade e consistência visual.",
    details: """
RESUMO DO PROJETO
Aplicativo multi-plataforma desenvolvido para centralizar a criação e o gerenciamento de eventos corporativos e organizacionais. O foco principal é a eficiência operacional na entrada de dados e a excelência na experiência do usuário, utilizando um design system proprietário baseado em Material 3.

CORE STACK
• Frontend: Flutter / Dart
• Gerenciamento de Estado: Riverpod
• Backend: Firebase (Auth & Firestore)

FUNCIONALIDADES IMPLEMENTADAS
• Criação de Eventos em Lote: Fluxo com Stepper para replicar dados comuns.
• Sistema de Convites: Detecção automática de convites e vinculação de organizações (RBAC).
• Validação de Conflitos: Alerta de choques de horário.
• Interface Premium: Layout adaptável e Design System consistente.
• Exportação: Relatórios em Excel.

ROADMAP & FUTURO
1. Automação: Eventos recorrentes (RRule), sync com Google Calendar.
2. Engajamento: Push notifications, Check-in com QR Code.
3. Customização: Whitelabeling e campos personalizados.
4. Insights: Dashboard de métricas e relatórios por e-mail.

O sistema foi concebido com uma arquitetura modular que permite a implementação dessas funcionalidades sem a necessidade de refatoração do núcleo.""",
    statusText: "WEB • PRODUÇÃO",
    colorBase: Colors.indigo.shade800,
    techStack: [
      "Flutter Web",
      "Firebase",
      "Riverpod",
      "Intl",
    ],
    galleryAssets: [
      "assets/projects/events_manager/images/login.png",
      "assets/projects/events_manager/images/home.png",
      "assets/projects/events_manager/images/event.png",
    ],
    icon: FontAwesomeIcons.calendarCheck,
    link: "https://gerenciador-de-eventos-8b377.web.app/", 
    // repoLink: "https://github.com/seu-user/gerenciador",
    linkIcon: Icons.public,
    buttonText: "Acessar Sistema",
  ),
];

final List<ProjectModel> developmentProjects = [
  ProjectModel(
    title: "Simple Fit",
    description:
        "Aplicativo desenvolvido para facilitar o acompanhamento de treinos personalizados e evolução física.",
    details: """
RESUMO DO PROJETO
O Simple Fit é focado em entusiastas do fitness que buscam uma forma simples e eficaz de registrar seus treinos. O sistema permite a criação de rotinas personalizadas e oferece visualização clara do progresso através de gráficos.

CORE STACK
• Frontend: Flutter / Dart (Clean Architecture)
• Visualização: Charts adaptados
• Estado: Gestão reativa com foco em performance

FUNCIONALIDADES
• Registro simplificado de séries e repetições.
• Gráficos de evolução por grupamento muscular.
• Histórico de treinos com busca rápida.
""",
    statusText: "BETA na Playstore",
    colorBase: Colors.green.shade600,
    techStack: ["Flutter", "Clean Arch", "Charts"],
    icon: Icons.eco,
    link: "https://play.google.com/store/apps/details?id=com.simplefit",
    repoLink: "https://github.com/seu-user/simple-fit",
    linkIcon: FontAwesomeIcons.googlePlay,
    buttonText: "Baixar App",
    galleryAssets: [
      "assets/images/wip_placeholder.png",
    ],
  ),
  ProjectModel(
    title: "Faz a Média",
    description:
        "Aplicativo para auxiliar no cálculo do consumo médio de combustível. Permite o compartilhamento de veículos entre usuários e registro detalhado de abastecimentos.",
    statusText: "EM DESENVOLVIMENTO",
    colorBase: Colors.purple.shade600,
    techStack: ["Flutter", "Clean Arch", "Charts"],
    icon: Icons.local_gas_station,
    link: null, // Sem link público ainda
    repoLink: "https://github.com/seu-user/faz-a-media",
    linkIcon: Icons.lock,
    buttonText: "Em Breve",
    galleryAssets: [
      "assets/images/wip_placeholder.png",
    ],
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
        "• Desenvolvimento de features complexas para ecossistema mobile em Flutter.\n• Manutenção e evolução de código nativo (Kotlin/Swift) para integrações de baixo nível.\n• Aplicação de Clean Architecture e Atomic Design.\n• Metodologia Scrum.\n• Integração com serviços AWS e arquitetura serverless com Firebase.",
  ),
  ExperienceModel(
    title: "Estagiário de Desenvolvimento",
    organization: "Positivo Tecnologia",
    dateRange: "2023 - 2024",
    description:
        "• Auxílio no desenvolvimento mobile utilizando Flutter e Dart.\n• Implementação de componentes de UI baseados em Atomic Design.\n• Apoio na integração com APIs REST e diagnósticos de erros.\n• Participação ativa em cerimônias Scrum e aprendizado de fluxos de CI/CD.",
  ),
  ExperienceModel(
    title: "Desenvolvedor de Sistemas",
    organization: "Data Company Sistemas",
    dateRange: "2022 - 2023",
    description:
        "• Desenvolvimento de soluções mobile com Flutter.\n• Criação de ferramentas web e APIs utilizando JavaScript/TypeScript (Node.js).\n• Implementação de testes unitários e de integração para garantir a qualidade de software.\n• Elaboração de documentação técnica para desenvolvedores utilizando Docusaurus.",
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
    description: "Especialização focada em arquiteturas avançadas, performance e desenvolvimento nativo moderno.",
  ),
  ExperienceModel(
    title: "Tecnólogo em Análise e Desenvolvimento de Sistemas",
    organization: "PUCPR",
    dateRange: "2023 - 2025",
    description: "Formação focada em engenharia de software, processos ágeis e tecnologias modernas de desenvolvimento.",
  ),
  ExperienceModel(
    title: "Bacharelado em Ciência da Computação (Incompleto)",
    organization: "UDESC",
    dateRange: "2019 - 2022",
    description: "Monitor da disciplina de algoritmos por 2 anos. Iniciação científica com foco em Aprendizado de Máquina.",
  ),
];
