

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/api/api_service.dart';
import 'package:test_project/bloc/events/lesson_bloc_events.dart';
import 'package:test_project/bloc/states/lesson_bloc_states.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {

  final ApiService apiService;

  LessonBloc(this.apiService) : super(InitialState()) {
    print("Initializing BLOC");
  }
}