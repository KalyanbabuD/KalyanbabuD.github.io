import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_model.dart';
import '../theme/portfolio_theme.dart';
import 'store_icons.dart';

class ProjectDetailsDialog extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsDialog({super.key, required this.project});

  static void show(BuildContext context, ProjectModel project) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ProjectDetailsDialog(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 768;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 40,
        vertical: 24,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 750),
        decoration: BoxDecoration(
          color: isDark ? PortfolioTheme.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.6 : 0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
                  ),
                ),
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          PortfolioTheme.primaryCyan.withOpacity(0.12),
                          PortfolioTheme.accentIndigo.withOpacity(0.08),
                        ]
                      : [
                          PortfolioTheme.primaryBlue.withOpacity(0.08),
                          PortfolioTheme.accentIndigo.withOpacity(0.04),
                        ],
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: PortfolioTheme.primaryCyan.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      project.icon,
                      color: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (project.isOwn
                                        ? PortfolioTheme.accentEmerald
                                        : (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue))
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: (project.isOwn
                                          ? PortfolioTheme.accentEmerald
                                          : (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue))
                                      .withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                project.isOwn ? 'MY OWN PROJECT' : 'SATRA SERVICES',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  color: project.isOwn
                                      ? PortfolioTheme.accentEmerald
                                      : (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue),
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isDark ? PortfolioTheme.darkCard : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                project.category.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          project.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        Text(
                          project.subtitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: isDark
                                    ? PortfolioTheme.darkTextSecondary
                                    : PortfolioTheme.lightTextSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'Close',
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Overview
                    _buildSectionHeader(context, 'Overview', Icons.info_outline_rounded),
                    const SizedBox(height: 8),
                    Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),

                    // Problem Solved
                    _buildSectionHeader(context, 'The Challenge & Solution', Icons.lightbulb_outline_rounded),
                    const SizedBox(height: 8),
                    Text(
                      project.problemSolved,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6),
                    ),
                    const SizedBox(height: 20),

                    // Architecture & Implementation
                    _buildSectionHeader(context, 'Architecture & Engineering', Icons.architecture_rounded),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? PortfolioTheme.darkCard : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
                        ),
                      ),
                      child: Text(
                        project.architecture,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.6,
                              fontFamily: 'monospace',
                              fontSize: 13.5,
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Key Features
                    _buildSectionHeader(context, 'Key Features Implemented', Icons.check_circle_outline_rounded),
                    const SizedBox(height: 10),
                    ...project.keyFeatures.map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.arrow_right_rounded,
                              color: PortfolioTheme.primaryCyan,
                              size: 22,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                feature,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Impact & Results
                    _buildSectionHeader(context, 'Production Impact', Icons.trending_up_rounded),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: PortfolioTheme.accentEmerald.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: PortfolioTheme.accentEmerald.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.verified_rounded,
                            color: PortfolioTheme.accentEmerald,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              project.impact,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? Colors.white : const Color(0xFF065F46),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tech Stack Tags
                    _buildSectionHeader(context, 'Technologies Used', Icons.code_rounded),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.technologies.map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isDark ? PortfolioTheme.darkCard : const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
                            ),
                          ),
                          child: Text(
                            tech,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Footer actions
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
                  ),
                ),
                color: isDark ? PortfolioTheme.darkBg.withOpacity(0.5) : Colors.grey.shade50,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: Wrap(
                spacing: 12,
                runSpacing: 10,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Senior Mobile Engineer • Kalyan Babu',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (project.playStoreUrl != null)
                        FilledButton.icon(
                          onPressed: () => _launchUrl(project.playStoreUrl!),
                          icon: const GooglePlayIcon(size: 14, isMultiColor: true),
                          label: const Text('Play Store'),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF01875F),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                          ),
                        ),
                      if (project.appStoreUrl != null)
                        FilledButton.icon(
                          onPressed: () => _launchUrl(project.appStoreUrl!),
                          icon: const AppleStoreIcon(size: 15, color: Colors.white),
                          label: const Text('App Store'),
                          style: FilledButton.styleFrom(
                            backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFF0F172A),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                          ),
                        ),
                      if (project.githubUrl != null)
                        FilledButton.icon(
                          onPressed: () => _launchUrl(project.githubUrl!),
                          icon: const FaIcon(FontAwesomeIcons.github, size: 14),
                          label: const Text('View on GitHub'),
                          style: FilledButton.styleFrom(
                            backgroundColor: isDark ? const Color(0xFF24292F) : const Color(0xFF1F2328),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                          ),
                        ),
                      FilledButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: FilledButton.styleFrom(
                          backgroundColor: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
                          foregroundColor: isDark ? Colors.black : Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        ),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
