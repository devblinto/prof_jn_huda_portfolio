import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F5),
      body: SafeArea(
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          height: 210,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background — splash image reused as hero background
              Image.asset(
                'assets/images/Screen Splash_without_logo.webp',
                fit: BoxFit.cover,
              ),

              // Dark gradient overlay
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xCC000000),
                      Color(0x66000000),
                    ],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand
                    const Text(
                      'SKINN',
                      style: TextStyle(
                        color: Color(0xFFC9A84C),
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 6,
                      ),
                    ),
                    const Text(
                      'BY PROF. M.N HUDA',
                      style: TextStyle(
                        color: Color(0xFFD4B483),
                        fontSize: 9,
                        letterSpacing: 3,
                      ),
                    ),

                    const Spacer(),

                    // Doctor info row
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: const Color(0xFFC9A84C),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Prof. M.N. Huda',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Dermatologist & Venereologist',
                              style: TextStyle(
                                color: Color(0xFFCCCCCC),
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              '40+ Years Of Excellence',
                              style: TextStyle(
                                color: Color(0xFFAAAAAA),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: _HeroButton(
                            icon: Icons.calendar_month_outlined,
                            label: 'Book Appointment',
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _HeroButton(
                            icon: Icons.location_on_outlined,
                            label: 'Find Clinics',
                            onTap: () {},
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
      ),
    );
  }
}

class _HeroButton extends StatelessWidget {
  const _HeroButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 15),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
