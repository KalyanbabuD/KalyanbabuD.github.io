import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/portfolio_data.dart';
import '../theme/portfolio_theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: PortfolioTheme.accentEmerald,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showQuickMessageDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final messageCtrl = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: isDark ? PortfolioTheme.darkCard : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Send a Direct Message',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Your Name or Company',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(
                  labelText: 'Your Email or Phone',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: messageCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Message / Role Description',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  alignLabelWithHint: true,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () async {
              final subject = Uri.encodeComponent(
                'Opportunity / Collaboration inquiry from ${nameCtrl.text.isEmpty ? 'Recruiter' : nameCtrl.text}',
              );
              final body = Uri.encodeComponent(
                'Hi Kalyan,\n\n${messageCtrl.text}\n\nSender Contact: ${emailCtrl.text}\nSender Name: ${nameCtrl.text}',
              );
              final mailto = 'mailto:${PortfolioData.email}?subject=$subject&body=$body';
              Navigator.pop(dialogCtx);
              await _launchUrl(mailto);
            },
            icon: const Icon(Icons.send_rounded, size: 16),
            label: const Text('Send via Email Client'),
            style: FilledButton.styleFrom(
              backgroundColor: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
              foregroundColor: isDark ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 992;
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              // Section Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: PortfolioTheme.accentEmerald.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'GET IN TOUCH',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                    color: PortfolioTheme.accentEmerald,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Let\'s Connect & Build Together',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'I am actively available for Senior Mobile / Flutter Engineer positions, enterprise architectural consulting, and high-impact mobility challenges.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 36),

              // Contact Cards
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 3;
                  if (constraints.maxWidth < 650) {
                    crossAxisCount = 1;
                  } else if (constraints.maxWidth < 992) {
                    crossAxisCount = 2;
                  }

                  final itemWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 20)) / crossAxisCount;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      // LinkedIn Card (Top priority!)
                      SizedBox(
                        width: itemWidth,
                        child: _buildContactCard(
                          context,
                          title: 'LinkedIn Network',
                          subtitle: 'linkedin.com/in/kalyand6262',
                          actionLabel: 'View Profile & Connect',
                          iconWidget: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0A66C2).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const FaIcon(FontAwesomeIcons.linkedin, color: Color(0xFF0A66C2), size: 24),
                          ),
                          onAction: () => _launchUrl(PortfolioData.linkedinUrl),
                          onSecondaryAction: () => _copyToClipboard(
                            context,
                            PortfolioData.linkedinUrl,
                            'LinkedIn Profile URL',
                          ),
                          secondaryActionLabel: 'Copy Link',
                          highlight: true,
                        ),
                      ),

                      // Email Card
                      SizedBox(
                        width: itemWidth,
                        child: _buildContactCard(
                          context,
                          title: 'Direct Email',
                          subtitle: PortfolioData.email,
                          actionLabel: 'Compose Email',
                          iconWidget: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: PortfolioTheme.primaryCyan.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.email_rounded, color: PortfolioTheme.primaryCyan, size: 24),
                          ),
                          onAction: () => _launchUrl('mailto:${PortfolioData.email}'),
                          onSecondaryAction: () => _copyToClipboard(
                            context,
                            PortfolioData.email,
                            'Email Address',
                          ),
                          secondaryActionLabel: 'Copy Email',
                        ),
                      ),

                      // Phone & WhatsApp Card
                      SizedBox(
                        width: itemWidth,
                        child: _buildContactCard(
                          context,
                          title: 'Phone & WhatsApp',
                          subtitle: '${PortfolioData.phone} (Hyderabad, IST)',
                          actionLabel: 'Chat on WhatsApp',
                          iconWidget: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF25D366).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const FaIcon(FontAwesomeIcons.whatsapp, color: Color(0xFF25D366), size: 24),
                          ),
                          onAction: () => _launchUrl('https://wa.me/916300030418'),
                          onSecondaryAction: () => _launchUrl('tel:${PortfolioData.phone}'),
                          secondaryActionLabel: 'Direct Call',
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 28),

              // Quick Message Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: isDark
                      ? LinearGradient(
                          colors: [
                            PortfolioTheme.accentIndigo.withOpacity(0.12),
                            PortfolioTheme.primaryCyan.withOpacity(0.08),
                          ],
                        )
                      : LinearGradient(
                          colors: [
                            PortfolioTheme.primaryBlue.withOpacity(0.08),
                            PortfolioTheme.accentIndigo.withOpacity(0.04),
                          ],
                        ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
                  ),
                ),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 20,
                  runSpacing: 16,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Have an open role or custom project requirements?',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Send a quick note with your role specification or timeline.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    FilledButton.icon(
                      onPressed: () => _showQuickMessageDialog(context),
                      icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                      label: const Text('Send a Quick Note'),
                      style: FilledButton.styleFrom(
                        backgroundColor: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
                        foregroundColor: isDark ? Colors.black : Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String actionLabel,
    required Widget iconWidget,
    required VoidCallback onAction,
    required VoidCallback onSecondaryAction,
    required String secondaryActionLabel,
    bool highlight = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? PortfolioTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: highlight
              ? (isDark ? PortfolioTheme.primaryCyan.withOpacity(0.5) : const Color(0xFF0A66C2).withOpacity(0.5))
              : (isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder),
          width: highlight ? 1.8 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconWidget,
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),

          // Primary Action
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onAction,
              style: FilledButton.styleFrom(
                backgroundColor: highlight ? const Color(0xFF0A66C2) : (isDark ? PortfolioTheme.darkSurface : const Color(0xFFF1F5F9)),
                foregroundColor: highlight ? Colors.white : (isDark ? Colors.white : Colors.black87),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(actionLabel, style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 8),

          // Secondary Action
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onSecondaryAction,
              style: TextButton.styleFrom(
                foregroundColor: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
              ),
              child: Text(secondaryActionLabel, style: const TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}
