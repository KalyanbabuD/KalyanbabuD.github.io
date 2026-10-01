import 'package:flutter/material.dart';
import '../constants/portfolio_data.dart';
import '../theme/portfolio_theme.dart';

class WhyHireMeSection extends StatelessWidget {
  const WhyHireMeSection({super.key});

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
                  color: (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue)
                      .withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'ENGINEERING EXCELLENCE',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                    color: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                'Architectural Pillars & Core Strengths',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'How I engineer high-consequence enterprise applications that remain resilient in challenging field environments.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 36),

              // Grid of Pillars
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 3;
                  if (constraints.maxWidth < 650) {
                    crossAxisCount = 1;
                  } else if (constraints.maxWidth < 1000) {
                    crossAxisCount = 2;
                  }

                  final itemWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 20)) / crossAxisCount;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: PortfolioData.engineeringPillars.map((pillar) {
                      return SizedBox(
                        width: itemWidth,
                        child: _buildPillarCard(context, pillar),
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

  Widget _buildPillarCard(BuildContext context, Map<String, dynamic> pillar) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? PortfolioTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? PortfolioTheme.darkBorder : PortfolioTheme.lightBorder,
          width: 1.2,
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue)
                  .withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              pillar['icon'] as IconData,
              color: isDark ? PortfolioTheme.primaryCyan : PortfolioTheme.primaryBlue,
              size: 26,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            pillar['title'] as String,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            pillar['desc'] as String,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.55,
                  color: isDark ? PortfolioTheme.darkTextSecondary : PortfolioTheme.lightTextSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
