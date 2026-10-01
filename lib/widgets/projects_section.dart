import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/portfolio_data.dart';
import '../models/project_model.dart';
import '../theme/portfolio_theme.dart';
import 'project_details_dialog.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  // 'ALL', 'SATRA', 'OWN'
  String _selectedDivision = 'ALL';
  String _selectedSubCategory = 'All';

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 992;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Filter by division (SATRA vs Own vs All)
    List<ProjectModel> divisionProjects;
    if (_selectedDivision == 'SATRA') {
      divisionProjects = PortfolioData.satraProjects;
    } else if (_selectedDivision == 'OWN') {
      divisionProjects = PortfolioData.ownProjects;
    } else {
      divisionProjects = PortfolioData.projects;
    }

    // Secondary sub-category filter
    final filteredProjects = _selectedSubCategory == 'All'
        ? divisionProjects
        : divisionProjects.where((p) => p.category == _selectedSubCategory).toList();

    // Extract available subcategories based on current division
    final availableCategories = <String>['All', ...divisionProjects.map((p) => p.category).toSet()];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue)
                      .withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'PROJECT PORTFOLIO',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                    color: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Production & Personal Engineering',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Explore high-impact enterprise applications built at SATRA Services and independent personal systems built with full source code.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 28),

              // Primary Division Switcher: SATRA vs My Own Projects vs All
              _buildDivisionSwitcher(context),
              const SizedBox(height: 20),

              // Division Info Banner
              _buildDivisionBanner(context),
              const SizedBox(height: 20),

              // Subcategory Filter Chips (if more than 1 category)
              if (availableCategories.length > 2)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: availableCategories.map((category) {
                      final isSelected = _selectedSubCategory == category;
                      final count = category == 'All'
                          ? divisionProjects.length
                          : divisionProjects.where((p) => p.category == category).length;

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: FilterChip(
                          selected: isSelected,
                          label: Text('$category ($count)'),
                          onSelected: (val) {
                            setState(() {
                              _selectedSubCategory = category;
                            });
                          },
                          selectedColor: (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue)
                              .withOpacity(0.15),
                          backgroundColor: isDark ? PortfolioTheme.darkCard : const Color(0xFFF1F5F9),
                          labelStyle: TextStyle(
                            fontSize: 12.5,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue)
                                : (isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary),
                          ),
                          side: BorderSide(
                            color: isSelected
                                ? (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue)
                                : (isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder),
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          showCheckmark: false,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              const SizedBox(height: 32),

              // Projects Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 2;
                  if (constraints.maxWidth < 750) {
                    crossAxisCount = 1;
                  }

                  final itemWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 24)) / crossAxisCount;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: filteredProjects.map((project) {
                      return SizedBox(
                        width: itemWidth,
                        child: _buildProjectCard(context, project),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivisionSwitcher(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isDark ? PortfolioTheme.darkCard : const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
        ),
      ),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: [
          _divisionButton(
            context,
            id: 'ALL',
            label: 'All Projects',
            count: PortfolioData.projects.length,
            icon: Icons.grid_view_rounded,
          ),
          _divisionButton(
            context,
            id: 'SATRA',
            label: 'SATRA Enterprise Projects',
            count: PortfolioData.satraProjects.length,
            icon: Icons.business_rounded,
            highlightColor: const Color(0xFF00D2FF),
          ),
          _divisionButton(
            context,
            id: 'OWN',
            label: 'My Own Projects (GitHub)',
            count: PortfolioData.ownProjects.length,
            icon: Icons.rocket_launch_rounded,
            highlightColor: const Color(0xFF10B981),
          ),
        ],
      ),
    );
  }

  Widget _divisionButton(
    BuildContext context, {
    required String id,
    required String label,
    required int count,
    required IconData icon,
    Color? highlightColor,
  }) {
    final isSelected = _selectedDivision == id;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedDivision = id;
          _selectedSubCategory = 'All'; // reset sub-filter
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? PortfolioTheme.darkSurface : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (highlightColor ?? (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue))
                    .withOpacity(0.5)
                : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? (highlightColor ?? (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue))
                  : (isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected
                    ? (isDark ? Colors.white : Colors.black87)
                    : (isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? (highlightColor ?? (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue))
                        .withOpacity(0.15)
                    : (isDark ? Colors.white10 : Colors.black.withOpacity(0.06)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? (highlightColor ?? (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue))
                      : (isDark ? Colors.white70 : Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivisionBanner(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_selectedDivision == 'SATRA') {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: PortfolioTheme.primaryBlue.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: PortfolioTheme.primaryBlue.withOpacity(0.25),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.corporate_fare_rounded, color: PortfolioTheme.primaryCyan, size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Company Enterprise & Government Projects (SATRA Services and Solutions Pvt. Ltd.)',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Engineered for state highways, Public Works Departments (PWD Gujarat & Rajasthan), workforce management, and GIS road mapping.',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (_selectedDivision == 'OWN') {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: PortfolioTheme.accentEmerald.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: PortfolioTheme.accentEmerald.withOpacity(0.25),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.rocket_launch_rounded, color: PortfolioTheme.accentEmerald, size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'My Own Independent & Open Source Projects',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const FaIcon(FontAwesomeIcons.github, size: 14, color: PortfolioTheme.accentEmerald),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Independently built applications across Ride-Hailing, Food Delivery, AI Assistant, and Clean Architecture. Full source code on GitHub (github.com/KalyanbabuD).',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildProjectCard(BuildContext context, ProjectModel project) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isOwn = project.isOwn;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? PortfolioTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isOwn
              ? PortfolioTheme.accentEmerald.withOpacity(isDark ? 0.35 : 0.25)
              : (isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder),
          width: isOwn ? 1.5 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isOwn
                ? PortfolioTheme.accentEmerald.withOpacity(isDark ? 0.08 : 0.04)
                : Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Organization Pill & Icon
          Row(
            children: [
              // Organization Badge (SATRA vs My Own)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isOwn
                      ? PortfolioTheme.accentEmerald.withOpacity(0.12)
                      : PortfolioTheme.primaryCyan.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isOwn
                        ? PortfolioTheme.accentEmerald.withOpacity(0.3)
                        : PortfolioTheme.primaryCyan.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isOwn ? Icons.person_rounded : Icons.business_rounded,
                      size: 12,
                      color: isOwn ? PortfolioTheme.accentEmerald : PortfolioTheme.primaryCyan,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      isOwn ? 'MY OWN PROJECT' : 'SATRA SERVICES',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        color: isOwn ? PortfolioTheme.accentEmerald : PortfolioTheme.primaryCyan,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Category tag
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? PortfolioTheme.darkSurface : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    project.category,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              const Spacer(),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? PortfolioTheme.darkSurface : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  project.icon,
                  size: 20,
                  color: isOwn ? PortfolioTheme.accentEmerald : PortfolioTheme.primaryCyan,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Title & Subtitle
          Text(
            project.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 19,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            project.subtitle,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            project.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),

          // Impact badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: (isOwn ? PortfolioTheme.accentEmerald : PortfolioTheme.primaryCyan).withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: (isOwn ? PortfolioTheme.accentEmerald : PortfolioTheme.primaryCyan).withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up_rounded,
                  color: isOwn ? PortfolioTheme.accentEmerald : PortfolioTheme.primaryCyan,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    project.impact,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isOwn
                          ? (isDark ? const Color(0xFF34D399) : const Color(0xFF047857))
                          : (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Tech pills preview
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.technologies.take(4).map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? PortfolioTheme.darkSurface : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tech,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Action Buttons: Architecture, Play Store, App Store, and GitHub
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () => ProjectDetailsDialog.show(context, project),
                icon: const Icon(Icons.architecture_rounded, size: 16),
                label: const Text('Architecture'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
                  side: BorderSide(
                    color: (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue)
                        .withOpacity(0.4),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                ),
              ),
              if (project.playStoreUrl != null)
                FilledButton.icon(
                  onPressed: () => _launchUrl(project.playStoreUrl!),
                  icon: const FaIcon(FontAwesomeIcons.googlePlay, size: 13),
                  label: const Text('Play Store'),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF01875F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  ),
                ),
              if (project.appStoreUrl != null)
                FilledButton.icon(
                  onPressed: () => _launchUrl(project.appStoreUrl!),
                  icon: const FaIcon(FontAwesomeIcons.apple, size: 15),
                  label: const Text('App Store'),
                  style: FilledButton.styleFrom(
                    backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFF0F172A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  ),
                ),
              if (project.githubUrl != null)
                FilledButton.icon(
                  onPressed: () => _launchUrl(project.githubUrl!),
                  icon: const FaIcon(FontAwesomeIcons.github, size: 14),
                  label: const Text('GitHub'),
                  style: FilledButton.styleFrom(
                    backgroundColor: isDark ? const Color(0xFF24292F) : const Color(0xFF1F2328),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  ),
                ),
              if (project.playStoreUrl == null && project.appStoreUrl == null && project.githubUrl == null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: isDark ? PortfolioTheme.darkSurface : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        size: 13,
                        color: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Enterprise Internal App',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
