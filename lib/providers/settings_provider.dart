import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationSettingsState {
  final bool general;
  final bool sound;
  final bool callSound;
  final bool vibrate;
  final bool transactionUpdate;
  final bool expenseReminder;
  final bool budgetNotifications;
  final bool lowBalanceAlerts;

  const NotificationSettingsState({
    this.general = true,
    this.sound = true,
    this.callSound = true,
    this.vibrate = true,
    this.transactionUpdate = true,
    this.expenseReminder = false,
    this.budgetNotifications = true,
    this.lowBalanceAlerts = true,
  });

  NotificationSettingsState copyWith({
    bool? general,
    bool? sound,
    bool? callSound,
    bool? vibrate,
    bool? transactionUpdate,
    bool? expenseReminder,
    bool? budgetNotifications,
    bool? lowBalanceAlerts,
  }) => NotificationSettingsState(
        general: general ?? this.general,
        sound: sound ?? this.sound,
        callSound: callSound ?? this.callSound,
        vibrate: vibrate ?? this.vibrate,
        transactionUpdate: transactionUpdate ?? this.transactionUpdate,
        expenseReminder: expenseReminder ?? this.expenseReminder,
        budgetNotifications: budgetNotifications ?? this.budgetNotifications,
        lowBalanceAlerts: lowBalanceAlerts ?? this.lowBalanceAlerts,
      );
}

class NotificationSettingsNotifier extends StateNotifier<NotificationSettingsState> {
  NotificationSettingsNotifier() : super(const NotificationSettingsState());
  void toggle(void Function() updater) => updater();
  void setGeneral(bool v) => state = state.copyWith(general: v);
  void setSound(bool v) => state = state.copyWith(sound: v);
  void setCallSound(bool v) => state = state.copyWith(callSound: v);
  void setVibrate(bool v) => state = state.copyWith(vibrate: v);
  void setTransactionUpdate(bool v) => state = state.copyWith(transactionUpdate: v);
  void setExpenseReminder(bool v) => state = state.copyWith(expenseReminder: v);
  void setBudgetNotifications(bool v) => state = state.copyWith(budgetNotifications: v);
  void setLowBalanceAlerts(bool v) => state = state.copyWith(lowBalanceAlerts: v);
}

final notificationSettingsProvider = StateNotifierProvider<NotificationSettingsNotifier, NotificationSettingsState>(
  (ref) => NotificationSettingsNotifier(),
);
