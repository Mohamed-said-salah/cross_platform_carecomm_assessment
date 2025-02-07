import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  /// Toggle the current theme mode.
  ///
  /// If the current theme mode is [ThemeMode.light], switch to
  /// [ThemeMode.dark]. Otherwise, switch to [ThemeMode.light].
  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  /// Deserialize a [ThemeMode] from a JSON object.
  ///
  /// The JSON object is expected to have a single key, "theme", which is
  /// an integer index into [ThemeMode.values].
  ///
  /// Throws [ArgumentError] if the JSON object does not contain a
  /// "theme" key, or if the value of the "theme" key is not an
  /// [int].
  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    return ThemeMode.values[json['theme'] as int];
  }

  /// Serialize a [ThemeMode] to a JSON object.
  ///
  /// The JSON object will contain a single key, "theme", which is
  /// an integer index into [ThemeMode.values].
  @override
  Map<String, dynamic> toJson(ThemeMode state) {
    return {'theme': state.index};
  }
}
