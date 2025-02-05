import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:cross_platform_product_listing_assessment/logic/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'theme_cubit_test.mocks.dart';

@GenerateMocks([Storage])
void main() {
  late MockStorage storage;
  late ThemeCubit themeCubit;

  setUp(() {
    storage = MockStorage();
    when(storage.read(any))
        .thenReturn(null); // Ensure no previous state is restored
    when(storage.write(any, any))
        .thenAnswer((_) async {}); // Mock writing state
    HydratedBloc.storage = storage;
    themeCubit = ThemeCubit();
  });

  tearDown(() {
    themeCubit.close();
  });

  group('ThemeCubit Initialization', () {
    test('should have an initial state of ThemeMode.light', () {
      expect(themeCubit.state, ThemeMode.light);
    });
  });

  group('ThemeCubit Toggle Functionality', () {
    test('should toggle theme from light to dark', () {
      themeCubit.toggleTheme();
      expect(themeCubit.state, ThemeMode.dark);
    });

    test('should toggle theme from dark back to light', () {
      themeCubit.toggleTheme();
      themeCubit.toggleTheme();
      expect(themeCubit.state, ThemeMode.light);
    });
  });

  group('ThemeCubit Serialization', () {
    test('fromJson should return correct ThemeMode', () {
      expect(themeCubit.fromJson({'theme': 1}), ThemeMode.light);
      expect(themeCubit.fromJson({'theme': 2}), ThemeMode.dark);
    });

    test('toJson should return correct map', () {
      expect(themeCubit.toJson(ThemeMode.light), {'theme': 1});
      expect(themeCubit.toJson(ThemeMode.dark), {'theme': 2});
    });
  });
}
