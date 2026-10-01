import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants/portfolio_data.dart';
import 'theme/portfolio_theme.dart';
import 'widgets/contact_section.dart';
import 'widgets/education_section.dart';
import 'widgets/experience_section.dart';
import 'widgets/footer.dart';
import 'widgets/hero_section.dart';
import 'widgets/metrics_section.dart';
import 'widgets/navbar.dart';
import 'widgets/projects_section.dart';
import 'widgets/resume_dialog.dart';
import 'widgets/skills_section.dart';
import 'widgets/why_hire_me_section.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${PortfolioData.name} | Senior Mobile Application Developer',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: PortfolioTheme.lightTheme,
      darkTheme: PortfolioTheme.darkTheme,
      home: PortfolioHomePage(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const PortfolioHomePage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _whyKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final show = _scrollController.offset > 400;
      if (show != _showBackToTop) {
        setState(() {
          _showBackToTop = show;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    GlobalKey targetKey;
    switch (index) {
      case 0:
        targetKey = _heroKey;
        break;
      case 1:
        targetKey = _whyKey;
        break;
      case 2:
        targetKey = _skillsKey;
        break;
      case 3:
        targetKey = _projectsKey;
        break;
      case 4:
        targetKey = _experienceKey;
        break;
      case 5:
        targetKey = _contactKey;
        break;
      default:
        targetKey = _heroKey;
    }

    final context = targetKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    return Scaffold(
      endDrawer: _buildMobileDrawer(context),
      floatingActionButton: _showBackToTop
          ? FloatingActionButton.small(
              onPressed: _scrollToTop,
              backgroundColor: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
              foregroundColor: isDark ? Colors.black : Colors.white,
              tooltip: 'Back to Top',
              child: const Icon(Icons.arrow_upward_rounded),
            )
          : null,
      body: Stack(
        children: [
          // Main Scrollable View
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Top spacing for sticky navbar
                const SizedBox(height: 70),

                // Hero Section
                Container(
                  key: _heroKey,
                  child: HeroSection(
                    onExploreProjects: () => _scrollToSection(3),
                    onOpenResume: () => ResumeDialog.show(context),
                    onContactMe: () => _scrollToSection(5),
                  ),
                ),

                // Key Numbers / Metrics Banner
                const MetricsSection(),

                // Engineering Strengths & Why Hire Me
                Container(
                  key: _whyKey,
                  child: const WhyHireMeSection(),
                ),

                // Skills & Tech Matrix
                Container(
                  key: _skillsKey,
                  child: const SkillsSection(),
                ),

                // Featured 10 Production Projects
                Container(
                  key: _projectsKey,
                  child: const ProjectsSection(),
                ),

                // Professional Experience
                Container(
                  key: _experienceKey,
                  child: const ExperienceSection(),
                ),

                // Education
                const EducationSection(),

                // Contact Section
                Container(
                  key: _contactKey,
                  child: const ContactSection(),
                ),

                // Footer
                Footer(onScrollToTop: _scrollToTop),
              ],
            ),
          ),

          // Pinned Glassmorphic Navbar on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              isDark: isDark,
              onToggleTheme: widget.onToggleTheme,
              onNavigate: _scrollToSection,
              onOpenResume: () => ResumeDialog.show(context),
              onOpenContact: () => _scrollToSection(5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    final isDark = widget.isDark;

    return Drawer(
      backgroundColor: isDark ? PortfolioTheme.darkSurface : Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: PortfolioTheme.heroGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'KB',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kalyan Babu', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Senior Mobile Developer', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  _drawerItem('About', Icons.person_outline_rounded, () {
                    Navigator.pop(context);
                    _scrollToSection(0);
                  }),
                  _drawerItem('Highlights & Architecture', Icons.architecture_rounded, () {
                    Navigator.pop(context);
                    _scrollToSection(1);
                  }),
                  _drawerItem('Skills Matrix', Icons.code_rounded, () {
                    Navigator.pop(context);
                    _scrollToSection(2);
                  }),
                  _drawerItem('Production Projects (10)', Icons.rocket_launch_outlined, () {
                    Navigator.pop(context);
                    _scrollToSection(3);
                  }),
                  _drawerItem('Experience', Icons.business_center_outlined, () {
                    Navigator.pop(context);
                    _scrollToSection(4);
                  }),
                  _drawerItem('Contact & Hire', Icons.send_rounded, () {
                    Navigator.pop(context);
                    _scrollToSection(5);
                  }),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ResumeDialog.show(context);
                      },
                      icon: const Icon(Icons.description_outlined),
                      label: const Text('View Full Resume'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FilledButton.icon(
                      onPressed: () async {
                        Navigator.pop(context);
                        final uri = Uri.parse(PortfolioData.linkedinUrl);
                        if (await canLaunchUrl(uri)) await launchUrl(uri);
                      },
                      icon: const FaIcon(FontAwesomeIcons.linkedin, size: 16),
                      label: const Text('LinkedIn Profile'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF0A66C2),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        Navigator.pop(context);
                        final uri = Uri.parse(PortfolioData.githubUrl);
                        if (await canLaunchUrl(uri)) await launchUrl(uri);
                      },
                      icon: const FaIcon(FontAwesomeIcons.github, size: 16),
                      label: const Text('GitHub Profile'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isDark ? 'Dark Theme' : 'Light Theme',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: widget.onToggleTheme,
                    icon: Icon(
                      isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      color: isDark ? PortfolioTheme.accentAmber : Colors.indigo,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String label, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 20, color: PortfolioTheme.primaryCyan),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      onTap: onTap,
    );
  }
}
