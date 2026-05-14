import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_typography.dart';
import '../widgets/latest_offer_section.dart';

/// One line in a treatment sub-section grid (e.g. LHR body area, Exosomes service).
class _SubServiceItem {
  const _SubServiceItem({required this.title, required this.thumbAsset});

  final String title;
  final String thumbAsset;
}

/// Services / Treatments tab — hero with [services.png], search, category grid.
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final TextEditingController _searchController = TextEditingController();

  /// Eager init (not [late]) so [IndexedStack] offstage builds cannot hit an uninitialized controller.
  final PageController _treatmentPageController = PageController();

  /// Page 0 defaults to index 0 (All Procedures) so the combined catalog shows on load.
  final List<int> _selectedPerPage = List<int>.filled(
    _treatmentPages.length,
    0,
  );

  int _treatmentPageIndex = 0;

  static const _bgCream = Color(0xFFF9F4EF);

  /// Total height of the hero image strip (design spec).
  static const _bannerHeight = 216.0;
  static const _bannerSearchBottomInset = 16.0;
  static const _headingToSearchGap = 24.0;

  /// Fixed height for bottom search bar layout (matches padding + one line).
  static const _searchBarHeight = 46.0;
  static const _titleBrown = Color(0xFF3D3530);
  static const _indicatorActive = Color(0xFFC49A78);
  static const _indicatorIdle = Color(0xFFE8DDD4);

  /// Three carousel pages of treatments (3×2 grid each; last page may use one empty cell).
  /// Several PNGs use a non-breaking space (U+00A0) before the extension on disk.
  static const _treatmentPages = <List<_CategoryDef>>[
    [
      _CategoryDef(
        label: 'All Procedures',
        imageAsset: 'assets/Services/All Procedures.png',
      ),
      _CategoryDef(
        label: 'Laser Hair Removal',
        imageAsset: 'assets/Services/Laser Hair Removal\u00a0.png',
      ),
      _CategoryDef(
        label: 'Exosomes + PDRN',
        imageAsset: 'assets/Services/Exosomes + PDRN.svg',
      ),
      _CategoryDef(
        label: 'Injectable Item',
        imageAsset: 'assets/Services/Injectable Item\u00a0.png',
      ),
      _CategoryDef(
        label: 'Clinical Facial',
        imageAsset: 'assets/Services/Clinical Facial\u00a0.png',
      ),
      _CategoryDef(
        label: 'Chemical Peeling',
        imageAsset: 'assets/Services/Chemical Peeling\u00a0.png',
      ),
    ],
    [
      _CategoryDef(label: 'PRP', imageAsset: 'assets/Services/PRD.png'),
      _CategoryDef(label: 'CO2', imageAsset: 'assets/Services/CO2\u00a0.png'),
      _CategoryDef(label: 'Botox', imageAsset: 'assets/Services/Botox.png'),
      _CategoryDef(
        label: 'Filler Injectable',
        imageAsset: 'assets/Services/Filler Injectable\u00a0.png',
      ),
      _CategoryDef(
        label: 'Pico Laser',
        imageAsset: 'assets/Services/Pico Laser\u00a0.png',
      ),
      _CategoryDef(
        label: 'Fractional Laser',
        imageAsset: 'assets/Services/Fractional Laser\u00a0.png',
      ),
    ],
    [
      _CategoryDef(
        label: 'Xanthelasma',
        imageAsset: 'assets/Services/Xanthelasma\u00a0.png',
      ),
      _CategoryDef(
        label: 'Microdermabrasion',
        imageAsset: 'assets/Services/Microdermabrasion\u00a0.png',
      ),
      _CategoryDef(
        label: 'Exciplex',
        imageAsset: 'assets/Services/Exciplex\u00a0.png',
      ),
      _CategoryDef(
        label: 'Excision',
        imageAsset: 'assets/Services/Excision\u00a0\u00a0.png',
      ),
      _CategoryDef(
        label: 'Others',
        imageAsset: 'assets/Services/Others\u00a0.png',
      ),
    ],
  ];

  static const _gridCrossAxisCount = 3;
  static const _gridMainAxisSpacing = 14.0;
  static const _gridCrossAxisSpacing = 14.0;

  /// Fixed treatment category tile size (design spec).
  static const _treatmentCardWidth = 115.0;
  static const _treatmentCardHeight = 86.0;

  /// Width of one row: [crossAxisCount] tiles + spacers.
  static const _treatmentGridRowWidth =
      _gridCrossAxisCount * _treatmentCardWidth +
      (_gridCrossAxisCount - 1) * _gridCrossAxisSpacing;

  /// Category switch icons in the Treatments grid (matches design: 31×31).
  static const _treatmentCategoryIconSize = 31.0;

  /// Body-area rows for [Laser Hair Removal] (thumbnails from [assets/Hair Removal/] where available).
  static const _laserHairRemovalSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'LHR abdomen',
      thumbAsset: 'assets/Hair Removal/LHR abdomen.png',
    ),
    _SubServiceItem(
      title: 'LHR bikini',
      thumbAsset: 'assets/Hair Removal/LHR bikini.png',
    ),
    _SubServiceItem(
      title: 'LHR cheeks',
      thumbAsset: 'assets/Hair Removal/LHR cheeks.png',
    ),
    _SubServiceItem(
      title: 'LHR chin',
      thumbAsset: 'assets/Hair Removal/LHR chin.png',
    ),
    _SubServiceItem(
      title: 'LHR Both Full Arms',
      thumbAsset: 'assets/Hair Removal/LHR Both Full Arms.png',
    ),
    _SubServiceItem(
      title: 'LHR full back',
      thumbAsset: 'assets/Hair Removal/LHR full back.png',
    ),
    _SubServiceItem(
      title: 'LHR full body & face',
      thumbAsset: 'assets/Hair Removal/LHR full body & face.png',
    ),
    _SubServiceItem(
      title: 'LHR full body excluding face',
      thumbAsset: 'assets/Hair Removal/LHR full body excluding face.png',
    ),
    _SubServiceItem(
      title: 'LHR full chest',
      thumbAsset: 'assets/Hair Removal/LHR full chest.png',
    ),
    _SubServiceItem(
      title: 'LHR full face & neck',
      thumbAsset: 'assets/Hair Removal/LHR full face & neck.png',
    ),
    _SubServiceItem(
      title: 'LHR full face',
      thumbAsset: 'assets/Hair Removal/LHR full face.png',
    ),
    _SubServiceItem(
      title: 'LHR Forearm',
      thumbAsset: 'assets/Hair Removal/LHR Forearm.png',
    ),
    _SubServiceItem(
      title: 'LHR under arms',
      thumbAsset: 'assets/Hair Removal/LHR under arms.png',
    ),
    _SubServiceItem(
      title: 'LHR Half legs',
      thumbAsset: 'assets/Hair Removal/LHR Half legs.png',
    ),
    _SubServiceItem(
      title: 'LHR upper lip',
      thumbAsset: 'assets/Hair Removal/LHR upper lip.png',
    ),
    _SubServiceItem(
      title: 'LHR full legs',
      thumbAsset: 'assets/Hair Removal/LHR full legs.png',
    ),
    _SubServiceItem(
      title: 'LHR neck (front back)',
      thumbAsset: 'assets/Hair Removal/LHR neck (front back).png',
    ),
    _SubServiceItem(
      title: 'LHR Both Hands',
      thumbAsset: 'assets/Hair Removal/LHR Both Hands.png',
    ),
    _SubServiceItem(
      title: 'LHR shoulders',
      thumbAsset: 'assets/Hair Removal/LHR shoulders.png',
    ),
    _SubServiceItem(
      title: 'LHR Both Feet',
      thumbAsset: 'assets/Hair Removal/LHR Both Feet.png',
    ),
    _SubServiceItem(
      title: 'LHR Forehead',
      thumbAsset: 'assets/Hair Removal/LHR Forehead.png',
    ),
    _SubServiceItem(
      title: 'LHR Both Buttocks',
      thumbAsset: 'assets/Hair Removal/LHR Both Buttocks.png',
    ),
    _SubServiceItem(
      title: 'LHR Sideburn',
      thumbAsset: 'assets/Hair Removal/LHR Sideburn.png',
    ),
    _SubServiceItem(
      title: 'LHR Thighs',
      thumbAsset: 'assets/Hair Removal/LHR Thighs.png',
    ),
  ];

  static const _exosomesPdrnSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'Exosome with PDRN with GFP for Hair with LED Light',
      thumbAsset:
          'assets/PDRN/Exosome with PDRN with GFP for Hair with LED Light.png',
    ),
    _SubServiceItem(
      title: 'T-Lab Exosomes + Hair PRP Treatment and LED light',
      thumbAsset:
          'assets/PDRN/T-Lab Exosomes + Hair PRP Treatment and LED light.png',
    ),
    _SubServiceItem(
      title:
          'Tlab Exosomes + PDRN for Face Mesotherapy Treatment and LED light',
      thumbAsset:
          'assets/PDRN/Tlab Exosomes + PDRN for Face Mesotherapy Treatment and LED light.png',
    ),
    _SubServiceItem(
      title: 'Exosome with PDRN with GFP Face with LED Light',
      thumbAsset:
          'assets/PDRN/Exosome with PDRN with GFP Face with LED Light.png',
    ),
  ];

  static const _clinicalFacialSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'BTL Emfusion',
      thumbAsset: 'assets/Clinical/BTL Emfusion.png',
    ),
    _SubServiceItem(
      title: 'Advance Hydrafacial & LED Therapy',
      thumbAsset: 'assets/Clinical/Advance Hydrafacial & LED Therapy.png',
    ),
    _SubServiceItem(
      title: 'Advance carbon facial with PicoStar',
      thumbAsset:
          'assets/Clinical/Advance carbon facial with PicoStar.png',
    ),
  ];

  static const _injectableItemSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'Brightening IV Drip - Advance Swiss Glutathione',
      thumbAsset:
          'assets/njectable/Brightening IV Drip - Advance Swiss Glutathione.png',
    ),
    _SubServiceItem(
      title: 'Lipolytic Injection For Abdomen (20ml)',
      thumbAsset:
          'assets/njectable/Lipolytic Injection For Abdomen (20ml).png',
    ),
    _SubServiceItem(
      title: 'Keloid scar treatment - injection',
      thumbAsset:
          'assets/njectable/Keloid scar treatment - injection.png',
    ),
    _SubServiceItem(
      title: 'Mesotherapy with microneedling',
      thumbAsset:
          'assets/njectable/Mesotheraphy with microneedling.png',
    ),
    _SubServiceItem(
      title: 'NAD +',
      thumbAsset: 'assets/njectable/NAD +.png',
    ),
    _SubServiceItem(
      title: 'Lipolytic Injection For Double Chin (10ml)',
      thumbAsset:
          'assets/njectable/Lipolytic Injection For Double Chin (10ml).png',
    ),
    _SubServiceItem(
      title: 'PROFHILO Skin Booster (European)',
      thumbAsset:
          'assets/njectable/PROFHILO Skin Booster (European).png',
    ),
    _SubServiceItem(
      title: 'Skin Booster (Korean)',
      thumbAsset: 'assets/njectable/Skin Booster (Korean).png',
    ),
  ];

  static const _chemicalPeelingSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'Chemical Peeling Face',
      thumbAsset: 'assets/Chemical/Chemical Peeling Face.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Neck',
      thumbAsset: 'assets/Chemical/Chemical Peeling Neck.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Full Leg',
      thumbAsset: 'assets/Chemical/Chemical Peeling Full Leg.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peel Arms',
      thumbAsset: 'assets/Chemical/Chemical Peel Arms.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Feet',
      thumbAsset: 'assets/Chemical/Chemical Peeling Feet.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Knee',
      thumbAsset: 'assets/Chemical/Chemical Peeling Knee.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peel Bikini Area',
      thumbAsset: 'assets/Chemical/Chemical Peel Bikini Area.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peel Under arms',
      thumbAsset: 'assets/Chemical/Chemical Peel Under arms.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Half Legs',
      thumbAsset: 'assets/Chemical/Chemical Peeling Half Legs.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Half Legs',
      thumbAsset: 'assets/Chemical/Chemical Peeling Half Legs.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Buttock',
      thumbAsset: 'assets/Chemical/Chemical Peeling Buttock.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Face and Neck',
      thumbAsset: 'assets/Chemical/Chemical Peeling Face and Neck.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Full Back',
      thumbAsset: 'assets/Chemical/Chemical Peeling Full Back.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Hand',
      thumbAsset: 'assets/Chemical/Chemical Peeling Hand.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Upper back',
      thumbAsset: 'assets/Chemical/Chemical Peeling Upper back.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Forearm',
      thumbAsset: 'assets/Chemical/Chemical Peeling Forearm.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Under Eye',
      thumbAsset: 'assets/Chemical/Chemical Peeling Under Eye.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Elbow',
      thumbAsset: 'assets/Chemical/Chemical Peeling Elbow.png',
    ),
    _SubServiceItem(
      title: 'Chemical Peeling Lips',
      thumbAsset: 'assets/Chemical/Chemical Peeling Lips.png',
    ),
  ];

  static const _prpSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'PRP for Face with LED Light',
      thumbAsset: 'assets/PRP/PRP for Face with LED Light.png',
    ),
    _SubServiceItem(
      title: 'PRP for Hair',
      thumbAsset: 'assets/PRP/PRP for Hair.png',
    ),
    _SubServiceItem(
      title: 'PRP Under Eyes with Led Light',
      thumbAsset: 'assets/PRP/PRP Under Eyes with Led Light.png',
    ),
    _SubServiceItem(
      title: 'PRP body small area with Led Light',
      thumbAsset: 'assets/PRP/PRP body small area with Led Light.png',
    ),
    _SubServiceItem(
      title: 'PRP for Face & Hair with Led Light',
      thumbAsset: 'assets/PRP/PRP for Face & Hair with Led Light.png',
    ),
    _SubServiceItem(
      title: 'PRP Microneedling with LED light',
      thumbAsset: 'assets/PRP/PRP Microneedling with LED light.png',
    ),
    _SubServiceItem(
      title: 'PRP body large area with Led Light',
      thumbAsset: 'assets/PRP/PRP body large area with Led Light.png',
    ),
    _SubServiceItem(
      title: 'PRF Under Eye with LED light',
      thumbAsset: 'assets/PRP/PRF Under Eye with LED light.png',
    ),
    _SubServiceItem(
      title: 'PRP for Face & Neck with Led Light',
      thumbAsset: 'assets/PRP/PRP for Face & Neck with Led Light.png',
    ),
  ];

  static const _co2SubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'CO2 Laser Surgery for Skin Tag',
      thumbAsset: 'assets/CO2/CO2 Laser Surgery for Skin Tag.png',
    ),
    _SubServiceItem(
      title: 'CO2 Laser Additional Added 1 PC',
      thumbAsset: 'assets/CO2/CO2 Laser Additional Added 1 PC.png',
    ),
    _SubServiceItem(
      title: 'CO2 Laser for single lesion',
      thumbAsset: 'assets/CO2/CO2 Laser for single lesion.png',
    ),
  ];

  static const _botoxSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'Botox Korean (Upper/ Lower) 50 units',
      thumbAsset: 'assets/Botox/Botox Korean.png',
    ),
    _SubServiceItem(
      title: 'Botox European (upper/lower face) 50 unit',
      thumbAsset: 'assets/Botox/Botox European.png',
    ),
  ];

  static const _fillerInjectableSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'European Filler per syringe',
      thumbAsset: 'assets/Filler/European Filler per syringe.png',
    ),
    _SubServiceItem(
      title: 'Korean Filler per syringe',
      thumbAsset: 'assets/Filler/Korean Filler per syringe.png',
    ),
  ];

  static const _picoLaserSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'Pico Star Laser for Small Area',
      thumbAsset: 'assets/Pico Laser/Pico Star Laser for Small Area.png',
    ),
    _SubServiceItem(
      title: 'Pico Star Laser for Medium Area',
      thumbAsset: 'assets/Pico Laser/Pico Star Laser for Medium Area.png',
    ),
    _SubServiceItem(
      title: 'Pico Star Laser for Large Area',
      thumbAsset: 'assets/Pico Laser/Pico Star Laser for Large Area.png',
    ),
  ];

  static const _fractionalLaserSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'Fractional advance using Fotona (large)',
      thumbAsset:
          'assets/Fractional Laser/Fractional advance using Fotona (large).png',
    ),
    _SubServiceItem(
      title: 'Fractional advance using Fotona (medium)',
      thumbAsset:
          'assets/Fractional Laser/Fractional advance using Fotona (medium).png',
    ),
    _SubServiceItem(
      title: 'Fractional advance using Fotona (small)',
      thumbAsset:
          'assets/Fractional Laser/Fractional advance using Fotona (small).png',
    ),
    _SubServiceItem(
      title: 'Fractional using co2 large area',
      thumbAsset:
          'assets/Fractional Laser/Fractional using co2 large area.png',
    ),
    _SubServiceItem(
      title: 'Fractional using co2 medium area',
      thumbAsset:
          'assets/Fractional Laser/Fractional using co2 medium area.png',
    ),
    _SubServiceItem(
      title: 'Fractional using CO2 Laser small area',
      thumbAsset:
          'assets/Fractional Laser/Fractional using CO2 Laser small area.png',
    ),
    _SubServiceItem(
      title: 'Under Eye Fractional Advance with Fotona',
      thumbAsset:
          'assets/Fractional Laser/Under Eye Fractional Advance with Fotona.png',
    ),
    _SubServiceItem(
      title: 'Lips Fractional advance with Fotona',
      thumbAsset:
          'assets/Fractional Laser/Lips Fractional advance with Fotona.png',
    ),
  ];

  static const _xanthelasmaSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'Excision for Single Eye Small Area',
      thumbAsset:
          'assets/Xanthelasma/Excision for Single Eye Small Area.png',
    ),
    _SubServiceItem(
      title: 'Excision for Single Eye Medium to Large Area',
      thumbAsset:
          'assets/Xanthelasma/Excision for Single Eye Medium to Large Area.png',
    ),
  ];

  static const _microdermabrasionSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'Microdermabrasion with Led Light Therapy for face & neck',
      thumbAsset:
          'assets/Microdermabrasion/Microdermabrasion with Led Light Therapy For face & neck.png',
    ),
    _SubServiceItem(
      title: 'Microdermabrasion Upper Back',
      thumbAsset:
          'assets/Microdermabrasion/Microdermabrasion Upper Back.png',
    ),
    _SubServiceItem(
      title: 'Microdermabrasion Full Back',
      thumbAsset:
          'assets/Microdermabrasion/Microdermabrasion Full Back.png',
    ),
    _SubServiceItem(
      title: 'Microdermabrasion Full Arm',
      thumbAsset:
          'assets/Microdermabrasion/Microdermabrasion Full Arm.png',
    ),
    _SubServiceItem(
      title: 'Microdermabrasion Full Leg',
      thumbAsset:
          'assets/Microdermabrasion/Microdermabrasion Full Leg.png',
    ),
    _SubServiceItem(
      title: 'Microdermabrasion Half Leg',
      thumbAsset:
          'assets/Microdermabrasion/Microdermabrasion Half Leg.png',
    ),
    _SubServiceItem(
      title: 'Microdermabrasion Forearm',
      thumbAsset:
          'assets/Microdermabrasion/Microdermabrasion Forearm.png',
    ),
  ];

  static const _exciplexSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'Exciplex (large area)',
      thumbAsset: 'assets/Exciplex/Exciplex (large area).png',
    ),
    _SubServiceItem(
      title: 'Exciplex (medium area)',
      thumbAsset: 'assets/Exciplex/Exciplex (medium area).png',
    ),
    _SubServiceItem(
      title: 'Exciplex (small area)',
      thumbAsset: 'assets/Exciplex/Exciplex (small area).png',
    ),
    _SubServiceItem(
      title: 'Exciplex test',
      thumbAsset: 'assets/Exciplex/Exciplex test.png',
    ),
  ];

  static const _excisionSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'Excision',
      thumbAsset: 'assets/Excision/Excision\u00a0.png',
    ),
  ];

  static const _othersSubItems = <_SubServiceItem>[
    _SubServiceItem(
      title: 'Single Nail Avulsion',
      thumbAsset: 'assets/Others/Single Nail Avulsion.png',
    ),
    _SubServiceItem(
      title: 'Face Analysing Test with Doctor consultation',
      thumbAsset:
          'assets/Others/Face Analysing Test with Doctor consultation.png',
    ),
    _SubServiceItem(
      title: 'Advance Hair Growth Booster',
      thumbAsset: 'assets/Others/Advance Hair Growth Booster.png',
    ),
    _SubServiceItem(
      title: 'Dermoscopy Test',
      thumbAsset: 'assets/Others/Dermoscopy Test.png',
    ),
    _SubServiceItem(
      title: "Wood's Lamp examination with report and doctor consultation",
      thumbAsset:
          "assets/Others/Wood's Lamp examination with report and doctor consultation.png",
    ),
  ];

  /// Same groupings as [All Procedures] — used for global treatment search.
  static const _treatmentSearchCatalog =
      <({String section, List<_SubServiceItem> items})>[
        (section: 'Laser Hair Removal', items: _laserHairRemovalSubItems),
        (section: 'Exosomes + PDRN', items: _exosomesPdrnSubItems),
        (section: 'Injectable Item', items: _injectableItemSubItems),
        (section: 'Clinical Facial', items: _clinicalFacialSubItems),
        (section: 'Chemical Peeling', items: _chemicalPeelingSubItems),
        (section: 'PRP', items: _prpSubItems),
        (section: 'CO2', items: _co2SubItems),
        (section: 'Botulinum toxin Injectable', items: _botoxSubItems),
        (section: 'Filler Injectable', items: _fillerInjectableSubItems),
        (section: 'Pico Laser', items: _picoLaserSubItems),
        (section: 'Fractional Laser', items: _fractionalLaserSubItems),
        (section: 'Xanthelasma', items: _xanthelasmaSubItems),
        (section: 'Microdermabrasion', items: _microdermabrasionSubItems),
        (section: 'Exciplex', items: _exciplexSubItems),
        (section: 'Excision', items: _excisionSubItems),
        (section: 'Others', items: _othersSubItems),
      ];

  static const _subGridCrossAxisCount = 2;
  static const _subGridMainAxisSpacing = 14.0;
  static const _subGridCrossAxisSpacing = 14.0;
  static const _subRowHeight = 72.0;

  _CategoryDef? _visibleSelectedCategory() {
    final pi = _treatmentPageIndex;
    if (pi < 0 || pi >= _treatmentPages.length) return null;
    final page = _treatmentPages[pi];
    final si = _selectedPerPage[pi];
    if (si < 0 || si >= page.length) return null;
    return page[si];
  }

  double _twoColSubGridHeight(int itemCount) {
    final rows = (itemCount / _subGridCrossAxisCount).ceil();
    return rows * _subRowHeight + (rows - 1) * _subGridMainAxisSpacing;
  }

  static final _subSectionTitleStyle =
      AppFonts.servicesCategoryTitle(color: _titleBrown);

  Widget _headingAndBody(String heading, Widget body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 28),
        Text(heading, style: _subSectionTitleStyle),
        const SizedBox(height: 16),
        body,
      ],
    );
  }

  Widget _lhrGridSized() {
    return SizedBox(
      height: _twoColSubGridHeight(_laserHairRemovalSubItems.length),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _subGridCrossAxisCount,
          mainAxisSpacing: _subGridMainAxisSpacing,
          crossAxisSpacing: _subGridCrossAxisSpacing,
          mainAxisExtent: _subRowHeight,
        ),
        itemCount: _laserHairRemovalSubItems.length,
        itemBuilder: (context, i) {
          final item = _laserHairRemovalSubItems[i];
          return _TreatmentSubServiceRow(
            title: item.title,
            thumbAsset: item.thumbAsset,
          );
        },
      ),
    );
  }

  Widget _twoColItemsGrid(List<_SubServiceItem> items) {
    return SizedBox(
      height: _twoColSubGridHeight(items.length),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _subGridCrossAxisCount,
          mainAxisSpacing: _subGridMainAxisSpacing,
          crossAxisSpacing: _subGridCrossAxisSpacing,
          mainAxisExtent: _subRowHeight,
        ),
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          return _TreatmentSubServiceRow(
            title: item.title,
            thumbAsset: item.thumbAsset,
          );
        },
      ),
    );
  }

  Widget _othersGridColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _TreatmentSubServiceRow(
                title: _othersSubItems[0].title,
                thumbAsset: _othersSubItems[0].thumbAsset,
              ),
            ),
            const SizedBox(width: _subGridCrossAxisSpacing),
            Expanded(
              child: _TreatmentSubServiceRow(
                title: _othersSubItems[1].title,
                thumbAsset: _othersSubItems[1].thumbAsset,
              ),
            ),
          ],
        ),
        SizedBox(height: _subGridMainAxisSpacing),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _TreatmentSubServiceRow(
                title: _othersSubItems[2].title,
                thumbAsset: _othersSubItems[2].thumbAsset,
              ),
            ),
            const SizedBox(width: _subGridCrossAxisSpacing),
            Expanded(
              child: _TreatmentSubServiceRow(
                title: _othersSubItems[3].title,
                thumbAsset: _othersSubItems[3].thumbAsset,
              ),
            ),
          ],
        ),
        SizedBox(height: _subGridMainAxisSpacing),
        _TreatmentSubServiceRow(
          title: _othersSubItems[4].title,
          thumbAsset: _othersSubItems[4].thumbAsset,
        ),
      ],
    );
  }

  Iterable<Widget> _allProceduresSubSections() sync* {
    if (_visibleSelectedCategory()?.label != 'All Procedures') {
      return;
    }
    yield _headingAndBody('Laser Hair Removal', _lhrGridSized());
    yield _headingAndBody(
      'Exosomes + PDRN',
      _twoColItemsGrid(_exosomesPdrnSubItems),
    );
    yield _headingAndBody(
      'Injectable Item',
      _twoColItemsGrid(_injectableItemSubItems),
    );
    yield _headingAndBody(
      'Clinical Facial',
      _twoColItemsGrid(_clinicalFacialSubItems),
    );
    yield _headingAndBody(
      'Chemical Peeling',
      _twoColItemsGrid(_chemicalPeelingSubItems),
    );
    yield _headingAndBody('PRP', _twoColItemsGrid(_prpSubItems));
    yield _headingAndBody('CO2', _twoColItemsGrid(_co2SubItems));
    yield _headingAndBody(
      'Botulinum toxin Injectable',
      _twoColItemsGrid(_botoxSubItems),
    );
    yield _headingAndBody(
      'Filler Injectable',
      _twoColItemsGrid(_fillerInjectableSubItems),
    );
    yield _headingAndBody('Pico Laser', _twoColItemsGrid(_picoLaserSubItems));
    yield _headingAndBody(
      'Fractional Laser',
      _twoColItemsGrid(_fractionalLaserSubItems),
    );
    yield _headingAndBody(
      'Xanthelasma',
      _twoColItemsGrid(_xanthelasmaSubItems),
    );
    yield _headingAndBody(
      'Microdermabrasion',
      _twoColItemsGrid(_microdermabrasionSubItems),
    );
    yield _headingAndBody('Exciplex', _twoColItemsGrid(_exciplexSubItems));
    yield _headingAndBody('Excision', _twoColItemsGrid(_excisionSubItems));
    yield _headingAndBody('Others', _othersGridColumn());
  }

  Iterable<Widget> _lhrSubSection() sync* {
    if (_visibleSelectedCategory()?.label != 'Laser Hair Removal') {
      return;
    }
    yield _headingAndBody('Laser Hair Removal', _lhrGridSized());
  }

  Iterable<Widget> _twoColItemsSubSection(
    String categoryLabel,
    String heading,
    List<_SubServiceItem> items,
  ) sync* {
    if (_visibleSelectedCategory()?.label != categoryLabel) {
      return;
    }
    yield _headingAndBody(heading, _twoColItemsGrid(items));
  }

  Iterable<Widget> _othersSubSection() sync* {
    if (_visibleSelectedCategory()?.label != 'Others') {
      return;
    }
    yield _headingAndBody('Others', _othersGridColumn());
  }

  String get _searchQueryNorm => _searchController.text.trim().toLowerCase();

  bool get _isTreatmentSearchActive => _searchQueryNorm.isNotEmpty;

  Iterable<Widget> _searchResultSections() sync* {
    final q = _searchQueryNorm;
    if (q.isEmpty) {
      return;
    }
    var any = false;
    for (final entry in _treatmentSearchCatalog) {
      final sectionL = entry.section.toLowerCase();
      final filtered = entry.items
          .where(
            (e) =>
                e.title.toLowerCase().contains(q) || sectionL.contains(q),
          )
          .toList();
      if (filtered.isEmpty) {
        continue;
      }
      any = true;
      yield _headingAndBody(entry.section, _twoColItemsGrid(filtered));
    }
    if (!any) {
      yield Padding(
        padding: const EdgeInsets.only(top: 28),
        child: Center(
          child: Text(
            'No treatments found',
            textAlign: TextAlign.center,
            style: AppFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8A827C),
              height: 1.3,
            ),
          ),
        ),
      );
    }
  }

  void _onSearchTextChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    _treatmentPageController.dispose();
    super.dispose();
  }

  double _treatmentGridHeight(int itemCount) {
    final rows = (itemCount / _gridCrossAxisCount).ceil();
    return rows * _treatmentCardHeight + (rows - 1) * _gridMainAxisSpacing;
  }

  Future<void> _goToTreatmentPage(int index) async {
    await _treatmentPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxTreatmentItems = _treatmentPages.fold<int>(
      0,
      (m, p) => m > p.length ? m : p.length,
    );
    final treatmentGridHeight = _treatmentGridHeight(maxTreatmentItems);

    return ColoredBox(
      color: _bgCream,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: _bannerHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/services.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.38),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom:
                        _bannerSearchBottomInset +
                        _searchBarHeight +
                        _headingToSearchGap,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SKINN',
                          style: AppFonts.silkSerif(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 4,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Treatments',
                          style: AppFonts.silkSerif(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: _bannerSearchBottomInset,
                    child: SizedBox(
                      height: _searchBarHeight,
                      child: _SearchField(controller: _searchController),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Treatments',
                    style: AppFonts.silkSerif(
                      color: _titleBrown,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: treatmentGridHeight,
                    child: PageView.builder(
                      controller: _treatmentPageController,
                      itemCount: _treatmentPages.length,
                      onPageChanged: (i) {
                        setState(() => _treatmentPageIndex = i);
                      },
                      itemBuilder: (context, pageIndex) {
                        final page = _treatmentPages[pageIndex];
                        final slotCount =
                            ((page.length + _gridCrossAxisCount - 1) ~/
                                _gridCrossAxisCount) *
                            _gridCrossAxisCount;
                        return Center(
                          child: SizedBox(
                            width: _treatmentGridRowWidth,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: _gridCrossAxisCount,
                                    mainAxisSpacing: _gridMainAxisSpacing,
                                    crossAxisSpacing: _gridCrossAxisSpacing,
                                    mainAxisExtent: _treatmentCardHeight,
                                  ),
                              itemCount: slotCount,
                              itemBuilder: (context, index) {
                                if (index >= page.length) {
                                  return const IgnorePointer(
                                    child: SizedBox.expand(),
                                  );
                                }
                                final def = page[index];
                                final selected =
                                    index == _selectedPerPage[pageIndex];
                                return _TreatmentCard(
                                  label: def.label,
                                  selected: selected,
                                  onTap: () => setState(
                                    () => _selectedPerPage[pageIndex] = index,
                                  ),
                                  child: def.imageAsset != null
                                      ? def.imageAsset!.endsWith('.svg')
                                            ? SvgPicture.asset(
                                                def.imageAsset!,
                                                width:
                                                    _treatmentCategoryIconSize,
                                                height:
                                                    _treatmentCategoryIconSize,
                                                fit: BoxFit.contain,
                                                alignment: Alignment.center,
                                              )
                                            : Image.asset(
                                                def.imageAsset!,
                                                width:
                                                    _treatmentCategoryIconSize,
                                                height:
                                                    _treatmentCategoryIconSize,
                                                fit: BoxFit.contain,
                                                alignment: Alignment.center,
                                              )
                                      : Icon(
                                          def.icon,
                                          size: _treatmentCategoryIconSize,
                                          color: def.iconColor(selected),
                                        ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(_treatmentPages.length, (i) {
                        final active = i == _treatmentPageIndex;
                        return Padding(
                          padding: EdgeInsets.only(left: i == 0 ? 0 : 8),
                          child: GestureDetector(
                            onTap: () => _goToTreatmentPage(i),
                            behavior: HitTestBehavior.opaque,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOutCubic,
                              width: active ? 28 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: active
                                    ? _indicatorActive
                                    : _indicatorIdle,
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  if (_isTreatmentSearchActive) ..._searchResultSections() else ...[
                    ..._allProceduresSubSections(),
                    ..._lhrSubSection(),
                    ..._twoColItemsSubSection(
                      'Exosomes + PDRN',
                      'Exosomes + PDRN',
                      _exosomesPdrnSubItems,
                    ),
                    ..._twoColItemsSubSection(
                      'Clinical Facial',
                      'Clinical Facial',
                      _clinicalFacialSubItems,
                    ),
                    ..._twoColItemsSubSection(
                      'Injectable Item',
                      'Injectable Item',
                      _injectableItemSubItems,
                    ),
                    ..._twoColItemsSubSection(
                      'Chemical Peeling',
                      'Chemical Peeling',
                      _chemicalPeelingSubItems,
                    ),
                    ..._twoColItemsSubSection('PRP', 'PRP', _prpSubItems),
                    ..._twoColItemsSubSection('CO2', 'CO2', _co2SubItems),
                    ..._twoColItemsSubSection(
                      'Botox',
                      'Botulinum toxin Injectable',
                      _botoxSubItems,
                    ),
                    ..._twoColItemsSubSection(
                      'Filler Injectable',
                      'Filler Injectable',
                      _fillerInjectableSubItems,
                    ),
                    ..._twoColItemsSubSection(
                      'Pico Laser',
                      'Pico Laser',
                      _picoLaserSubItems,
                    ),
                    ..._twoColItemsSubSection(
                      'Fractional Laser',
                      'Fractional Laser',
                      _fractionalLaserSubItems,
                    ),
                    ..._twoColItemsSubSection(
                      'Xanthelasma',
                      'Xanthelasma',
                      _xanthelasmaSubItems,
                    ),
                    ..._twoColItemsSubSection(
                      'Microdermabrasion',
                      'Microdermabrasion',
                      _microdermabrasionSubItems,
                    ),
                    ..._twoColItemsSubSection(
                      'Exciplex',
                      'Exciplex',
                      _exciplexSubItems,
                    ),
                    ..._twoColItemsSubSection(
                      'Excision',
                      'Excision',
                      _excisionSubItems,
                    ),
                    ..._othersSubSection(),
                  ],
                  if (_visibleSelectedCategory() != null &&
                      !_isTreatmentSearchActive)
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: LatestOfferSection(
                        sectionTopPadding: 0,
                        horizontalPadding: 0,
                        titleStyle: _subSectionTitleStyle,
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

class _CategoryDef {
  const _CategoryDef({required this.label, this.icon, this.imageAsset})
    : assert(icon != null || imageAsset != null);

  final String label;
  final IconData? icon;
  final String? imageAsset;

  Color iconColor(bool selected) =>
      selected ? const Color(0xFF4A3F38) : const Color(0xFF6B6560);
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});

  final TextEditingController controller;

  static const _hintGray = Color(0xFFB0A8A4);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(999),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 16, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                cursorColor: const Color(0xFF4A3F38),
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                style: AppFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF4A3F38),
                  height: 1.25,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Search treatment',
                  hintStyle: AppFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _hintGray,
                    height: 1.25,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  filled: false,
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/Icons/search-icon.svg',
              width: 35,
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}

/// Sub-service tile: rounded thumb + title, left-aligned in the card (row vertically
/// centered in the grid cell when taller than one line).
class _TreatmentSubServiceRow extends StatelessWidget {
  const _TreatmentSubServiceRow({
    required this.title,
    required this.thumbAsset,
  });

  final String title;
  final String thumbAsset;

  static const _borderColor = Color(0xFFEEE0D6);
  static const _titleColor = Color(0xFF605851);
  static const _cardRadius = 8.0;
  static const _cardPadding = 8.0;
  static const _thumbGap = 4.0;
  static const _thumbRadius = 6.0;
  static const _thumbSize = 42.0;
  static const _procedureTitleMaxLines = 3;

  @override
  Widget build(BuildContext context) {
    final thumb = thumbAsset.endsWith('.svg')
        ? SvgPicture.asset(
            thumbAsset,
            width: _thumbSize,
            height: _thumbSize,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          )
        : Image.asset(
            thumbAsset,
            width: _thumbSize,
            height: _thumbSize,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_cardRadius),
        border: Border.all(color: _borderColor, width: 1),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final h = constraints.maxHeight;
          final w = constraints.maxWidth;
          final bounded = h.isFinite && w.isFinite;
          final content = Padding(
            padding: const EdgeInsets.all(_cardPadding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(_thumbRadius),
                    child: SizedBox(
                      width: _thumbSize,
                      height: _thumbSize,
                      child: thumb,
                    ),
                  ),
                  const SizedBox(width: _thumbGap),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: _procedureTitleMaxLines,
                      softWrap: true,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.start,
                      style: AppFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _titleColor,
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          if (bounded) {
            return SizedBox(width: w, height: h, child: content);
          }
          return content;
        },
      ),
    );
  }
}

class _TreatmentCard extends StatelessWidget {
  const _TreatmentCard({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.child,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  static const _activeFill = Color(0xFFEEE0D6);
  static const _idleFill = Color(0xFFFFFFFF);
  static const _borderColor = Color(0xFFEEE0D6);
  static const _titleColor = Color(0xFF605851);
  static const _cardRadius = 8.0;
  static const _cardPadding = 8.0;
  static const _iconTitleGap = 4.0;
  static const _labelMaxLines = 3;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_cardRadius),
        child: Ink(
          decoration: BoxDecoration(
            color: selected ? _activeFill : _idleFill,
            borderRadius: BorderRadius.circular(_cardRadius),
            border: selected ? null : Border.all(color: _borderColor, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(_cardPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(flex: 2, child: Center(child: child)),
                const SizedBox(height: _iconTitleGap),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: _labelMaxLines,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  style: AppFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _titleColor,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
