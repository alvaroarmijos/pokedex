import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/utils/utils.dart';

void main() {
  group('Capitalize text', () {
    final tText = "test";
    final tSentence = "test test";
    test(
      'should capitalize only first word',
      () async {
        expect(Utils.capitalize(tText), "Test");
      },
    );

    test(
      'should capitalize first word',
      () async {
        expect(Utils.capitalize("t"), "T");
      },
    );

    test(
      'should capitalize first word in sentence',
      () async {
        expect(Utils.capitalize(tSentence), "Test test");
      },
    );
  });

  group('Convert to kg', () {
    final int = 67;
    final kg = 6.7;
    test(
      'should convert to kg',
      () async {
        expect(Utils.toKg(int), kg);
      },
    );
  });
}
