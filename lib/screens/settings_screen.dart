import 'package:flutter/material.dart';
import 'notification_settings_screen.dart';
import 'password_settings_screen.dart';
import 'delete_account_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF14C996);
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFE8F5F1),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _navTile(
              context,
              icon: Icons.notifications_active_outlined,
              label: 'Notification Settings',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationSettingsScreen())),
            ),
            const SizedBox(height: 12),
            _navTile(
              context,
              icon: Icons.vpn_key_outlined,
              label: 'Password Settings',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PasswordSettingsScreen())),
            ),
            const SizedBox(height: 12),
            _navTile(
              context,
              icon: Icons.person_remove_alt_1_outlined,
              label: 'Delete Account',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DeleteAccountScreen())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navTile(BuildContext context, {required IconData icon, required String label, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(color: Color(0xFF14C996), shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            ]),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
