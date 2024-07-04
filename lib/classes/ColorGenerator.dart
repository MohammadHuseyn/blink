import 'dart:math';
import 'package:flutter/material.dart';

class ColorGenerator {
  static final Random _random = Random();
  static final Set<Color> _generatedColors = {};

  static Color generateRandomDarkColor() {
    Color color;
    do {
      int red = _random.nextInt(128); // Limiting values to get dark colors
      int green = _random.nextInt(128);
      int blue = _random.nextInt(128);
      color = Color.fromARGB(255, red, green, blue);
    } while (_generatedColors.contains(color));

    _generatedColors.add(color);
    return color;
  }
}
