// Utils: map string icon names from backend -> Material Icons.

import 'package:flutter/material.dart';

IconData iconFromName(String name) {
  switch (name) {
    case 'restaurant':
      return Icons.restaurant;
    case 'directions_bus':
      return Icons.directions_bus;
    case 'shopping_bag':
      return Icons.shopping_bag;
    case 'local_pharmacy':
      return Icons.local_pharmacy;
    case 'home_work':
      return Icons.home_work;
    case 'local_gas_station':
      return Icons.local_gas_station;
    case 'card_giftcard':
      return Icons.card_giftcard;
    case 'savings':
      return Icons.savings;
    case 'movie':
      return Icons.movie;
    case 'add':
      return Icons.add;
    case 'account_balance':
      return Icons.account_balance;
    case 'video_library':
      return Icons.video_library;
    case 'handshake':
      return Icons.handshake;
    default:
      return Icons.category;
  }
}
