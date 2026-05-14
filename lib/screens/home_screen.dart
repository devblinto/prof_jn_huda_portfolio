import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_typography.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // No nested Scaffold — MainScreen already provides Scaffold + bottom nav.
    return ColoredBox(
      color: const Color(0xFFFDF8F5),
      child: SafeArea(
        top: false,
        bottom: true,
        left: false,
        right: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _HeroCard(),
              _ServicesSection(),
              _LatestUpdatesSection(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Hero card ───────────────────────────────────────────────────────────────

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  static const _radius = 8.0;

  /// Total height of the hero image / gradient banner (not including cream strip).
  static const _bannerHeight = 286.0;
  static const _ctaRowHeight = 50.0;

  /// Cream strip under banner; fits bottom half of overlapped CTAs + gap.
  static const _ctaStripExtension = _ctaRowHeight / 2 + 14;
  static const _cardShell = Color(0xFFF3EBE4);
  static const _ctaStrip = Color(0xFFFDF8F5);
  static const _ctaBg = Color(0xFFE6D5C8);
  static const _ctaFg = Color(0xFF4A3F38);
  static const _avatarBorder = Color(0xFFD4B483);

  /// Margin below the status bar / notch to the [SKINN] line.
  static const _heroBrandTopPadding = 25.0;

  /// Vertical space between “BY PROF…” and the profile row (fixed design gap).
  static const _heroBrandToProfileGap = 35.0;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: _cardShell,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(_radius),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(_radius),
        ),
        child: SizedBox(
          height: _bannerHeight + _ctaStripExtension,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: _bannerHeight,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/images/home-banner.png',
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.28),
                                  Colors.black.withValues(alpha: 0.18),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: topInset + _heroBrandTopPadding,
                            left: 16,
                            right: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'SKINN',
                                  style: AppFonts.silkSerif(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 5,
                                    height: 1.0,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'BY PROF. M  N HUDA',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white.withValues(alpha: 0.95),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 3.2,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: _heroBrandToProfileGap),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 54,
                                      height: 54,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: _avatarBorder,
                                          width: 2,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/prof.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Prof. M.N. Huda',
                                            style: AppFonts.silkSerif(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                              height: 1.2,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            'Dermatologist & Venereologist',
                                            style: AppFonts.poppins(
                                              color: Colors.white.withValues(
                                                alpha: 0.92,
                                              ),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              height: 1.25,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            '45+ Years Of Excellence',
                                            style: AppFonts.poppins(
                                              color: Colors.white.withValues(
                                                alpha: 0.78,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ColoredBox(
                      color: _ctaStrip,
                      child: SizedBox(
                        height: _ctaStripExtension,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: _bannerHeight - _ctaRowHeight / 2,
                left: 16,
                right: 16,
                height: _ctaRowHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _HeroCtaButton(
                        svgAsset: 'assets/Icons/book-appoinment.svg',
                        label: 'Book Appointment',
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _HeroCtaButton(
                        svgAsset: 'assets/Icons/location.svg',
                        label: 'Find Clinics',
                        onTap: () {},
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
}

class _HeroCtaButton extends StatelessWidget {
  const _HeroCtaButton({
    required this.svgAsset,
    required this.label,
    required this.onTap,
  });

  static const _iconSize = 19.0;

  final String svgAsset;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _HeroCard._ctaBg,
            borderRadius: BorderRadius.circular(_HeroCard._radius),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: _iconSize + 2,
                      height: _iconSize + 2,
                      child: Center(
                        child: SvgPicture.asset(
                          svgAsset,
                          width: _iconSize,
                          height: _iconSize,
                          colorFilter: const ColorFilter.mode(
                            _HeroCard._ctaFg,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      maxLines: 1,
                      style: AppFonts.poppins(
                        color: _HeroCard._ctaFg,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Services section ─────────────────────────────────────────────────────────

class _ServicesSection extends StatelessWidget {
  const _ServicesSection();

  static const _services = [
    _ServiceItem(
      label: 'Clinical Facial',
      assetPath: 'assets/Swervice/clinicalfacial.png',
    ),
    _ServiceItem(
      label: 'Laser Hair Removal',
      assetPath: 'assets/Swervice/Laser Hair Removal.png',
    ),
    _ServiceItem(
      label: 'Exosomes + PDRN',
      assetPath: 'assets/Swervice/Exosomes + PDRN.png',
    ),
    _ServiceItem(
      label: 'Clinical Facial',
      assetPath: 'assets/Swervice/clinicalfacial.png',
    ),
    _ServiceItem(
      label: 'Laser Hair Removal',
      assetPath: 'assets/Swervice/Laser Hair Removal.png',
    ),
    _ServiceItem(
      label: 'Exosomes + PDRN',
      assetPath: 'assets/Swervice/Exosomes + PDRN.png',
    ),
  ];

  static const _sectionBg = Color(0xFFFAF5F0);

  /// Space above the “Services” header row.
  static const _headerTopGap = 24.0;

  /// Space between the header row and the service cards grid.
  /// Negative values pull the grid up (overlap) via [Transform.translate].
  static const _headerBottomGap = -24.0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _sectionBg,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const crossSpacing = 12.0;
            const mainSpacing = 16.0;
            final tileW = (constraints.maxWidth - crossSpacing) / 2;
            const labelBand = 42.0;
            final tileH = _ServiceCard.imageStackHeight(tileW) + labelBand;
            final childAspectRatio = tileW / tileH;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: _headerTopGap),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Services',
                      style: AppFonts.silkSerif(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF000000),
                        height: 1.15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            'View All',
                            style: AppFonts.poppins(
                              fontSize: 18,
                              color: const Color(0xFF6B6B6B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.chevron_right,
                            size: 22,
                            color: Color(0xFF6B6B6B),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_headerBottomGap > 0)
                  SizedBox(height: _headerBottomGap),
                Transform.translate(
                  offset: Offset(
                    0,
                    _headerBottomGap < 0 ? _headerBottomGap : 0,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _services.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: crossSpacing,
                      mainAxisSpacing: mainSpacing,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (_, i) {
                      final s = _services[i];
                      return _ServiceCard(
                        label: s.label,
                        assetPath: s.assetPath,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ServiceItem {
  const _ServiceItem({required this.label, required this.assetPath});

  final String label;
  final String assetPath;
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.label, required this.assetPath});

  final String label;
  final String assetPath;

  static const _radius = 12.0;

  static const _imageOuterGap = 8.0;
  /// No bottom inset here — [_labelImageGap] is the only space under the frame.
  static const _imagePaddingBottom = 0.0;
  static const _imageBorderWidth = 1.0;
  static const _imageBorderColor = Color(0xFFEEE0D6);
  static const _imageInnerTopRadius = 4.0;

  /// Vertical space between the image frame and the service title.
  static const _labelImageGap = 4.0;

  /// Padding + border + image (before [_labelImageGap]), for grid aspect ratio.
  static double imageStackHeight(double cellWidth) {
    final innerW = cellWidth - 2 * _imageOuterGap - 2 * _imageBorderWidth;
    return _imageOuterGap + 2 * _imageBorderWidth + innerW * 0.72;
  }

  static const _shadow = BoxShadow(
    color: Color(0x12000000),
    blurRadius: 12,
    offset: Offset(0, 4),
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final innerW = w - 2 * _imageOuterGap - 2 * _imageBorderWidth;
        final imageBodyH = innerW * 0.72;

        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_radius),
            boxShadow: const [_shadow],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_radius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: imageStackHeight(w),
                  width: w,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      _imageOuterGap,
                      _imageOuterGap,
                      _imageOuterGap,
                      _imagePaddingBottom,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: _imageBorderWidth,
                          color: _imageBorderColor,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(_imageInnerTopRadius),
                          topRight: Radius.circular(_imageInnerTopRadius),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(_imageInnerTopRadius),
                          topRight: Radius.circular(_imageInnerTopRadius),
                        ),
                        child: ColoredBox(
                          color: const Color(0xFFF2EDE8),
                          child: SizedBox(
                            height: imageBodyH,
                            width: double.infinity,
                            child: Image.asset(
                              assetPath,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: _labelImageGap),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        label,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF5A5A5A),
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── Latest updates section ───────────────────────────────────────────────────

class _LatestUpdatesSection extends StatelessWidget {
  const _LatestUpdatesSection();

  static const _updates = [
    _UpdateItem(
      title: 'Spring Offer',
      subtitle: 'Enjoy 15% off all Laser Hair Removal packages',
      date: '24 April 2026 - 30 April 2026',
    ),
    _UpdateItem(
      title: 'Spring Offer',
      subtitle: 'Enjoy 15% off all Laser Hair Removal packages',
      date: '24 April 2026 - 30 April 2026',
    ),
    _UpdateItem(
      title: 'Spring Offer',
      subtitle: 'Enjoy 15% off all Laser Hair Removal packages',
      date: '24 April 2026 - 30 April 2026',
    ),
  ];

  static const _sectionBg = Color(0xFFF8F4F0);

  /// Space above the “Latest Updates” heading (section top inset).
  static const _sectionTopPadding = 1.0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _sectionBg,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          16,
          _sectionTopPadding,
          16,
          8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Latest Updates',
              style: AppFonts.silkSerif(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF000000),
                height: 1.15,
              ),
            ),
            const SizedBox(height: 16),
            ..._updates.map(
              (u) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _UpdateCard(item: u),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpdateItem {
  const _UpdateItem({
    required this.title,
    required this.subtitle,
    required this.date,
  });

  final String title;
  final String subtitle;
  final String date;
}

class _UpdateCard extends StatelessWidget {
  const _UpdateCard({required this.item});

  static const _badgeAsset = 'assets/Icons/25%.png';
  static const _badgeBg = Color(0xFFB68D74);
  static const _divider = Color(0xFFE5DDD6);

  final _UpdateItem item;

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
