import 'package:edu_app/core/usecases/usecases.dart';
import 'package:edu_app/core/utils/typedefs.dart';
import 'package:edu_app/src/course/domain/entities/course_entity.dart';
import 'package:edu_app/src/course/domain/repos/course_repo.dart';

/// The `GetCourses` use case class is responsible for retrieving a list of
/// courses from the application. It utilizes the provided `CourseRepo` instance
/// to perform the retrieval operation and returns a `ResultFuture` containing
/// the list of courses.
class GetCourses extends UsecaseWithoutParams<List<CourseEntity>> {
  /// Creates a `GetCourses` instance with the given `CourseRepo` dependency.
  const GetCourses(this._repo);

  final CourseRepo _repo;

  /// Executes the use case by retrieving a list of courses from the repository.
  /// It returns a `ResultFuture` containing the list of courses.
  @override
  ResultFuture<List<CourseEntity>> call() async => _repo.getCourses();
}
