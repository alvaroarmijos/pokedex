class Utils {
  static String capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  static double toKg(int value) {
    return value / 10;
  }
}
