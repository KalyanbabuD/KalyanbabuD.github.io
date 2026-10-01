import 'package:flutter/material.dart';
import '../constants/portfolio_data.dart';
import '../theme/portfolio_theme.dart';

class MetricsSection extends StatelessWidget {
  const MetricsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: 36,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            decoration: BoxDecoration(
              gradient: isDark
                  ? LinearGradient(
                      colors: [
                        PortfolioTheme.primaryCyan.withOpacity(0.08),
                        PortfolioTheme.accentIndigo.withOpacity(0.05),
                        PortfolioTheme.darkCard,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [
                        PortfolioTheme.primaryBlue.withOpacity(0.06),
                        Colors.white,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 700) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: PortfolioData.stats.asMap().entries.map((entry) {
                      final isLast = entry.key == PortfolioData.stats.length - 1;
                      return Expanded(
                        child: Row(
                          children: [
                            Expanded(child: _buildMetricItem(context, entry.value)),
                            if (!isLast)
                              Container(
                                height: 48,
                                width: 1,
                                color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Wrap(
                    spacing: 20,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: PortfolioData.stats.map((stat) {
                      return SizedBox(
                        width: (constraints.maxWidth / 2) - 20,
                        child: _buildMetricItem(context, stat),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricItem(BuildContext context, Map<String, String> stat) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => PortfolioTheme.heroGradient.createShader(bounds),
          child: Text(
            stat['value']!,
            style: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -1,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          stat['label']!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          stat['sub']!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}
