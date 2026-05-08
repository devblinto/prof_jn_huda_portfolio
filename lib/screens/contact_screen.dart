import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _HeroImage(),
              SizedBox(height: 12),
              _QuickActions(),
              SizedBox(height: 14),
              _BookingForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 94,
        width: double.infinity,
        child: Image.asset(
          'assets/images/contact.webp',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _QuickActionButton(icon: Icons.call_outlined, label: 'Call'),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.location_on_outlined,
            label: 'Book Via Whatsapp',
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.mail_outline,
            label: 'Email Us',
          ),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFD8C4AF),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 17, color: const Color(0xFF6D584A)),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 8.5,
              color: Color(0xFF6D584A),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _BookingForm extends StatelessWidget {
  const _BookingForm();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
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
        children: const [
          Text(
            'Book You Slot',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w400,
              color: Color(0xFF1F1914),
              fontFamily: 'serif',
            ),
          ),
          Text(
            'UF contact form will contact you',
            style: TextStyle(fontSize: 10, color: Color(0xFFB4A398)),
          ),
          SizedBox(height: 8),
          _Label(title: 'Phone Number'),
          _InputField(hint: 'Enter your names'),
          SizedBox(height: 8),
          _Label(title: 'Full Name'),
          _InputField(hint: 'Enter your names'),
          SizedBox(height: 8),
          _Label(title: 'Email'),
          Text(
            'Please fill up to recv booking confirms to email.',
            style: TextStyle(fontSize: 9, color: Color(0xFFB4A398)),
          ),
          SizedBox(height: 4),
          _InputField(hint: 'Enter your email address'),
          SizedBox(height: 8),
          _Label(title: 'Purpose of Visit'),
          _InputField(),
          SizedBox(height: 8),
          _Label(title: 'Doctor'),
          _InputField(),
          SizedBox(height: 8),
          _Label(title: 'Date & Time'),
          SizedBox(height: 4),
          Row(
            children: [
              Expanded(child: _DropdownStub(label: 'Date')),
              SizedBox(width: 8),
              Expanded(child: _DropdownStub(label: 'Time Slot')),
            ],
          ),
          SizedBox(height: 8),
          _Label(title: 'Notes'),
          _NotesField(),
          SizedBox(height: 6),
          Text(
            'By making this booking you agree to our terms and conditions.',
            style: TextStyle(fontSize: 9, color: Color(0xFF8C7A6C)),
          ),
          SizedBox(height: 10),
          _ConfirmButton(),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFF1F1914),
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(text: title),
          const TextSpan(
            text: '  *',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({this.hint});

  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE7CFC0)),
        borderRadius: BorderRadius.circular(7),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        hint ?? '',
        style: const TextStyle(fontSize: 11, color: Color(0xFFC3B2A6)),
      ),
    );
  }
}

class _DropdownStub extends StatelessWidget {
  const _DropdownStub({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE7CFC0)),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF6F5B4E)),
          ),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF6F5B4E)),
        ],
      ),
    );
  }
}

class _NotesField extends StatelessWidget {
  const _NotesField();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      height: 96,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE7CFC0)),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFFC3A285),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'Confirm Booking',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
