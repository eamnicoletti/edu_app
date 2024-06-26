import 'package:edu_app/core/utils/typedefs.dart';
import 'package:edu_app/src/course/domain/entities/course_entity.dart';

/// The `CourseRepo` abstract class defines a contract for accessing and
/// manipulating course-related data in the application. It serves as an
/// abstraction that enforces consistency and provides a clear interface for
/// concrete repository implementations to follow when working with courses.
abstract class CourseRepo {
  const CourseRepo();

  /// Fetches a list of courses and returns them as a `ResultFuture`.
  ResultFuture<List<CourseEntity>> getCourses();

  /// Adds a new course and returns a `ResultFuture` to indicate success or
  /// failure.
  ResultFuture<void> addCourse(CourseEntity course);
}
