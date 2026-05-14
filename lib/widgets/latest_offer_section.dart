import 'package:flutter/material.dart';

import '../theme/app_typography.dart';

/// One row in [LatestOfferSection] (Spring Offer card data).
class OfferItem {
  const OfferItem({
    required this.title,
    required this.subtitle,
    required this.date,
  });

  final String title;
  final String subtitle;
  final String date;
}

/// Offer cards block: configurable heading style + stacked cards (home vs treatments).
class LatestOfferSection extends StatelessWidget {
  const LatestOfferSection({
    super.key,
    this.sectionTopPadding = 1.0,
    this.heading = 'Latest Offer',
    this.horizontalPadding = 16.0,
    this.titleStyle,
  });

  /// Section title (e.g. "Latest Updates" on home, "Latest Offer" on treatments).
  final String heading;

  /// When set (e.g. on Services), matches category subsection titles; otherwise Silk Serif.
  final TextStyle? titleStyle;

  /// Top inset inside the section’s inner [Padding] (below [outerTopMargin] if used).
  final double sectionTopPadding;

  /// Horizontal inset for heading and cards. Use `0` when the parent already pads
  /// (e.g. Services treatments column at 20px).
  final double horizontalPadding;

  static const _offers = [
    OfferItem(
      title: 'Spring Offer',
      subtitle: 'Enjoy 15% off all Laser Hair Removal packages',
      date: '24 April 2026 - 30 April 2026',
    ),
    OfferItem(
      title: 'Spring Offer',
      subtitle: 'Enjoy 15% off all Laser Hair Removal packages',
      date: '24 April 2026 - 30 April 2026',
    ),
    OfferItem(
      title: 'Spring Offer',
      subtitle: 'Enjoy 15% off all Laser Hair Removal packages',
      date: '24 April 2026 - 30 April 2026',
    ),
  ];

  static const _sectionBg = Color(0xFFF8F4F0);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _sectionBg,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          sectionTopPadding,
          horizontalPadding,
          8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: titleStyle ??
                  AppFonts.silkSerif(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF000000),
                    height: 1.15,
                  ),
            ),
            const SizedBox(height: 16),
            ..._offers.map(
              (u) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: OfferCard(item: u),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.item});

  static const _badgeAsset = 'assets/Icons/25%.png';
  static const _badgeBg = Color(0xFFB68D74);
  static const _divider = Color(0xFFE5DDD6);

  final OfferItem item;

  @override
  Widget build(BuildContext context) {
    const radius = 22.0;
    const badgeSize = 72.0;
    const badgeInnerRadius = 8.0;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(width: 1, color: const Color(0xFFEEE0D6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: badgeSize,
              height: badgeSize,
              decoration: BoxDecoration(
                color: _badgeBg,
                borderRadius: BorderRadius.circular(badgeInnerRadius),
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(_badgeAsset, fit: BoxFit.contain),
            ),
            const SizedBox(width: 14),
            Container(width: 1, height: 56, color: _divider),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: AppFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4F3F35),
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.subtitle,
                    style: AppFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF605851),
                      height: 1.35,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.date,
                    style: AppFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFA3948A),
                      height: 1.2,
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
}
