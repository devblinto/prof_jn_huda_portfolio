import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
              SizedBox(height: 24),
              _ServicesSection(),
              SizedBox(height: 24),
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
  static const _bannerHeight = 258.0;
  static const _ctaRowHeight = 50.0;
  /// Cream strip under banner; fits bottom half of overlapped CTAs + gap.
  static const _ctaStripExtension = _ctaRowHeight / 2 + 14;
  static const _cardShell = Color(0xFFF3EBE4);
  static const _ctaStrip = Color(0xFFFDF8F5);
  static const _ctaBg = Color(0xFFE6D5C8);
  static const _ctaFg = Color(0xFF4A3F38);
  static const _ctaShadow = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 8,
    offset: Offset(0, 3),
  );
  static const _avatarBorder = Color(0xFFD4B483);

  @override
  Widget build(BuildContext context) {
    final statusTop = MediaQuery.paddingOf(context).top;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: _cardShell,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(_radius),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
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
                                    Colors.black.withValues(alpha: 0.52),
                                    Colors.black.withValues(alpha: 0.36),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: statusTop + 8,
                              left: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SKINN',
                                    style: GoogleFonts.playfairDisplay(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 5,
                                      height: 1.0,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'BY PROF. M N HUDA',
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.95,
                                      ),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 3.2,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 16,
                              right: 16,
                              bottom: 58,
                              child: Row(
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
                                          style: GoogleFonts.playfairDisplay(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          'Dermatologist & Venereologist',
                                          style: TextStyle(
                                            color: Colors.white.withValues(
                                              alpha: 0.92,
                                            ),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            height: 1.25,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          '45+ Years Of Excellence',
                                          style: TextStyle(
                                            color: Colors.white.withValues(
                                              alpha: 0.78,
                                            ),
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),
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
            boxShadow: const [_HeroCard._ctaShadow],
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
                      style: const TextStyle(
                        color: _HeroCard._ctaFg,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Services',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                  height: 1.1,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B6B6B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: Color(0xFF6B6B6B),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _services.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              mainAxisExtent: _ServiceCard.gridMainAxisExtent,
            ),
            itemBuilder: (_, i) {
              final s = _services[i];
              return _ServiceCard(label: s.label, assetPath: s.assetPath);
            },
          ),
        ],
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

  static const _radius = 8.0;
  static const _imageInset = 2.0;
  static const _imageWidth = 107.0;
  static const _imageHeight = 91.0;
  static const _innerTopRadius = _radius - _imageInset;

  /// Matches card content: image frame + label row (for grid row height).
  static const double gridMainAxisExtent =
      _imageInset + _imageHeight + _imageInset + 6 + 11 + 10;

  static const _shadow = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 10,
    offset: Offset(0, 4),
  );

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: const [_shadow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_radius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                _imageInset,
                _imageInset,
                _imageInset,
                _imageInset,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(_innerTopRadius),
                    topRight: Radius.circular(_innerTopRadius),
                  ),
                  child: ColoredBox(
                    color: const Color(0xFFF2EDE8),
                    child: Image.asset(
                      assetPath,
                      width: _imageWidth,
                      height: _imageHeight,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 6, 6, 10),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
                  label,
                  maxLines: 1,
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5A5A5A),
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Latest updates section ───────────────────────────────────────────────────

class _LatestUpdatesSection extends StatelessWidget {
  const _LatestUpdatesSection();

  static const _updates = [
    _UpdateItem(
      discount: '25%',
      title: 'Spring Offer',
      subtitle: 'Enjoy 25% off all Laser Hair Removal packages',
      date: '24 April 2025 - 30 April 2025',
    ),
    _UpdateItem(
      discount: '25%',
      title: 'Spring Offer',
      subtitle: 'Enjoy 15% off all Laser Hair Removal packages',
      date: '24 April 2025 - 30 April 2025',
    ),
    _UpdateItem(
      discount: '25%',
      title: 'Spring Offer',
      subtitle: 'Enjoy 15% off all Laser Hair Removal packages',
      date: '24 April 2025 - 30 April 2025',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest updates',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          ..._updates.map((u) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _UpdateCard(item: u),
              )),
        ],
      ),
    );
  }
}

class _UpdateItem {
  const _UpdateItem({
    required this.discount,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  final String discount;
  final String title;
  final String subtitle;
  final String date;
}

class _UpdateCard extends StatelessWidget {
  const _UpdateCard({required this.item});

  final _UpdateItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Discount badge
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFF5EDE4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                item.discount,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFC49A78),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF888888),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  item.date,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFFAAAAAA),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
