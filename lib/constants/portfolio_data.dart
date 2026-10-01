import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';

class PortfolioData {
  static const String name = 'Kalyan Babu';
  static const String role = 'Senior Mobile Application Developer';
  static const String shortBio =
      '5+ years of experience engineering high-performance production Flutter, Android & iOS systems across Enterprise ERP, GIS spatial analytics, workforce management, and offline-first field operations.';
  
  static const String extendedBio =
      'Mobile Application Developer with 5 years of hands-on experience building production Flutter applications across enterprise ERP, workforce management, infrastructure, GIS, and government field domains. Proven track record in designing responsive UI, schema-driven dynamic ERP forms, REST API orchestration, offline-first local persistence, GPS/GIS mapping, hardware camera integration, real-time analytics dashboards, and automated reporting. Adept in state management with BLoC, GetX, and Provider, Android/iOS native platform bridges, Agile/Scrum delivery, and full-lifecycle Play Store and App Store deployments.';

  static const String email = 'kalyanbabu6262@gmail.com';
  static const String phone = '+91 6300030418';
  static const String location = 'Hyderabad, Telangana, India';
  static const String linkedinUrl = 'https://www.linkedin.com/in/kalyand6262/';
  static const String githubUrl = 'https://github.com/KalyanbabuD';
  static const String statusText = 'Available for Senior Mobile / Flutter Engineer Roles';

  static const List<Map<String, String>> stats = [
    {
      'value': '5+',
      'label': 'Years Experience',
      'sub': 'Production Mobile Dev',
    },
    {
      'value': '15+',
      'label': 'Shipped Projects',
      'sub': 'Enterprise & GitHub',
    },
    {
      'value': '100K+',
      'label': 'Active Users',
      'sub': 'Field Officers & Citizens',
    },
    {
      'value': '99.8%',
      'label': 'Crash-Free Rate',
      'sub': 'Production Quality',
    },
  ];

