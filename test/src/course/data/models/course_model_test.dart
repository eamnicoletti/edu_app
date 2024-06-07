import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/core/utils/typedefs.dart';
import 'package:edu_app/src/course/data/models/course_model.dart';
import 'package:edu_app/src/course/domain/entities/course_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  // Define test data
  final timestampData = {'_seconds': 1677483548, '_nanoseconds': 123456000};
  final date = DateTime.fromMillisecondsSinceEpoch(
    timestampData['_seconds']!,
  ).add(Duration(microseconds: timestampData['_nanoseconds']!));

  // Create a Timestamp instance for testing
  final tTimestamp = Timestamp.fromDate(date);

  final tCourseModel = CourseModel.empty();

  final tMap = jsonDecode(fixture('course.json')) as DataMap;
  tMap['createdAt'] = tTimestamp;
  tMap['updatedAt'] = tTimestamp;

  test('should be a subclass of [CourseEntity]', () {
    expect(tCourseModel, isA<CourseEntity>());
  });

  group('empty', () {
    test('should return a [CourseModel] with empty data', () {
      final result = CourseModel.empty();
      expect(result.title, '_empty.title');
    });
  });

  group('fromMap', () {
    test('should return a [CourseModel] with the correct data', () {
      final result = CourseModel.fromMap(tMap);
      expect(result, equals(tCourseModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the proper data', () {
      final result = tCourseModel.toMap()
        ..remove('createdAt')
        ..remove('updatedAt');

      final map = DataMap.from(tMap)
        ..remove('createdAt')
        ..remove('updatedAt');

      expect(result, equals(map));
    });
  });

  group('copyWith', () {
    test('should return a [CourseModel] with the new data', () {
      final result = tCourseModel.copyWith(title: 'New Title');

      expect(result.title, 'New Title');
    });
  });
}
