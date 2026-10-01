import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/portfolio_data.dart';
import '../theme/portfolio_theme.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onExploreProjects;
  final VoidCallback onOpenResume;
  final VoidCallback onContactMe;

  const HeroSection({
    super.key,
    required this.onExploreProjects,
    required this.onOpenResume,
    required this.onContactMe,
  });

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

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: isDark
            ? RadialGradient(
                center: const Alignment(0.6, -0.6),
                radius: 1.2,
                colors: [
                  PortfolioTheme.primaryCyan.withOpacity(0.08),
                  PortfolioTheme.accentIndigo.withOpacity(0.04),
                  Colors.transparent,
                ],
              )
            : RadialGradient(
                center: const Alignment(0.6, -0.6),
                radius: 1.2,
                colors: [
                  PortfolioTheme.primaryBlue.withOpacity(0.06),
                  PortfolioTheme.accentIndigo.withOpacity(0.03),
                  Colors.transparent,
                ],
              ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: isDesktop ? 60 : 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isDesktop
              ? _buildDesktopLayout(context)
              : _buildMobileLayout(context),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column: Text & CTAs
        Expanded(
          flex: 6,
          child: _buildIntroContent(context),
        ),
        const SizedBox(width: 48),
        // Right Column: Interactive Profile & Tech Card
        Expanded(
          flex: 4,
          child: _buildProfileCard(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIntroContent(context),
        const SizedBox(height: 36),
        Center(child: _buildProfileCard(context)),
      ],
    );
  }

  Widget _buildIntroContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: PortfolioTheme.accentEmerald.withOpacity(0.12),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: PortfolioTheme.accentEmerald.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: PortfolioTheme.accentEmerald,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: PortfolioTheme.accentEmerald.withOpacity(0.6),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  PortfolioData.statusText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: PortfolioTheme.accentEmerald,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Main Headline
        ShaderMask(
          shaderCallback: (bounds) => (isDark
                  ? const LinearGradient(
                      colors: [
                        Colors.white,
                        Color(0xFFE2E8F0),
                        Color(0xFF00D2FF)
                      ],
                    )
                  : const LinearGradient(
                      colors: [
                        Color(0xFF0F172A),
                        Color(0xFF1E293B),
                        Color(0xFF3A7BD5)
                      ],
                    ))
              .createShader(bounds),
          child: Text(
            'Scalable Mobile & Enterprise Solutions.',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  height: 1.15,
                ),
          ),
        ),
        const SizedBox(height: 20),

        // Subtitle / Intro
        Text(
          'Hi, I\'m ${PortfolioData.name} — a ${PortfolioData.role} with 5+ years of hands-on experience engineering mission-critical Flutter, Android & iOS systems across Enterprise ERP, GIS spatial analytics, workforce mobility, and offline-first field operations.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 17,
                height: 1.6,
                color:
                    isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
              ),
        ),
        const SizedBox(height: 32),

        // Primary Action Buttons
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            FilledButton.icon(
              onPressed: onExploreProjects,
              icon: const Icon(Icons.rocket_launch_rounded, size: 18),
              label: const Text('Explore 10+ Projects'),
              style: FilledButton.styleFrom(
                backgroundColor: isDark
                    ? PortfolioTheme.primaryCyan
                    : PortfolioTheme.primaryBlue,
                foregroundColor:
                    isDark ? const Color(0xFF0B0F19) : Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                textStyle:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
              ),
            ),
            FilledButton.icon(
              onPressed: () => _launchUrl(PortfolioData.linkedinUrl),
              icon: const FaIcon(FontAwesomeIcons.linkedin, size: 18),
              label: const Text('Connect on LinkedIn'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF0A66C2),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                textStyle:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
              ),
            ),
            OutlinedButton.icon(
              onPressed: onOpenResume,
              icon: const Icon(Icons.file_download_outlined, size: 18),
              label: const Text('View / Download Resume'),
              style: OutlinedButton.styleFrom(
                foregroundColor: isDark ? Colors.white : Colors.black87,
                side: BorderSide(
                  color: isDark
                      ? PortfolioTheme.darkBorder
                      : PortfolioTheme.lightBorder,
                  width: 1.5,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                textStyle:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),

        // Quick Social Links Row
        Wrap(
          spacing: 12,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Quick Connect:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? PortfolioTheme.darkTextSecondary
                    : PortfolioTheme.lightTextSecondary,
              ),
            ),
            _socialChip(
              icon: const Icon(Icons.email_outlined,
                  size: 14, color: PortfolioTheme.primaryCyan),
              label: PortfolioData.email,
              onTap: () => _launchUrl('mailto:${PortfolioData.email}'),
              context: context,
            ),
            _socialChip(
              icon: const Icon(Icons.phone_outlined,
                  size: 14, color: PortfolioTheme.primaryCyan),
              label: PortfolioData.phone,
              onTap: () => _launchUrl('tel:${PortfolioData.phone}'),
              context: context,
            ),
            _socialChip(
              icon: const FaIcon(FontAwesomeIcons.whatsapp,
                  size: 13, color: PortfolioTheme.primaryCyan),
              label: 'WhatsApp',
              onTap: () => _launchUrl('https://wa.me/916300030418'),
              context: context,
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialChip({
    required Widget icon,
    required String label,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? PortfolioTheme.darkCard : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: const BoxConstraints(maxWidth: 420),
      decoration: BoxDecoration(
        color: isDark ? PortfolioTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color:
              isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: PortfolioTheme.primaryCyan.withOpacity(isDark ? 0.15 : 0.08),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card header bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? PortfolioTheme.darkBorder
                      : PortfolioTheme.lightBorder,
                ),
              ),
              color:
                  isDark ? PortfolioTheme.darkSurface : const Color(0xFFF8FAFC),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF59E0B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar with glowing ring
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: PortfolioTheme.heroGradient,
                    boxShadow: [
                      BoxShadow(
                        color: PortfolioTheme.primaryCyan.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isDark ? PortfolioTheme.darkSurface : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'KB',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            foreground: Paint()
                              ..shader =
                                  PortfolioTheme.heroGradient.createShader(
                                const Rect.fromLTWH(0, 0, 100, 100),
                              ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Name & Role
                Text(
                  PortfolioData.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Senior Mobile Application Developer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? PortfolioTheme.primaryCyan
                        : PortfolioTheme.primaryBlue,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 14, color: PortfolioTheme.darkTextSecondary),
                    const SizedBox(width: 4),
                    Text(
                      PortfolioData.location,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Key Architecture Badges
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: [
                    _miniPill('Flutter 3.x', PortfolioTheme.primaryCyan),
                    _miniPill('Android & iOS', PortfolioTheme.accentIndigo),
                    _miniPill('BLoC / GetX', PortfolioTheme.accentPurple),
                    _miniPill('Offline Sync', PortfolioTheme.accentEmerald),
                    _miniPill('GIS & ArcGIS', PortfolioTheme.accentAmber),
                  ],
                ),
                const SizedBox(height: 20),

                // Quick stats snippet box
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? PortfolioTheme.darkSurface
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark
                          ? PortfolioTheme.darkBorder
                          : PortfolioTheme.lightBorder,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _profileStat('5+ Yrs', 'Experience')),
                      Container(
                          height: 24,
                          width: 1,
                          color: isDark
                              ? PortfolioTheme.darkBorder
                              : PortfolioTheme.lightBorder),
                      Expanded(child: _profileStat('10+ Apps', 'Shipped')),
                      Container(
                          height: 24,
                          width: 1,
                          color: isDark
                              ? PortfolioTheme.darkBorder
                              : PortfolioTheme.lightBorder),
                      Expanded(child: _profileStat('99.8%', 'Crash-Free')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniPill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _profileStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: PortfolioTheme.darkTextSecondary,
          ),
        ),
      ],
    );
  }
}
