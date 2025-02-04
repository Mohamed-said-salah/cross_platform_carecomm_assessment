import 'package:cross_platform_product_listing_assessment/core/services/cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache_manager_test.mocks.dart';
// Generate the mock class

@GenerateMocks([SharedPreferences])
void main() {
  late CacheManager cacheManager;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    cacheManager = CacheManager(mockPrefs);
  });

  group('CacheManager Tests', () {
    test('setString should return true when saving is successful', () async {
      // Arrange
      when(mockPrefs.setString('key', 'value')).thenAnswer((_) async => true);

      // Act
      final result = await cacheManager.setString('key', 'value');

      // Assert
      expect(result, true);
      verify(mockPrefs.setString('key', 'value')).called(1);
    });

    test('getString should return stored value', () {
      // Arrange
      when(mockPrefs.getString('key')).thenReturn('stored_value');

      // Act
      final result = cacheManager.getString('key');

      // Assert
      expect(result, 'stored_value');
      verify(mockPrefs.getString('key')).called(1);
    });

    test('getString should return null if key does not exist', () {
      // Arrange
      when(mockPrefs.getString('non_existing_key')).thenReturn(null);

      // Act
      final result = cacheManager.getString('non_existing_key');

      // Assert
      expect(result, isNull);
      verify(mockPrefs.getString('non_existing_key')).called(1);
    });
  });
}
