import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Asset Tests', () {
    test('KFC image asset should be available', () async {
      try {
        final ByteData data = await rootBundle.load(
          'assets/images/categories/kfc-2.png',
        );
        expect(data, isNotNull);
        expect(data.lengthInBytes, greaterThan(0));
      } catch (e) {
        fail('KFC image asset not found: $e');
      }
    });

    test('Fries image asset should be available', () async {
      try {
        final ByteData data = await rootBundle.load(
          'assets/images/categories/fries.png',
        );
        expect(data, isNotNull);
        expect(data.lengthInBytes, greaterThan(0));
      } catch (e) {
        fail('Fries image asset not found: $e');
      }
    });
  });
}
