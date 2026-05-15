import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
      shortName: 'Gulshan 2',
      address:
          'Navana Trillium, A-11 Plot No. 32/A, Road No. 45, Gulshan 2 (Beside Westin)',
      phones: ['+8801810-168011', '+8801302-700700'],
      visiting: 'Monday',
      latitude: 23.7936,
      longitude: 90.4063,
    ),
    _ClinicBranch(
      shortName: 'Bangla Motor',
      address: 'Nurjahan Tower, Bangla Motor, Dhaka',
      phones: ['+8801915848333', '+8801719183060'],
      visiting: 'Saturday & Wednesday',
      latitude: 23.7380,
      longitude: 90.3955,
    ),
    _ClinicBranch(
      shortName: 'Uttara',
      address: 'Popular, Sec-13, Uttara, Dhaka',
      phones: ['+8801917609010', '+8809666787823'],
      visiting: 'Sunday & Tuesday',
      latitude: 23.8769,
      longitude: 90.3982,
    ),
  ];

  static final Uri _primaryDial = Uri.parse('tel:+8801810168011');

  static Uri _googleMapsDirectionsUri(_ClinicBranch clinic) {
    return Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination='
      '${clinic.latitude},${clinic.longitude}',
    );
  }

  static Future<void> _showDirectionsPicker(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                  child: Text(
                    'Choose clinic for directions',
                    style: AppFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _labelBrown,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                for (final clinic in _clinics)
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: _labelBrown.withValues(alpha: 0.85),
                    ),
                    title: Text(
                      clinic.shortName,
                      style: AppFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _labelBrown,
                      ),
                    ),
                    subtitle: Text(
                      clinic.address,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: _cardSubtitleBrown,
                        height: 1.35,
                      ),
                    ),
                    onTap: () async {
                      Navigator.of(ctx).pop();
                      await _launchExternal(context, _googleMapsDirectionsUri(clinic));
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> _showClinicOnMapSheet(
    BuildContext context,
    _ClinicBranch clinic,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: _labelBrown.withValues(alpha: 0.85),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        clinic.shortName,
                        style: AppFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: _labelBrown,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  clinic.address,
                  style: _cardSectionBodyStyle,
                ),
                const SizedBox(height: 6),
                Text(
                  'Visiting: ${clinic.visiting}',
                  style: AppFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _cardSubtitleBrown,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () async {
                    Navigator.of(ctx).pop();
                    await _launchExternal(
                      context,
                      _googleMapsDirectionsUri(clinic),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: _bookBtnBg,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.near_me_outlined, size: 20),
                  label: Text(
                    'Get Directions',
                    style: AppFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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

  static void _openFullScreenMap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (ctx) => _ClinicMapFullScreen(
          clinics: _clinics,
          onMarkerTap: (clinic) => _showClinicOnMapSheet(ctx, clinic),
        ),
      ),
    );
  }

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
              _HeroWithMap(
                clinics: _clinics,
                onExpand: () => _openFullScreenMap(context),
                onMarkerTap: (clinic) =>
                    _showClinicOnMapSheet(context, clinic),
              ),
              const SizedBox(height: 96),
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
                        onTap: () => _showDirectionsPicker(context),
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
                          _googleMapsDirectionsUri(_clinics[i]),
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
    required this.shortName,
    required this.address,
    required this.phones,
    required this.visiting,
    required this.latitude,
    required this.longitude,
  });

  final String shortName;
  final String address;
  final List<String> phones;
  final String visiting;
  final double latitude;
  final double longitude;
}

class _HeroWithMap extends StatelessWidget {
  const _HeroWithMap({
    required this.clinics,
    required this.onExpand,
    required this.onMarkerTap,
  });

  final List<_ClinicBranch> clinics;
  final VoidCallback onExpand;
  final void Function(_ClinicBranch clinic) onMarkerTap;

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
                height: 180,
                width: double.infinity,
                child: _ClinicLocationsMap(
                  clinics: clinics,
                  interactive: true,
                  showExpand: true,
                  onExpand: onExpand,
                  onMarkerTap: onMarkerTap,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ClinicMapFullScreen extends StatelessWidget {
  const _ClinicMapFullScreen({
    required this.clinics,
    required this.onMarkerTap,
  });

  final List<_ClinicBranch> clinics;
  final void Function(_ClinicBranch clinic) onMarkerTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClinicsScreen._pageBg,
      appBar: AppBar(
        title: Text(
          'Clinic Locations',
          style: AppFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: ClinicsScreen._labelBrown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _ClinicLocationsMap(
        clinics: clinics,
        interactive: true,
        showExpand: false,
        onMarkerTap: onMarkerTap,
      ),
    );
  }
}

class _ClinicLocationsMap extends StatefulWidget {
  const _ClinicLocationsMap({
    required this.clinics,
    required this.interactive,
    required this.showExpand,
    required this.onMarkerTap,
    this.onExpand,
  });

  final List<_ClinicBranch> clinics;
  final bool interactive;
  final bool showExpand;
  final void Function(_ClinicBranch clinic) onMarkerTap;
  final VoidCallback? onExpand;

  @override
  State<_ClinicLocationsMap> createState() => _ClinicLocationsMapState();
}

class _ClinicLocationsMapState extends State<_ClinicLocationsMap> {
  final _mapController = MapController();
  _ClinicBranch? _selectedClinic;

  LatLngBounds get _bounds => LatLngBounds.fromPoints(
        widget.clinics
            .map((c) => LatLng(c.latitude, c.longitude))
            .toList(),
      );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fitAllClinics());
  }

  void _fitAllClinics() {
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: _bounds,
        padding: const EdgeInsets.all(36),
      ),
    );
    setState(() => _selectedClinic = null);
  }

  void _focusClinic(_ClinicBranch clinic) {
    _mapController.move(
      LatLng(clinic.latitude, clinic.longitude),
      14,
    );
    setState(() => _selectedClinic = clinic);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCameraFit: CameraFit.bounds(
              bounds: _bounds,
              padding: const EdgeInsets.all(36),
            ),
            minZoom: 9,
            maxZoom: 18,
            interactionOptions: InteractionOptions(
              flags: widget.interactive
                  ? InteractiveFlag.all
                  : InteractiveFlag.none,
            ),
            onTap: (_, _) {
              if (_selectedClinic != null) {
                setState(() => _selectedClinic = null);
              }
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.prof_mn_huda',
            ),
            MarkerLayer(
              markers: [
                for (final clinic in widget.clinics)
                  Marker(
                    point: LatLng(clinic.latitude, clinic.longitude),
                    width: _selectedClinic == clinic ? 44 : 36,
                    height: _selectedClinic == clinic ? 44 : 36,
                    child: GestureDetector(
                      onTap: () {
                        _focusClinic(clinic);
                        widget.onMarkerTap(clinic);
                      },
                      child: Icon(
                        Icons.location_on,
                        color: _selectedClinic == clinic
                            ? const Color(0xFFB71C1C)
                            : const Color(0xFFE53935),
                        size: _selectedClinic == clinic ? 44 : 36,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        if (widget.showExpand && widget.onExpand != null)
          Positioned(
            right: 10,
            top: 10,
            child: Material(
              color: Colors.white,
              elevation: 3,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: widget.onExpand,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.fullscreen,
                        size: 18,
                        color: ClinicsScreen._labelBrown,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Expand',
                        style: AppFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ClinicsScreen._labelBrown,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.18),
                  Colors.transparent,
                ],
              ),
            ),
            child: const SizedBox(height: 28),
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
