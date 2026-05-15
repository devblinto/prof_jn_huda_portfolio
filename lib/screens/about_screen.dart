import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_typography.dart';

/// About / profile tab — hero [about-bg.png], portrait [profs.png], credentials, CTAs.
class AboutScreen extends StatelessWidget {
  const AboutScreen({
    super.key,
    this.onBookAppointment,
    this.onFindClinics,
  });

  final VoidCallback? onBookAppointment;
  final VoidCallback? onFindClinics;

  static const _pageBg = Color(0xFFFDF8F5);
  static const _headingBrown = Color(0xFF605851);
  static const _nameBlack = Color(0xFF000000);
  static const _roleSubtitle = Color(0xFFFCFAF9);
  static const _cardDetail = Color(0xFFA3948A);
  static const _cardBorder = Color(0xFFD0BEB1);
  static const _ctaBg = Color(0xFFE6D5C8);
  static const _ctaText = Color(0xFF4F3F35);

  static const _education = <_Credential>[
    _Credential(
      title: 'MBBS',
      detail: 'Rangpur Medical College • 1977',
    ),
    _Credential(
      title: 'FCPS in Medicine',
      detail: 'Bangladesh College of Physicians & Surgeons • 1985',
    ),
    _Credential(
      title: 'Fellowship in Cardiology',
      detail: 'National Institute of Cardiovascular Diseases • 1992',
    ),
  ];

  static const _experienceRoles = <_Credential>[
    _Credential(
      title: 'Senior Consultant',
      detail: 'Square Hospital • 2020 – Present',
    ),
    _Credential(
      title: 'Specialist',
      detail: 'National Heart Foundation • 2015 – 2020',
    ),
  ];

  static const _experienceCerts = <_Credential>[
    _Credential(
      title: 'Echocardiography Specialist',
      detail: 'International Board of Heart Imaging • 2018',
    ),
  ];

  static const _bio =
      'Prof. M.N. Huda is a pioneering dermatologist recognized across Southeast Asia. '
      'Since beginning his medical career in 1977, he has introduced modern dermatosurgery '
      'and advanced laser therapies to Bangladesh. With decades of global experience, '
      'teaching, and research, he continues to lead the region in innovative dermatological care.';

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _pageBg,
      child: SafeArea(
        top: false,
        bottom: true,
        left: false,
        right: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _ProfileHero()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 80, 16, 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const _SectionTitle('Education'),
                  const SizedBox(height: 10),
                  ..._education.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _CredentialCard(credential: e),
                      )),
                  const SizedBox(height: 20),
                  const _SectionTitle('Experience'),
                  const SizedBox(height: 10),
                  ..._experienceRoles.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _CredentialCard(credential: e),
                      )),
                  const SizedBox(height: 20),
                  const _SectionTitle('Experience'),
                  const SizedBox(height: 10),
                  ..._experienceCerts.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _CredentialCard(credential: e),
                      )),
                  const SizedBox(height: 20),
                  _FooterActions(
                    onBookAppointment: onBookAppointment,
                    onFindClinics: onFindClinics,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Credential {
  const _Credential({required this.title, required this.detail});

  final String title;
  final String detail;
}

class _ProfileHero extends StatelessWidget {
  static const _heroH = 286.0;
  /// Share of the profile card that sits over the hero so it straddles the
  /// banner bottom (reference layout ~30–40% on BG, rest below).
  static const _cardOnHeroFraction = 0.35;

  @override
  Widget build(BuildContext context) {
    final cardTop =
        _heroH - _cardOnHeroFraction * _ProfileCard.estimatedLayoutHeight;
    final stackH = cardTop + _ProfileCard.estimatedLayoutHeight;
    return SizedBox(
      height: stackH,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _heroH,
            child: Image.asset(
              'assets/images/about-bg.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            top: cardTop,
            left: 0,
            right: 0,
            child: LayoutBuilder(
              builder: (context, constraints) {
                const hPad = 16.0;
                var w = constraints.maxWidth;
                if (!w.isFinite || w <= 0) {
                  w = MediaQuery.sizeOf(context).width;
                }
                final cardW = (w - 2 * hPad).clamp(0.0, double.infinity);
                return Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: cardW,
                    child: const _ProfileCard(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  static const _photoH = 308.0;
  /// Used by [_ProfileHero] overlap math (photo + padding + typical bio wrap).
  static const estimatedLayoutHeight = 440.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: const Color(0x33000000),
      borderRadius: BorderRadius.circular(14),
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: _photoH,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/profs.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  Positioned(
                    left: 14,
                    right: 14,
                    bottom: 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Prof. M.N. Huda',
                          style: AppFonts.silkSerif(
                            color: AboutScreen._nameBlack,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Dermatologist, Sexologist & Venereologist',
                          style: AppFonts.poppins(
                            color: AboutScreen._roleSubtitle,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Text(
                AboutScreen._bio,
                style: AppFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AboutScreen._headingBrown,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppFonts.silkSerif(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AboutScreen._nameBlack,
        height: 1.2,
      ),
    );
  }
}

class _CredentialCard extends StatelessWidget {
  const _CredentialCard({required this.credential});

  final _Credential credential;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AboutScreen._cardBorder, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              credential.title,
              style: AppFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AboutScreen._headingBrown,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              credential.detail,
              style: AppFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AboutScreen._cardDetail,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterActions extends StatelessWidget {
  const _FooterActions({
    this.onBookAppointment,
    this.onFindClinics,
  });

  final VoidCallback? onBookAppointment;
  final VoidCallback? onFindClinics;

  static const _iconSize = 18.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _AboutCta(
            svgAsset: 'assets/Icons/book-appoinment.svg',
            label: 'Book Appointment',
            onTap: onBookAppointment,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _AboutCta(
            svgAsset: 'assets/Icons/location.svg',
            label: 'Find Clinics',
            onTap: onFindClinics,
          ),
        ),
      ],
    );
  }
}

class _AboutCta extends StatelessWidget {
  const _AboutCta({
    required this.svgAsset,
    required this.label,
    this.onTap,
  });

  final String svgAsset;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AboutScreen._ctaBg,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgAsset,
                width: _FooterActions._iconSize,
                height: _FooterActions._iconSize,
                colorFilter: const ColorFilter.mode(
                  AboutScreen._ctaText,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AboutScreen._ctaText,
                    height: 1.15,
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
