import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/portfolio_data.dart';
import '../theme/portfolio_theme.dart';

class Footer extends StatelessWidget {
  final VoidCallback onScrollToTop;

  const Footer({super.key, required this.onScrollToTop});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF070A10) : const Color(0xFFF1F5F9),
        border: Border(
          top: BorderSide(
            color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PortfolioData.name,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                          ),
                          Text(
                            PortfolioData.role,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Social Icons & Back to top
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _launchUrl(PortfolioData.linkedinUrl),
                        icon: const FaIcon(FontAwesomeIcons.linkedin, size: 18),
                        tooltip: 'LinkedIn',
                        color: const Color(0xFF0A66C2),
                      ),
                      IconButton(
                        onPressed: () => _launchUrl('mailto:${PortfolioData.email}'),
                        icon: const Icon(Icons.email_outlined, size: 20),
                        tooltip: 'Email',
                        color: PortfolioTheme.primaryCyan,
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: onScrollToTop,
                        icon: const Icon(Icons.arrow_upward_rounded, size: 20),
                        tooltip: 'Scroll to Top',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(height: 1),
              const SizedBox(height: 24),

              // Bottom line
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 8,
                children: [
                  Text(
                    '© ${DateTime.now().year} ${PortfolioData.name} • Senior Mobile Application Developer. All rights reserved.',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '⚡ Built with Flutter Web • Optimized for LinkedIn',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
