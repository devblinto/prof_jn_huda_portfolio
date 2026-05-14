import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_typography.dart';

/// Branch locations and visiting schedule (Clinics tab).
class ClinicsScreen extends StatelessWidget {
  const ClinicsScreen({super.key});

  static const _pageBg = Color(0xFFFDF8F5);
  /// Matches [HomeScreen] hero shell; bottom radius aligns banner with other tabs.
  static const _heroShell = Color(0xFFF3EBE4);
  static const _heroRadius = 8.0;
  /// Same image strip height as [ServicesScreen] hero.
  static const _bannerHeight = 216.0;
  static const _labelBrown = Color(0xFF605851);
  static const _cardSubtitleBrown = Color(0xFF7E736B);
  static const _divider = Color(0xFFEEE0D6);
  static const _directionBtnBg = Color(0xFFE6D2C1);
  static const _bookBtnBg = Color(0xFF605851);

  static const _iconAddress = 'assets/Icons/loca.png';
  static const _iconPhone = 'assets/Icons/phn.png';
  static const _iconVisiting = 'assets/Icons/time.png';

  static final _cardSectionTitleStyle = AppFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: _labelBrown,
    height: 1.25,
  );
  static final _cardSectionBodyStyle = AppFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: _cardSubtitleBrown,
    height: 1.35,
  );

  static const _clinics = <_ClinicBranch>[
    _ClinicBranch(
      address:
          'Navana Trillium, A-11 Plot No. 32/A, Road No. 45, Gulshan 2 (Beside Westin)',
      phones: ['+8801810-168011', '+8801302-700700'],
      visiting: 'Monday',
      mapsQuery: 'Navana Trillium Gulshan 2 Dhaka',
    ),
    _ClinicBranch(
      address: 'Nurjahan Tower, Bangla Motor, Dhaka',
      phones: ['+8801915848333', '+8801719183060'],
      visiting: 'Saturday & Wednesday',
      mapsQuery: 'Nurjahan Tower Bangla Motor Dhaka',
    ),
    _ClinicBranch(
      address: 'Popular, Sec-13, Uttara, Dhaka',
      phones: ['+8801917609010', '+8809666787823'],
      visiting: 'Sunday & Tuesday',
      mapsQuery: 'Popular Diagnostic Centre Sector 13 Uttara Dhaka',
    ),
  ];

  static final Uri _primaryDirections = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent('Navana Trillium Gulshan 2 Dhaka')}',
  );
  static final Uri _primaryDial = Uri.parse('tel:+8801810168011');

  static const _mapPreviewUrl =
      'https://staticmap.openstreetmap.de/staticmap.php?center=23.7937,90.4066&zoom=14&size=640x280&maptype=mapnik&markers=23.7937,90.4066,red-pushpin';

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _pageBg,
      child: SafeArea(
        top: false,
        bottom: true,
        left: false,
        right: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _HeroWithMap(mapUrl: _mapPreviewUrl),
              const SizedBox(height: 78),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _ActionPill(
                        background: _directionBtnBg,
                        foreground: _labelBrown,
                        icon: Icons.near_me_outlined,
                        label: 'Get Direction',
                        onTap: () => _launchExternal(context, _primaryDirections),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionPill(
                        background: _bookBtnBg,
                        foreground: Colors.white,
                        icon: Icons.phone_outlined,
                        label: 'Book Appointment',
                        onTap: () => _launchExternal(context, _primaryDial),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    for (var i = 0; i < _clinics.length; i++) ...[
                      if (i > 0) const SizedBox(height: 16),
                      _ClinicCard(
                        clinic: _clinics[i],
                        onDirections: () => _launchExternal(
                          context,
                          Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(_clinics[i].mapsQuery)}',
                          ),
                        ),
                        onDial: (index) => _launchExternal(
                          context,
                          Uri.parse('tel:${_sanitizeTel(_clinics[i].phones[index])}'),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _sanitizeTel(String display) {
    return display.replaceAll(RegExp(r'[^\d+]'), '');
  }

  static Future<void> _launchExternal(BuildContext context, Uri uri) async {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!context.mounted || ok) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open link')),
    );
  }
}

class _ClinicBranch {
  const _ClinicBranch({
    required this.address,
    required this.phones,
    required this.visiting,
    required this.mapsQuery,
  });

  final String address;
  final List<String> phones;
  final String visiting;
  final String mapsQuery;
}

class _HeroWithMap extends StatelessWidget {
  const _HeroWithMap({required this.mapUrl});

  final String mapUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: ClinicsScreen._heroShell,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(ClinicsScreen._heroRadius),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(ClinicsScreen._heroRadius),
            ),
            child: SizedBox(
              height: ClinicsScreen._bannerHeight,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/Clinics.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.38),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: -68,
          child: Material(
            elevation: 8,
            shadowColor: const Color(0x33000000),
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 132,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      mapUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => ColoredBox(
                        color: const Color(0xFFE8E4DF),
                        child: Icon(
                          Icons.map_outlined,
                          size: 48,
                          color: ClinicsScreen._labelBrown.withValues(alpha: 0.35),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment(0, -0.15),
                      child: Icon(
                        Icons.location_on,
                        color: Color(0xFFE53935),
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.background,
    required this.foreground,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Color background;
  final Color foreground;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: foreground),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: foreground,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClinicCard extends StatelessWidget {
  const _ClinicCard({
    required this.clinic,
    required this.onDirections,
    required this.onDial,
  });

  final _ClinicBranch clinic;
  final VoidCallback onDirections;
  final void Function(int phoneIndex) onDial;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ClinicsScreen._divider),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
        child: Column(
          children: [
            _InfoBlock(
              iconAsset: ClinicsScreen._iconAddress,
              label: 'Address',
              bodyWidget: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onDirections,
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      clinic.address,
                      style: ClinicsScreen._cardSectionBodyStyle,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, color: ClinicsScreen._divider),
            ),
            _InfoBlock(
              iconAsset: ClinicsScreen._iconPhone,
              label: 'Phone',
              bodyWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < clinic.phones.length; i++) ...[
                    if (i > 0) const SizedBox(height: 6),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onDial(i),
                        borderRadius: BorderRadius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            clinic.phones[i],
                            style: ClinicsScreen._cardSectionBodyStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, color: ClinicsScreen._divider),
            ),
            _InfoBlock(
              iconAsset: ClinicsScreen._iconVisiting,
              label: 'Visiting Day',
              body: clinic.visiting,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  const _InfoBlock({
    required this.iconAsset,
    required this.label,
    this.body,
    this.bodyWidget,
  }) : assert(body != null || bodyWidget != null);

  final String iconAsset;
  final String label;
  final String? body;
  final Widget? bodyWidget;

  static const _iconSize = 22.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: _iconSize,
          height: _iconSize,
          child: Image.asset(
            iconAsset,
            width: _iconSize,
            height: _iconSize,
            fit: BoxFit.contain,
            color: ClinicsScreen._labelBrown,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: ClinicsScreen._cardSectionTitleStyle),
              const SizedBox(height: 6),
              if (bodyWidget != null)
                bodyWidget!
              else
                Text(body!, style: ClinicsScreen._cardSectionBodyStyle),
            ],
          ),
        ),
      ],
    );
  }
}
