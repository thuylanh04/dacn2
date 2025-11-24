import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const primary = Color(0xFF14C996);
    final state = ref.watch(notificationSettingsProvider);
    final notifier = ref.read(notificationSettingsProvider.notifier);

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
          'Notification Settings',
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
            _switchTile('General Notification', state.general, notifier.setGeneral),
            const SizedBox(height: 12),
            _switchTile('Sound', state.sound, notifier.setSound),
            const SizedBox(height: 12),
            _switchTile('Sound Call', state.callSound, notifier.setCallSound),
            const SizedBox(height: 12),
            _switchTile('Vibrate', state.vibrate, notifier.setVibrate),
            const SizedBox(height: 12),
            _switchTile('Transaction Update', state.transactionUpdate, notifier.setTransactionUpdate),
            const SizedBox(height: 12),
            _switchTile('Expense Reminder', state.expenseReminder, notifier.setExpenseReminder),
            const SizedBox(height: 12),
            _switchTile('Budget Notifications', state.budgetNotifications, notifier.setBudgetNotifications),
            const SizedBox(height: 12),
            _switchTile('Low Balance Alerts', state.lowBalanceAlerts, notifier.setLowBalanceAlerts),
          ],
        ),
      ),
    );
  }

  Widget _switchTile(String title, bool value, void Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Switch(value: value, onChanged: onChanged, activeColor: const Color(0xFF14C996)),
        ],
      ),
    );
  }
}
