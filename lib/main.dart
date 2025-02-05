import 'package:cross_platform_product_listing_assessment/core/di.dart';
import 'package:cross_platform_product_listing_assessment/logic/cubit/theme_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupGetIt();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            title: "CareComm Task",
            themeMode: mode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: Scaffold(
              body: Center(
                child: BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return Switch(
                      value: themeMode == ThemeMode.dark,
                      onChanged: (value) =>
                          context.read<ThemeCubit>().toggleTheme(),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
