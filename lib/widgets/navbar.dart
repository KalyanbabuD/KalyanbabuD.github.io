import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/portfolio_data.dart';
import '../theme/portfolio_theme.dart';

class Navbar extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;
  final Function(int sectionIndex) onNavigate;
  final VoidCallback onOpenResume;
  final VoidCallback onOpenContact;

  const Navbar({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    required this.onNavigate,
    required this.onOpenResume,
    required this.onOpenContact,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 992;

    return Container(
      decoration: BoxDecoration(
        color: (isDark ? PortfolioTheme.darkBg : Colors.white).withOpacity(0.85),
        border: Border(
          bottom: BorderSide(
            color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Row(
              children: [
                // Brand / Monogram
                InkWell(
                  onTap: () => onNavigate(0),
                  borderRadius: BorderRadius.circular(12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          gradient: PortfolioTheme.heroGradient,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: PortfolioTheme.primaryCyan.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'KB',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                PortfolioData.name.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: PortfolioTheme.accentEmerald,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Senior Mobile Developer',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark
                                  ? PortfolioTheme.darkTextSecondary
                                  : PortfolioTheme.lightTextSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Desktop Menu Items
                if (isDesktop) ...[
                  _navItem('About', 0),
                  _navItem('Highlights', 1),
                  _navItem('Skills', 2),
                  _navItem('Projects', 3),
                  _navItem('Experience', 4),
                  _navItem('Contact', 5),
                  const SizedBox(width: 16),
                  
                  // Resume button
                  OutlinedButton.icon(
                    onPressed: onOpenResume,
                    icon: const Icon(Icons.description_outlined, size: 16),
                    label: const Text('Resume'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isDark ? Colors.white : Colors.black87,
                      side: BorderSide(
                        color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // GitHub Button
                  IconButton(
                    onPressed: () async {
                      final uri = Uri.parse(PortfolioData.githubUrl);
                      if (await canLaunchUrl(uri)) await launchUrl(uri);
                    },
                    icon: const FaIcon(FontAwesomeIcons.github, size: 18),
                    tooltip: 'GitHub: KalyanbabuD',
                  ),
                  const SizedBox(width: 8),

                  // Connect / Hire CTA button
                  FilledButton.icon(
                    onPressed: onOpenContact,
                    icon: const FaIcon(FontAwesomeIcons.linkedin, size: 14),
                    label: const Text('Connect'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF0A66C2), // LinkedIn blue
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],

                // Dark / Light Theme Toggle
                IconButton(
                  onPressed: onToggleTheme,
                  tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                  icon: Icon(
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    color: isDark ? PortfolioTheme.accentAmber : Colors.indigo,
                    size: 20,
                  ),
                ),

                // Mobile drawer trigger
                if (!isDesktop)
                  IconButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: const Icon(Icons.menu_rounded),
                    tooltip: 'Menu',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(String label, int index) {
    return Builder(builder: (context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return TextButton(
        onPressed: () => onNavigate(index),
        style: TextButton.styleFrom(
          foregroundColor: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }
}
