// Utils: parse hex color string from backend (e.g. "#2E5BFF").

import 'package:flutter/material.dart';

Color colorFromHex(String hex) {
  var h = hex.replaceAll('#', '');
  if (h.length == 6) {
    h = 'FF' + h;
  }
  final intVal = int.tryParse(h, radix: 16) ?? 0xFF2E5BFF;
  return Color(intVal);
}
