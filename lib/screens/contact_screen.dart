import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_typography.dart';

/// Dial / WhatsApp / inbox used by Contact quick actions and booking mailto.
/// Adjust [bookingEmail] to the address that should receive form submissions.
abstract final class ContactInfo {
  static final Uri callUri = Uri.parse('tel:+8801810168011');
  static final Uri whatsappUri = Uri.parse('https://wa.me/8801810168011');
  static const String bookingEmail = 'info@skinnclinic.com';
}

Future<void> _launchExternal(BuildContext context, Uri uri) async {
  final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!context.mounted || ok) return;
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Could not open link')),
  );
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  static const _pageBg = Color(0xFFFDF8F5);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ContactHeroBanner(),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                child: _QuickActions(
                  onCall: () => _launchExternal(context, ContactInfo.callUri),
                  onWhatsapp: () =>
                      _launchExternal(context, ContactInfo.whatsappUri),
                  onEmail: () => _launchExternal(
                    context,
                    Uri(scheme: 'mailto', path: ContactInfo.bookingEmail),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _BookingForm(),
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

/// Same treatment as [ServicesScreen] / [ClinicsScreen]: shell, 216 strip, overlay.
class _ContactHeroBanner extends StatelessWidget {
  const _ContactHeroBanner();

  static const _heroShell = Color(0xFFF3EBE4);
  static const _heroRadius = 8.0;
  static const _bannerHeight = 216.0;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: _heroShell,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(_heroRadius),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(_heroRadius),
        ),
        child: SizedBox(
          height: _bannerHeight,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/contact-banner.png',
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
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({
    required this.onCall,
    required this.onWhatsapp,
    required this.onEmail,
  });

  final VoidCallback onCall;
  final VoidCallback onWhatsapp;
  final VoidCallback onEmail;

  static const _cardGap = 8.0;
  static const _rowMinWidth = _QuickActionCard._w * 3 + _cardGap * 2;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final row = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _QuickActionCard(
              iconAsset: 'assets/Icons/call.png',
              label: 'Call Us',
              onTap: onCall,
            ),
            const SizedBox(width: _cardGap),
            _QuickActionCard(
              iconAsset: 'assets/Icons/Book Via Whatsapp.png',
              label: 'Book Via Whatsapp',
              onTap: onWhatsapp,
            ),
            const SizedBox(width: _cardGap),
            _QuickActionCard(
              iconAsset: 'assets/Icons/Email Us.png',
              label: 'Email Us',
              onTap: onEmail,
            ),
          ],
        );

        if (constraints.maxWidth >= _rowMinWidth) {
          return Center(child: row);
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: row,
        );
      },
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.iconAsset,
    required this.label,
    required this.onTap,
  });

  static const _w = 115.0;
  static const _h = 64.0;
  static const _innerPad = 8.0;
  static const _iconTextGap = 4.0;
  static const _iconBandH = 18.0;
  static const _bg = Color(0xFFD0BEB1);
  static const _borderColor = Color(0xFFA3948A);

  final String iconAsset;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final innerW = _w - 2 * _innerPad;

    return Material(
      color: _bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _borderColor, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: _w,
          height: _h,
          child: Padding(
            padding: const EdgeInsets.all(_innerPad),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: innerW,
                    height: _iconBandH,
                    child: Image.asset(
                      iconAsset,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(height: _iconTextGap),
                  SizedBox(
                    width: innerW,
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF605851),
                        height: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BookingForm extends StatefulWidget {
  const _BookingForm();

  @override
  State<_BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<_BookingForm> {
  static const _helperStyleColor = Color(0xFFA3948A);

  late final TextEditingController _phone;
  late final TextEditingController _fullName;
  late final TextEditingController _email;
  late final TextEditingController _purpose;
  late final TextEditingController _doctor;
  late final TextEditingController _notes;

  DateTime? _visitDate;
  TimeOfDay? _visitTime;

  @override
  void initState() {
    super.initState();
    _phone = TextEditingController();
    _fullName = TextEditingController();
    _email = TextEditingController();
    _purpose = TextEditingController();
    _doctor = TextEditingController();
    _notes = TextEditingController();
  }

  @override
  void dispose() {
    _phone.dispose();
    _fullName.dispose();
    _email.dispose();
    _purpose.dispose();
    _doctor.dispose();
    _notes.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  String _formatTime(BuildContext context, TimeOfDay t) {
    return MaterialLocalizations.of(context).formatTimeOfDay(
      t,
      alwaysUse24HourFormat: false,
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _visitDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) setState(() => _visitDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _visitTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _visitTime = picked);
  }

  bool _nonEmpty(String s) => s.trim().isNotEmpty;

  bool _validOptionalEmail(String s) {
    final v = s.trim();
    if (v.isEmpty) return true;
    return v.contains('@') && v.length > 4;
  }

  Future<void> _submit() async {
    if (!_nonEmpty(_phone.text)) {
      _toast('Please enter your phone number.');
      return;
    }
    if (!_nonEmpty(_fullName.text)) {
      _toast('Please enter your full name.');
      return;
    }
    if (!_validOptionalEmail(_email.text)) {
      _toast('Please enter a valid email address.');
      return;
    }
    if (!_nonEmpty(_purpose.text)) {
      _toast('Please enter purpose of visit.');
      return;
    }
    if (!_nonEmpty(_doctor.text)) {
      _toast('Please enter doctor name.');
      return;
    }
    if (_visitDate == null) {
      _toast('Please choose a date.');
      return;
    }
    if (_visitTime == null) {
      _toast('Please choose a time slot.');
      return;
    }

    final body = StringBuffer()
      ..writeln('Phone: ${_phone.text.trim()}')
      ..writeln('Full name: ${_fullName.text.trim()}')
      ..writeln('Email: ${_email.text.trim().isEmpty ? '—' : _email.text.trim()}')
      ..writeln('Purpose: ${_purpose.text.trim()}')
      ..writeln('Doctor: ${_doctor.text.trim()}')
      ..writeln(
        'Date: ${_formatDate(_visitDate!)}',
      )
      ..writeln(
        'Time: ${_formatTime(context, _visitTime!)}',
      )
      ..writeln()
      ..writeln('Notes:')
      ..writeln(_notes.text.trim().isEmpty ? '—' : _notes.text.trim());

    final uri = Uri(
      scheme: 'mailto',
      path: ContactInfo.bookingEmail,
      queryParameters: {
        'subject': 'Booking — ${_fullName.text.trim()}',
        'body': body.toString(),
      },
    );

    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Opening your email app…')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open email app.')),
      );
    }
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final helperStyle = AppFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: _helperStyleColor,
      height: 1.35,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Book You Slot',
            style: AppFonts.silkSerif(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF605851),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'our concern team will contact you',
            style: helperStyle,
          ),
          const SizedBox(height: 16),
          const _Label(title: 'Phone Number', showAsterisk: true),
          _FormTextField(
            controller: _phone,
            hint: 'Enter your phone number',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          const _Label(title: 'Full Name', showAsterisk: true),
          _FormTextField(
            controller: _fullName,
            hint: 'Enter your full name',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 12),
          const _Label(title: 'Email', showAsterisk: false),
          const SizedBox(height: 4),
          Text(
            'Please fill up to receive booking confirmation via email.',
            style: helperStyle,
          ),
          const SizedBox(height: 6),
          _FormTextField(
            controller: _email,
            hint: 'Enter your email address',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          const _Label(title: 'Purpose of Visit', showAsterisk: true),
          _FormTextField(
            controller: _purpose,
            hint: '',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 12),
          const _Label(title: 'Doctor', showAsterisk: true),
          _FormTextField(
            controller: _doctor,
            hint: '',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 12),
          const _Label(title: 'Date & Time', showAsterisk: true),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: _PickerField(
                  label: _visitDate != null
                      ? _formatDate(_visitDate!)
                      : 'Date',
                  onTap: _pickDate,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _PickerField(
                  label: _visitTime != null
                      ? _formatTime(context, _visitTime!)
                      : 'Time Slot',
                  onTap: _pickTime,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _Label(title: 'Notes', showAsterisk: false),
          _NotesField(controller: _notes),
          const SizedBox(height: 10),
          Text(
            'By making this booking you agree to our terms and conditions.',
            style: AppFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF000000),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          _ConfirmButton(onPressed: _submit),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.title, this.showAsterisk = true});

  final String title;
  final bool showAsterisk;

  static const _labelColor = Color(0xFF0A0A0A);

  @override
  Widget build(BuildContext context) {
    final base = AppFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: _labelColor,
      height: 1.25,
    );
    if (!showAsterisk) {
      return Text(title, style: base);
    }
    return Text.rich(
      TextSpan(
        style: base,
        children: [
          TextSpan(text: title),
          const TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _FormTextField extends StatelessWidget {
  const _FormTextField({
    required this.controller,
    required this.hint,
    required this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;

  static const _borderColor = Color(0xFFD0BEB1);
  static const _hintColor = Color(0xFFA3948A);
  static const _textColor = Color(0xFF0A0A0A);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        style: AppFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: _textColor,
          height: 1.2,
        ),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: hint.isEmpty ? null : hint,
          hintStyle: AppFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: _hintColor,
            height: 1.2,
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  static const _borderColor = Color(0xFFD0BEB1);
  static const _placeholderColor = Color(0xFFA3948A);
  static const _valueColor = Color(0xFF000000);

  @override
  Widget build(BuildContext context) {
    final isPlaceholder = label == 'Date' || label == 'Time Slot';
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: isPlaceholder ? _placeholderColor : _valueColor,
                    height: 1.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: isPlaceholder ? _placeholderColor : _valueColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotesField extends StatelessWidget {
  const _NotesField({required this.controller});

  final TextEditingController controller;

  static const _borderColor = Color(0xFFD0BEB1);
  static const _hintColor = Color(0xFFA3948A);
  static const _textColor = Color(0xFF0A0A0A);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      height: 96,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: AppFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: _textColor,
          height: 1.35,
        ),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: 'Add any extra details…',
          hintStyle: AppFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: _hintColor,
            height: 1.35,
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({required this.onPressed});

  final VoidCallback onPressed;

  static const _bg = Color(0xFFBC967E);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: Material(
        color: _bg,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Text(
              'Confirm Booking',
              style: AppFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFFFFFF),
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
