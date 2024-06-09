import 'package:edu_app/src/course/domain/entities/course_entity.dart';
import 'package:flutter/material.dart';

class CourseOfTheDayNotifier extends ChangeNotifier {
  CourseEntity? _courseOfTheDay;

  CourseEntity? get courseOfTheDay => _courseOfTheDay;

  void setCourseOfTheDay(CourseEntity course) {
    _courseOfTheDay ??= course;

    notifyListeners();
  }
}
