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

  setUp(() {
    storage = MockStorage();
    when(storage.read(any))
        .thenReturn(null); // Ensure no previous state is restored
    when(storage.write(any, any))
        .thenAnswer((_) async {}); // Mock writing state
    HydratedBloc.storage = storage;
  });

  test('initial state should be ThemeMode.light', () {
    final themeCubit = ThemeCubit();
    expect(themeCubit.state, ThemeMode.light);
  });

  test('toggleTheme should switch from light to dark and back', () {
    final themeCubit = ThemeCubit();

    themeCubit.toggleTheme();
    expect(themeCubit.state, ThemeMode.dark);

    themeCubit.toggleTheme();
    expect(themeCubit.state, ThemeMode.light);
  });

  test('fromJson should return correct ThemeMode', () {
    final themeCubit = ThemeCubit();
    expect(themeCubit.fromJson({'theme': 1}), ThemeMode.light);
    expect(themeCubit.fromJson({'theme': 2}), ThemeMode.dark);
  });

  test('toJson should return correct map', () {
    final themeCubit = ThemeCubit();
    expect(themeCubit.toJson(ThemeMode.light), {'theme': 1});
    expect(themeCubit.toJson(ThemeMode.dark), {'theme': 2});
  });
}
