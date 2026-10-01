import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/portfolio_data.dart';
import '../models/project_model.dart';
import '../theme/portfolio_theme.dart';
import 'store_icons.dart';

class ResumeDialog extends StatelessWidget {
  const ResumeDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const ResumeDialog(),
    );
  }

  void _copyResumeText(BuildContext context) {
    final buffer = StringBuffer();
    buffer.writeln('${PortfolioData.name} — ${PortfolioData.role}');
    buffer.writeln('${PortfolioData.location} | Email: ${PortfolioData.email} | Phone: ${PortfolioData.phone}');
    buffer.writeln('LinkedIn: ${PortfolioData.linkedinUrl}\n');

    buffer.writeln('--- PROFESSIONAL SUMMARY ---');
    buffer.writeln(PortfolioData.extendedBio);
    buffer.writeln('\n--- WORK EXPERIENCE ---');
    final exp = PortfolioData.experience;
    buffer.writeln('${exp['role']} | ${exp['company']} (${exp['period']})');
    for (final h in (exp['highlights'] as List<String>)) {
      buffer.writeln('• $h');
    }

    buffer.writeln('\n--- CORE TECHNICAL SKILLS ---');
    for (final cat in PortfolioData.skillCategories) {
      buffer.writeln('${cat.title}: ${cat.skills.join(', ')}');
    }

    buffer.writeln('\n--- COMPANY ENTERPRISE & GOVT PROJECTS (SATRA SERVICES) ---');
    for (final p in PortfolioData.satraProjects) {
      buffer.writeln('${p.title} (${p.category}): ${p.subtitle}');
      buffer.writeln('  Tech: ${p.technologies.join(', ')}');
      buffer.writeln('  Impact: ${p.impact}');
    }

    buffer.writeln('\n--- MY OWN PERSONAL & OPEN SOURCE PROJECTS (GITHUB) ---');
    for (final p in PortfolioData.ownProjects) {
      buffer.writeln('${p.title} (${p.category}): ${p.subtitle}');
      buffer.writeln('  GitHub: ${p.githubUrl ?? ''}');
      buffer.writeln('  Tech: ${p.technologies.join(', ')}');
      buffer.writeln('  Impact: ${p.impact}');
    }

    buffer.writeln('\n--- EDUCATION ---');
    for (final edu in PortfolioData.education) {
      buffer.writeln('${edu['degree']} — ${edu['institution']} (${edu['period']}) - ${edu['score']}');
    }

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Complete Resume text copied to clipboard! Ready to paste into ATS or Email.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: PortfolioTheme.accentEmerald,
      ),
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
        horizontal: isSmallScreen ? 12 : 36,
        vertical: 20,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 880, maxHeight: 820),
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
          children: [
            // Top Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
                  ),
                ),
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          PortfolioTheme.primaryCyan.withOpacity(0.1),
                          PortfolioTheme.accentIndigo.withOpacity(0.05),
                        ]
                      : [
                          PortfolioTheme.primaryBlue.withOpacity(0.06),
                          PortfolioTheme.accentIndigo.withOpacity(0.02),
                        ],
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.description_rounded, color: PortfolioTheme.primaryCyan, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Curriculum Vitae / Resume Overview',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'Close',
                  ),
                ],
              ),
            ),

            // Resume Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isSmallScreen ? 20 : 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Block
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                PortfolioData.name,
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -0.5,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                PortfolioData.role,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 14,
                                runSpacing: 6,
                                children: [
                                  _infoChip(Icons.location_on_outlined, PortfolioData.location),
                                  _infoChip(Icons.email_outlined, PortfolioData.email),
                                  _infoChip(Icons.phone_outlined, PortfolioData.phone),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(height: 1),
                    const SizedBox(height: 24),

                    // Summary
                    _sectionHeader('PROFESSIONAL SUMMARY', isDark),
                    const SizedBox(height: 10),
                    Text(
                      PortfolioData.extendedBio,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.65),
                    ),
                    const SizedBox(height: 28),

                    // Experience
                    _sectionHeader('WORK EXPERIENCE', isDark),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isDark ? PortfolioTheme.darkCard : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                PortfolioData.experience['role'] as String,
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                              ),
                              Text(
                                PortfolioData.experience['period'] as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${PortfolioData.experience['company']} — ${PortfolioData.experience['location']}',
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 14),
                          ...((PortfolioData.experience['highlights'] as List<String>).map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.5,
                                        color: isDark ? Colors.white70 : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // SATRA Services Projects
                    _sectionHeader('COMPANY ENTERPRISE & GOVT PROJECTS — SATRA SERVICES (${PortfolioData.satraProjects.length})', isDark),
                    const SizedBox(height: 12),
                    ...PortfolioData.satraProjects.map((proj) => _buildResumeProjectTile(proj, isDark)),
                    const SizedBox(height: 24),

                    // My Own Projects
                    _sectionHeader('MY OWN PERSONAL & OPEN SOURCE PROJECTS — GITHUB (${PortfolioData.ownProjects.length})', isDark),
                    const SizedBox(height: 12),
                    ...PortfolioData.ownProjects.map((proj) => _buildResumeProjectTile(proj, isDark)),
                    const SizedBox(height: 20),

                    // Education
                    _sectionHeader('EDUCATION', isDark),
                    const SizedBox(height: 10),
                    ...PortfolioData.education.map((edu) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${edu['degree']} (${edu['institution']})',
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                            Text(
                              '${edu['period']} • ${edu['score']}',
                              style: const TextStyle(fontSize: 12, color: PortfolioTheme.darkTextSecondary),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Bottom Actions Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
                  ),
                ),
                color: isDark ? PortfolioTheme.darkBg : const Color(0xFFF8FAFC),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: Wrap(
                spacing: 12,
                runSpacing: 10,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _copyResumeText(context),
                    icon: const Icon(Icons.copy_rounded, size: 16),
                    label: const Text('Copy Resume Text (ATS Friendly)'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isDark ? Colors.white : Colors.black87,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FilledButton.icon(
                        onPressed: () async {
                          final uri = Uri.parse(PortfolioData.linkedinUrl);
                          if (await canLaunchUrl(uri)) await launchUrl(uri);
                        },
                        icon: const FaIcon(FontAwesomeIcons.linkedin, size: 14),
                        label: const Text('LinkedIn Profile'),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF0A66C2),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FilledButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: FilledButton.styleFrom(
                          backgroundColor: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
                          foregroundColor: isDark ? Colors.black : Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Done'),
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

  Widget _infoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: PortfolioTheme.darkTextSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: PortfolioTheme.darkTextSecondary),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title, bool isDark) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildResumeProjectTile(ProjectModel proj, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? PortfolioTheme.darkCard.withOpacity(0.5) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: proj.isOwn
                ? PortfolioTheme.accentEmerald.withOpacity(0.3)
                : (isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  proj.title,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: (proj.isOwn ? PortfolioTheme.accentEmerald : PortfolioTheme.accentIndigo).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    proj.isOwn ? 'MY OWN • ${proj.category}' : proj.category,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: proj.isOwn ? PortfolioTheme.accentEmerald : null,
                    ),
                  ),
                ),
                const Spacer(),
                if (proj.playStoreUrl != null) ...[
                  const GooglePlayIcon(size: 13, isMultiColor: true),
                  const SizedBox(width: 8),
                ],
                if (proj.appStoreUrl != null) ...[
                  AppleStoreIcon(size: 13, color: isDark ? Colors.white70 : Colors.black87),
                  const SizedBox(width: 8),
                ],
                if (proj.githubUrl != null) ...[
                  const FaIcon(FontAwesomeIcons.github, size: 12, color: PortfolioTheme.darkTextSecondary),
                ],
              ],
            ),
            const SizedBox(height: 4),
            Text(
              proj.description,
              style: TextStyle(
                fontSize: 12.5,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tech: ${proj.technologies.join(', ')}',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