  static const List<Map<String, dynamic>> engineeringPillars = [
    {
      'icon': Icons.sync_problem_rounded,
      'title': 'Offline-First Sync Engine',
      'desc':
          'Built robust offline local persistence layers using SQLite & Realm with automated conflict resolution, background queueing, and bi-directional REST sync for low or zero-connectivity field conditions.',
    },
    {
      'icon': Icons.map_rounded,
      'title': 'GIS & Spatial Intelligence',
      'desc':
          'Deep expertise in Google Maps & ArcGIS SDK integrations, GPS location tracking, polygonal geofencing, route chainage calculations, and geotagged multimedia evidence.',
    },
    {
      'icon': Icons.dynamic_form_rounded,
      'title': 'Dynamic Schema Form Engine',
      'desc':
          'Designed modular questionnaire and inspection engines that render complex forms dynamically from JSON schemas with nested validations, conditional logic, and offline draft storage.',
    },
    {
      'icon': Icons.architecture_rounded,
      'title': 'Clean Architecture & Reactive State',
      'desc':
          'Architected maintainable, testable codebases leveraging BLoC, GetX, and Provider with strict separation of presentation, domain, and data layers for zero memory leaks and peak frame rates.',
    },
    {
      'icon': Icons.camera_enhance_rounded,
      'title': 'Hardware & Native Integration',
      'desc':
          'Seamless integration with native device features: compressed camera capture, biometric authentication (FaceID/Fingerprint), QR/Barcode scanning, Bluetooth peripherals, and PDF/Excel generators.',
    },
    {
      'icon': Icons.cloud_done_rounded,
      'title': 'End-to-End Store Lifecycle',
      'desc':
          'Experienced in end-to-end releases via Google Play Console and Apple App Store Connect, automated CI/CD builds, staging pipelines, Firebase Crashlytics monitoring, and remote config.',
    },
  ];

  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: 'Mobile & Native Platforms',
      description: 'Cross-platform excellence and native OS bridges',
      icon: Icons.phone_android_rounded,
      skills: [
        'Flutter',
        'Dart',
        'Android (Java/Kotlin)',
        'iOS (Swift)',
        'Jetpack Compose',
        'Platform Channels',
        'Material 3 & Cupertino',
      ],
    ),
    SkillCategory(
      title: 'State Management & Architecture',
      description: 'Predictable state and scalable patterns',
      icon: Icons.hub_rounded,
      skills: [
        'BLoC Pattern',
        'GetX',
        'Provider',
        'Riverpod',
        'Clean Architecture',
        'MVVM',
        'Repository Pattern',
        'Dependency Injection',
      ],
    ),
    SkillCategory(
      title: 'Databases & Offline Persistence',
      description: 'Zero-connectivity data persistence and sync',
      icon: Icons.storage_rounded,
      skills: [
        'Realm DB',
        'SQLite (sqflite)',
        'Hive',
        'SharedPreferences',
        'Offline Sync Queues',
        'Conflict Resolution',
        'Encrypted Storage',
      ],
    ),
    SkillCategory(
      title: 'GIS, Maps & Geolocation',
      description: 'Spatial mapping, tracking, and telemetry',
      icon: Icons.satellite_alt_rounded,
      skills: [
        'Google Maps SDK',
        'ArcGIS Maps SDK',
        'GPS Geocoding',
        'Geofencing',
        'Geotagging & Exif',
        'Polyline & Polygon Layers',
        'Spatial Heatmaps',
      ],
    ),
    SkillCategory(
      title: 'Networking, Cloud & Backend',
      description: 'Robust API integration and real-time events',
      icon: Icons.cloud_sync_rounded,
      skills: [
        'RESTful APIs',
        'Dio & Interceptors',
        'JSON Serialization',
        'Firebase Auth & OTP',
        'Firebase Cloud Messaging (FCM)',
        'Firebase Crashlytics',
        'WebSockets',
      ],
    ),
    SkillCategory(
      title: 'Hardware & Advanced Features',
      description: 'Peripherals, media capture, and documents',
      icon: Icons.biotech_rounded,
      skills: [
        'Camera & Image Compression',
        'QR & Barcode Scanning',
        'Biometric Auth (Fingerprint/Face)',
        'Dynamic PDF Generation',
        'Excel Export / Import',
        'FlChart / Syncfusion Charts',
        'Push Notifications',
      ],
    ),
    SkillCategory(
      title: 'DevOps, Tools & Process',
      description: 'Quality engineering and deployment pipelines',
      icon: Icons.terminal_rounded,
      skills: [
        'Git & Bitbucket',
        'Google Play Console',
        'Apple App Store Connect',
        'CI/CD Pipelines',
        'Postman',
        'Agile / Scrum',
        'Android Studio & VS Code',
      ],
    ),
  ];

  static const List<ProjectModel> projects = [
    ProjectModel(
      id: 'hims-erp',
      title: 'HIMS ERP Mobile',
      category: 'Enterprise ERP',
      organization: 'SATRA Services',
      subtitle: 'Highway & Infrastructure Management System',
      description:
          'Mission-critical mobile ERP system designed for state highway authorities and contractors to manage road assets, project milestones, quality inspections, and field work orders.',
      problemSolved:
          'Highway engineers in remote stretches struggled with paper checklists, delayed approvals, and lost field notes. HIMS ERP digitized the entire inspection lifecycle.',
      architecture:
          'Engineered using Flutter with BLoC state management and SQLite offline storage. Implemented dynamic form rendering from API schemas, photo compression, and background sync queues.',
      keyFeatures: [
        'Dynamic ERP inspection checklists with mandatory photo validation',
        'Offline form completion and automatic sync on network restoration',
        'Multi-level role-based approval hierarchies',
        'Material consumption logging and digital sign-off',
      ],
      technologies: ['Flutter', 'Dart', 'BLoC', 'SQLite', 'Dio', 'REST API', 'Camera Geotagging'],
      impact: 'Adopted across major state highway corridors, reducing inspection cycle time by 45%.',
      icon: Icons.engineering_rounded,
      isPersonal: false,
    ),
    ProjectModel(
      id: 'hims-pwd',
      title: 'HIMS PWD Executive',
      category: 'Enterprise ERP',
      organization: 'SATRA Services',
      subtitle: 'Public Works Department Decision Support System',
      description:
          'Executive mobile analytics and decision-support portal for senior government engineers and PWD secretaries to track road infrastructure health, fund allocation, and contractor performance.',
      problemSolved:
          'Department executives lacked real-time visibility into statewide road conditions, budget burn rates, and pending project approvals.',
      architecture:
          'Clean Architecture with Provider and Dio. Custom-built interactive charts, real-time KPI scorecards, and interactive road-network mapping overlays.',
      keyFeatures: [
        'Executive dashboards with real-time budget, progress, and bottleneck metrics',
        'Interactive dynamic charts (bar, donut, trendlines) with drill-down filters',
        'GIS road-network visualization showing active and completed project stretches',
        'Direct digital approval and remark broadcast to field teams',
      ],
      technologies: ['Flutter', 'Provider', 'FlChart', 'ArcGIS', 'Dio', 'Push Notifications'],
      impact: 'Empowered high-level PWD leadership with single-pane visibility over 10,000+ km of roadways.',
      icon: Icons.dashboard_customize_rounded,
      isPersonal: false,
    ),
    ProjectModel(
      id: 'sconnect',
      title: 'Satra SConnect',
      category: 'HRMS & Workforce',
      organization: 'SATRA Services',
      subtitle: 'Enterprise Workforce & Field HRMS Platform',
      description:
          'Comprehensive enterprise employee portal and field workforce management solution encompassing attendance, jobcards, leave approvals, payroll, company announcements, and emergency ticketing.',
      problemSolved:
          'Distributed field workforce across multiple project sites had no unified channel for shift logging, salary access, and real-time communications.',
      architecture:
          'GetX state management with Realm local database for rapid caching. Integrated biometric device authentication and background push notification handling.',
      keyFeatures: [
        'Geofenced mobile check-in/out and digital jobcard management',
        'Self-service leave management, payslip downloads, and tax document viewer',
        'Ticketing system for IT and HR grievance resolution',
        'Company-wide news feed, event broadcasts, and push alerts',
      ],
      technologies: ['Flutter', 'GetX', 'Realm', 'FCM', 'Biometric Auth', 'PDF Viewer'],
      impact: 'Seamlessly onboarded 2,000+ enterprise employees with a 98% daily active adoption rate.',
      icon: Icons.badge_rounded,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.satra.sconnect&hl=en_IN',
      appStoreUrl: 'https://apps.apple.com/in/app/satra-sconnect/id6449672657',
      isPersonal: false,
    ),
    ProjectModel(
      id: 'gujrams',
      title: 'GujRAMS R&BD',
      category: 'GIS & Infrastructure',
      organization: 'SATRA Services',
      subtitle: 'Road Asset Spatial Analytics & GIS Management',
      description:
          'Advanced GIS-based spatial analytics platform mapping Gujarat state road networks, culverts, signages, and maintenance zones onto interactive map layers for Gujarat Roads & Buildings Department (R&BD).',
      problemSolved:
          'Engineers needed an intuitive spatial map interface to click any highway segment and instantly inspect maintenance history, contract details, and structural status.',
      architecture:
          'ArcGIS Maps SDK combined with Flutter vector graphics and custom caching shaders for fluid 60fps pan/zoom over massive geospatial shapefiles.',
      keyFeatures: [
        'Multi-layer GIS map rendering (road centerlines, culvert points, administrative boundaries)',
        'Spatial filtering by road category (SH, MDR, ODR, VR) and surface type',
        'Color-coded condition heatmaps (Good, Fair, Poor, Critical)',
        'Direct navigation to selected asset coordinates via external maps',
      ],
      technologies: ['Flutter', 'ArcGIS Runtime SDK', 'GetX', 'Vector Tiles', 'REST API'],
      impact: 'Used daily by 500+ government engineers for annual road maintenance planning and budgeting.',
      icon: Icons.layers_rounded,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.satra.gujrams&hl=en_IN',
      appStoreUrl: 'https://apps.apple.com/in/app/gujrams-r-bd/id6745588354',
      isPersonal: false,
    ),
    ProjectModel(
      id: 'gujmarg-citizen',
      title: 'GujMARG – Public Grievances App',
      category: 'Citizen Portal',
      organization: 'SATRA Services',
      subtitle: 'Gujarat Citizen Road Grievance & Pothole Reporting',
      description:
          'Official public road grievance reporting application for the Roads & Buildings Department, Government of Gujarat. Enables citizens across the state to photograph road defects, report potholes, track redressal status, and provide feedback.',
      problemSolved:
          'Citizens previously had no transparent, direct mechanism to report road hazards with geo-coordinates or track repair progress in real time.',
      architecture:
          'Offline-First architecture with SQLite, Dio interceptors with exponential retry, camera watermark geotagging (lat/long, timestamp), and Firebase phone OTP authentication.',
      keyFeatures: [
        'One-tap GPS geotagged grievance reporting with camera watermark proof',
        '100% offline data collection with automated background sync queue',
        'Firebase phone OTP authentication for verified citizen logins',
        'Live tracking of grievance lifecycle (Submitted, Assigned, Repaired, Closed)',
      ],
      technologies: ['Flutter', 'Google Maps', 'Firebase Auth', 'SQLite', 'Dio', 'Geotagging'],
      impact: 'Processed over 250,000 public road grievance logs with 95%+ timely redressal across Gujarat.',
      icon: Icons.alt_route_rounded,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.satra.gujmarg&hl=en_IN',
      appStoreUrl: 'https://apps.apple.com/in/app/gujmarg-public-grievances-app/id1551924377',
      isPersonal: false,
    ),
    ProjectModel(
      id: 'gujmarg-officer',
      title: 'GujMarg Dashboard App',
      category: 'Enterprise ERP',
      organization: 'SATRA Services',
      subtitle: 'Gujarat R&BD Official Grievance & Asset Monitoring',
      description:
          'Official executive and field officer dashboard application for Gujarat Roads & Buildings Department (R&BD) engineers, executive engineers, and senior officials to review, assign, verify, and close public road complaints.',
      problemSolved:
          'Department executives lacked a dedicated mobile cockpit to triage incoming citizen complaints, monitor sub-division performance, and verify contractor repair quality.',
      architecture:
          'Clean Architecture with Provider and Dio. Custom-built interactive charts, real-time KPI scorecards, interactive road-network mapping overlays, and push alerts.',
      keyFeatures: [
        'Officer dashboard with division, sub-division, and taluka complaint breakdowns',
        'Work order assignment and field technician dispatching',
        'Officer digital sign-off and repair verification with geotagged photo audit',
        'Real-time SLA escalation alerts and resolution timeline tracking',
      ],
      technologies: ['Flutter', 'Provider', 'FlChart', 'Google Maps', 'Dio', 'Push Notifications'],
      impact: 'Official executive tool for Gujarat R&BD managing complaint resolution across state-wide road networks.',
      icon: Icons.admin_panel_settings_rounded,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=in.gov.gujarat.gujmarg.officer&hl=en_IN',
      appStoreUrl: 'https://apps.apple.com/in/app/gujmarg-dashboard-app/id6450957252',
      isPersonal: false,
    ),
    ProjectModel(
      id: 'rrams-pwd',
      title: 'RRAMS-PWD',
      category: 'GIS & Infrastructure',
      organization: 'SATRA Services',
      subtitle: 'Rajasthan Road Asset Management for Officials',
      description:
          'Comprehensive state-wide road asset management platform used by Rajasthan PWD engineers for road inventory mapping, condition surveys, and contractor maintenance supervision.',
      problemSolved:
          'Tracking road deterioration over time across vast rural jurisdictions required GPS-accurate tracking and structured condition grading.',
      architecture:
          'Clean Architecture with GetX, ArcGIS integration for spatial road layers, and background location services for road centerline tracking.',
      keyFeatures: [
        'Continuous GPS road survey tracking with chainage intervals',
        'Pavement condition index (PCI) automated score calculation',
        'Role-based permissions (Junior Engineer, Assistant Engineer, Executive Engineer)',
        'Offline survey batching and scheduled cloud synchronization',
      ],
      technologies: ['Flutter', 'GetX', 'ArcGIS', 'SQLite', 'REST APIs', 'Background Location'],
      impact: 'Cataloged over 45,000 km of rural and state highway networks into a centralized GIS database.',
      icon: Icons.add_road_rounded,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=in.gov.rrams.pwd&hl=en_IN',
      appStoreUrl: 'https://apps.apple.com/in/app/rrams-pwd/id6714458939',
      isPersonal: false,
    ),
    ProjectModel(
      id: 'rrams-citizens',
      title: 'RRAMS-Citizens',
      category: 'Citizen Portal',
      organization: 'SATRA Services',
      subtitle: 'Rajasthan Citizen Road Grievance Portal',
      description:
          'Public-facing mobile application allowing citizens of Rajasthan to report potholes, road damages, broken guardrails, and waterlogging directly to the relevant PWD engineering division.',
      problemSolved:
          'Citizens previously had no transparent, direct mechanism to report road hazards or track repair status.',
      architecture:
          'Lightweight responsive Flutter app optimized for diverse budget Android devices, featuring one-tap location grabbing and instant image upload with compression.',
      keyFeatures: [
        'One-tap GPS geotagged photo reporting with automatic division mapping',
        'Real-time status tracking with timeline updates (Received -> Assigned -> Repaired)',
        'Before-and-after photo verification upon grievance closure',
        'Multilingual interface (Hindi & English) for broad accessibility',
      ],
      technologies: ['Flutter', 'Provider', 'Google Maps', 'Firebase Cloud Messaging', 'Dio'],
      impact: 'Achieved 50,000+ citizen downloads and an average grievance resolution time drop from 18 days to 5 days.',
      icon: Icons.people_alt_rounded,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=in.gov.rrams.citizen&hl=en_IN',
      appStoreUrl: 'https://apps.apple.com/in/app/rrams-citizen/id6717598973',
      isPersonal: false,
    ),
    ProjectModel(
      id: 'structures-inspection',
      title: 'Structures Inspection',
      category: 'GIS & Infrastructure',
      organization: 'SATRA Services',
      subtitle: 'Bridge, Culvert & Flyover Assessment System',
      description:
          'Specialized civil engineering mobile audit system for structural health monitoring of bridges, flyovers, causeways, and culverts along national and state highways.',
      problemSolved:
          'Structural inspections require hundreds of specialized engineering parameters (crack width, scour depth, deck condition) that generic forms cannot accommodate.',
      architecture:
          'Dynamic multi-step inspection tree built with BLoC, SQLite local draft persistence, and native image compression pipeline to handle hundreds of high-res defect photos.',
      keyFeatures: [
        'Categorized component checklists (substructure, superstructure, bearings, expansion joints)',
        'Defect classification matrix with severity scoring algorithm',
        'High-resolution multi-photo capture with annotations and crack marker overlays',
        'Instant on-device PDF inspection summary generation',
      ],
      technologies: ['Flutter', 'BLoC', 'SQLite', 'Camera API', 'PDF Generation', 'Exif Data'],
      impact: 'Standardized structural safety audits across 1,500+ bridges and elevated corridors.',
      icon: Icons.domain_rounded,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.satra.sia&hl=en_IN',
      isPersonal: false,
    ),
    ProjectModel(
      id: 'social-survey',
      title: 'Social Survey',
      category: 'Field & Offline',
      organization: 'SATRA Services',
      subtitle: 'Socio-Economic & Land Acquisition Survey Platform',
      description:
          'High-throughput mobile field surveying tool built for researchers and field enumerators collecting demographic, property impact, and infrastructure development data for road widening projects.',
      problemSolved:
          'Large-scale field surveys suffered from human data-entry errors, fraud, and cumbersome paper tally sheets.',
      architecture:
          'Complex JSON schema-driven dynamic questionnaire engine capable of rendering 100+ conditional logic questions with instantaneous validation and audio/photo metadata.',
      keyFeatures: [
        'Complex skip-logic and cross-question validation rules',
        'Enumerator GPS verification to prevent fraudulent remote submissions',
        'Offline interview caching supporting multi-hour survey sessions',
        'End-of-day batch encryption and automated server upload',
      ],
      technologies: ['Flutter', 'BLoC', 'Realm DB', 'Dynamic Forms', 'JSON Schema', 'Encryption'],
      impact: 'Executed 80,000+ household field interviews across 3 states with 100% data fidelity.',
      icon: Icons.analytics_rounded,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.satra.social_survey',
      isPersonal: false,
    ),
    ProjectModel(
      id: 'road-track',
      title: 'Road Track',
      category: 'GIS & Infrastructure',
      organization: 'SATRA Services',
      subtitle: 'Road Asset GPS Survey & Visual Imagery Logger',
      description:
          'Specialized road surveying and GPS tracking application engineered for field surveyors to map road corridors, track precise spatial coordinates, and capture geo-tagged visual documentation during surveys.',
      problemSolved:
          'Field road surveyors required continuous, high-accuracy GPS track recording coupled with interval photo-logging that works seamlessly even in zero-reception stretches.',
      architecture:
          'Background GPS location tracking engine, SQLite offline trajectory logging, automated camera capture with embedded chainage and coordinate watermark.',
      keyFeatures: [
        'Continuous background GPS telemetry and chainage coordinate recording',
        'Geo-referenced camera capture with directional compass and coordinate stamps',
        'Offline road trajectory storage with cloud batch export',
        'Integration with GIS road centerline mapping servers',
      ],
      technologies: ['Flutter', 'Dart', 'Background Location SDK', 'SQLite', 'Camera API', 'GIS'],
      impact: 'Deployed for highway corridor pre-construction and condition surveys covering extensive road networks.',
      icon: Icons.polyline_rounded,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.satra.roadtrack',
      isPersonal: false,
    ),
    ProjectModel(
      id: 'e-suvidha',
      title: 'E-SUVIDHA',
      category: 'Enterprise ERP',
      organization: 'SATRA Services',
      subtitle: 'Roads & Buildings Maintenance & Ticketing App',
      description:
          'Comprehensive enterprise facility and road maintenance ticketing system handling complaint registration, task assignment, field worker verification, and closure.',
      problemSolved:
          'Municipal engineers struggled to verify whether maintenance teams actually visited the physical repair site and performed authorized repairs.',
      architecture:
          'Integrated QR/Barcode scanning for physical asset tags, camera watermarking, and biometrics for technician shift sign-offs.',
      keyFeatures: [
        'QR code scanning for on-site equipment and road asset verification',
        'Automated ticket routing based on technician location and skill specialization',
        'Mandatory camera geotagging for proof of repair completion',
        'Offline operational mode with automated sync upon network connectivity',
      ],
      technologies: ['Flutter', 'Provider', 'QR Scanner', 'SQLite', 'Camera API', 'Dio'],
      impact: 'Increased field workforce compliance and timely ticket resolution rate by 60%.',
      icon: Icons.build_circle_rounded,
      isPersonal: false,
    ),
    ProjectModel(
      id: 'priyago-driver',
      title: 'PriyaGo Driver',
      category: 'Ride-Hailing & Logistics',
      organization: 'My Own Project',
      subtitle: 'On-Demand Ride-Hailing & Driver Logistics App',
      description:
          'Full-featured Flutter ride-hailing and driver partner mobile application with live GPS telemetry, ride requests, turn-by-turn routing, fare calculation, multi-language localization, and trip history.',
      problemSolved:
          'Provides an end-to-end mobile cockpit for drivers to accept passenger ride bookings, navigate to pickup/drop-off points, and monitor earnings with minimal battery consumption.',
      architecture:
          'Modular state architecture integrated with Google Maps SDK for real-time driver polyline tracking, Firebase Authentication, and REST API communication.',
      keyFeatures: [
        'Real-time ride request popup with fare estimate & pickup distance',
        'Interactive Google Maps navigation with live driver heading',
        'Driver online/offline toggle with geofenced service areas',
        'Trip earnings dashboard, invoice generation, and rating system',
      ],
      technologies: ['Flutter', 'Dart', 'Google Maps', 'Firebase', 'REST API', 'Location SDK'],
      impact: 'Full production-ready ride dispatching & driver navigation system with live GPS tracking.',
      icon: Icons.local_taxi_rounded,
      githubUrl: 'https://github.com/KalyanbabuD/priyaGo_Driver',
      isPersonal: true,
    ),
    ProjectModel(
      id: 'ruchee-restaurant',
      title: 'Ruchee Restaurant',
      category: 'E-Commerce & Food Delivery',
      organization: 'My Own Project',
      subtitle: 'Multi-Vendor Restaurant Partner & Food Delivery App',
      description:
          'Specialized Flutter application for restaurant partners and kitchen managers to process online food orders, manage dynamic menu catalogs, update inventory, and track courier dispatches in real time.',
      problemSolved:
          'Kitchens required a low-latency, reliable order management interface that alerted cooks immediately upon customer checkout and tracked courier handoff.',
      architecture:
          'Built with GetX reactive state management, Firebase Cloud Messaging (FCM) background push notifications, and local offline order caching.',
      keyFeatures: [
        'Live audio-alerting order queue with status transitions (Pending -> Cooking -> Ready -> Picked Up)',
        'Dynamic menu, variant, and add-on pricing management',
        'Daily sales, net revenue, and customer feedback analytics',
        'Delivery courier coordination with estimated dispatch countdown',
      ],
      technologies: ['Flutter', 'GetX', 'Firebase FCM', 'Shared Preferences', 'REST API', 'Connectivity Plus'],
      impact: 'Multi-vendor food commerce merchant app with instant notification dispatching and catalog control.',
      icon: Icons.restaurant_rounded,
      githubUrl: 'https://github.com/KalyanbabuD/RucheeResturant',
      isPersonal: true,
    ),
    ProjectModel(
      id: 'my-chatbot',
      title: 'MyChatBot AI Assistant',
      category: 'AI & Conversational',
      organization: 'My Own Project',
      subtitle: 'AI Conversational Assistant with Token Streaming',
      description:
          'Modern AI chatbot application built with Flutter featuring real-time conversational streaming, context-aware prompt handling, clean markdown message rendering, and history caching.',
      problemSolved:
          'Enables users to interact seamlessly with AI language models through an intuitive, fluid mobile chat interface with response formatting and syntax highlighting.',
      architecture:
          'Reactive chat state engine with asynchronous token streaming, local chat session persistence, and Firebase authentication.',
      keyFeatures: [
        'Real-time AI message streaming with typing animations',
        'Rich Markdown and syntax-highlighted code block rendering',
        'Multi-session chat history persistence and search',
        'Custom system prompts and temperature adjustments',
      ],
      technologies: ['Flutter', 'Dart', 'AI APIs', 'Firebase', 'State Management', 'Markdown'],
      impact: 'High-responsiveness AI conversational client with low-latency streaming and history preservation.',
      icon: Icons.smart_toy_rounded,
      githubUrl: 'https://github.com/KalyanbabuD/MyChatBot',
      isPersonal: true,
    ),
    ProjectModel(
      id: 'pereco',
      title: 'Pereco Clean Architecture',
      category: 'Architecture & Foundation',
      organization: 'My Own Project',
      subtitle: 'Enterprise Modular Clean-Architecture App Blueprint',
      description:
          'Production-ready enterprise Flutter application built with strict Clean Architecture principles (Core, Data, Domain, Modules, and Named Routing) for scalable multi-module engineering.',
      problemSolved:
          'Demonstrates clean separation of concerns, eliminating spaghetti code and technical debt across large-scale mobile development teams.',
      architecture:
          'Multi-layered Clean Architecture utilizing Repository Pattern, Dependency Injection, Dio network interceptors, and modular named routes.',
      keyFeatures: [
        'Strict separation of Presentation, Domain, and Data layers',
        'Centralized API network client with token refresh & retry interceptors',
        'Modular feature folders with dedicated routing and bindings',
        'Enterprise-grade error handling and failure models',
      ],
      technologies: ['Flutter', 'Clean Architecture', 'Repository Pattern', 'Dio', 'Modular Routing'],
      impact: 'Reusable enterprise architecture blueprint ensuring 100% testability and zero tight coupling.',
      icon: Icons.layers_outlined,
      githubUrl: 'https://github.com/KalyanbabuD/pereco',
      isPersonal: true,
    ),
    ProjectModel(
      id: 'rollcall',
      title: 'RollCall Attendance',
      category: 'Workforce & Attendance',
      organization: 'My Own Project',
      subtitle: 'Smart Digital Attendance & Verification System',
      description:
          'Digital roll call and field worker verification application designed for fast, tamper-proof attendance logging, geolocation validation, and shift verification.',
      problemSolved:
          'Replaces error-prone manual paper registers with instantaneous digital verification and real-time headcounts.',
      architecture:
          'Lightweight Flutter interface with offline queueing, barcode/photo verification, and synchronized server uploads.',
      keyFeatures: [
        'Rapid attendance check-in with batch logging',
        'GPS location verification and timestamp stamping',
        'Offline attendance recording with automatic cloud sync',
        'Daily summary reports and absentee tracking',
      ],
      technologies: ['Flutter', 'Dart', 'Offline DB', 'GPS Verification', 'REST API'],
      impact: 'Streamlined attendance and workforce logging for field crews and institutional teams.',
      icon: Icons.how_to_reg_rounded,
      githubUrl: 'https://github.com/KalyanbabuD/RollCall',
      isPersonal: true,
    ),
  ];

  static List<ProjectModel> get satraProjects => projects.where((p) => p.isSatra).toList();
  static List<ProjectModel> get ownProjects => projects.where((p) => p.isOwn).toList();

  static const Map<String, dynamic> experience = {
    'company': 'SATRA Services and Solutions Pvt. Ltd.',
    'location': 'Hyderabad, Telangana, India',
    'role': 'Software Engineer — Mobile Application Developer',
    'period': 'Jan 2022 – Present (4+ Years)',
    'type': 'Full-time',
    'summary':
        'Lead mobile development across multiple concurrent enterprise and government infrastructure mobility projects. Specialize in architecting high-reliability, offline-resilient Flutter applications for iOS and Android.',
    'highlights': [
      'Architect, develop, and maintain 10+ production-grade Flutter applications for Android and iOS across enterprise ERP, workforce, infrastructure, and government domains.',
      'Design responsive, pixel-perfect mobile and tablet user interfaces with reusable design systems, dynamic ERP form builders, and complex questionnaires.',
      'Engineer robust offline-first synchronization architectures utilizing SQLite and Realm with automated conflict resolution, background queueing, and exponential backoff retry algorithms.',
      'Integrate advanced GPS, ArcGIS Maps, and Google Maps SDKs for spatial asset tracking, chainage calculation, route geofencing, and geotagged photographic evidence.',
      'Build rich executive dashboards, interactive analytical charts (FlChart), and automated dynamic PDF/Excel report generators from RESTful API streams.',
      'Implement enterprise security, Firebase authentication, biometric login (FaceID/Fingerprint), Firebase Cloud Messaging (FCM), and deep linking.',
      'Lead end-to-end release lifecycle: profiling performance, resolving UI bottlenecks, eliminating memory leaks, and managing Google Play Console & Apple App Store Connect submissions.',
      'Collaborate closely with cross-functional teams including backend engineers, UI/UX designers, QA, and government client stakeholders in an Agile/Scrum environment.',
    ],
  };

  static const List<Map<String, String>> education = [
    {
      'degree': 'Bachelor of Technology (B.Tech)',
      'institution': 'Engineering Degree',
      'period': '2016 – 2020',
      'score': 'CGPA: 7.0 / 10',
      'icon': 'graduation_cap',
    },
    {
      'degree': 'Intermediate (10+2 / MPC)',
      'institution': 'Board of Intermediate Education',
      'period': '2014 – 2016',
      'score': 'CGPA: 8.0 / 10',
      'icon': 'school',
    },
    {
      'degree': 'Secondary School Certificate (SSC)',
      'institution': 'High School Education',
      'period': '2013 – 2014',
      'score': 'CGPA: 8.0 / 10',
      'icon': 'book',
    },
  ];
}
