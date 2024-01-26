import 'package:flutter/material.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:test_project/api/api_service.dart';
import 'package:test_project/api/prefs.dart';
import 'package:test_project/bloc/main/lesson_bloc.dart';
import 'package:test_project/commons/constants.dart';
import 'package:test_project/image_permissions/service_locator.dart';
import 'package:test_project/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await Prefs.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiService(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MultiBlocProvider(
          providers: [
            BlocProvider<LessonBloc>(
              create: (context) =>
                  LessonBloc(RepositoryProvider.of<ApiService>(context)),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'PocketPython',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: shadowColor),
              useMaterial3: true,
            ),
            home: const MyHomePage(
              title: 'Python',
            ),
            navigatorObservers: [
              NavigationHistoryObserver(),
            ],
          ),
        ),
      ),
    );
  }
}
