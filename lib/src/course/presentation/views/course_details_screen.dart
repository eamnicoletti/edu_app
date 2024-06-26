import 'package:edu_app/core/common/widgets/course_info_tile.dart';
import 'package:edu_app/core/common/widgets/expandable_text.dart';
import 'package:edu_app/core/common/widgets/gradient_background.dart';
import 'package:edu_app/core/extensions/context_extension.dart';
import 'package:edu_app/core/extensions/int_extensions.dart';
import 'package:edu_app/core/res/media_res.dart';
import 'package:edu_app/src/course/data/models/course_model.dart';
import 'package:edu_app/src/course/domain/entities/course_entity.dart';
import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({required this.course, super.key});

  static const routeName = '/course-details';

  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    final course = (this.course as CourseModel).copyWith(
      numberOfVideos: 3,
      numberOfExams: 10,
      numberOfMaterials: 20,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: GradientBackground(
        image: MediaRes.homeGradientBackground,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(
                height: context.height * .3,
                child: Center(
                  child: course.image != null
                      ? Image.network(course.image!)
                      : Image.asset(MediaRes.casualMeditation),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (course.description != null)
                    ExpandableText(context, text: course.description!),
                  if (course.numberOfMaterials > 0 ||
                      course.numberOfVideos > 0 ||
                      course.numberOfExams > 0) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Subject Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (course.numberOfVideos > 0) ...[
                      const SizedBox(height: 10),
                      CourseInfoTile(
                        image: MediaRes.courseInfoVideo,
                        title: '${course.numberOfVideos} Video(s)',
                        subTitle: 'Watch our tutorial videos for '
                            '${course.title}',
                        onTap: () => Navigator.of(context).pushNamed(
                          '/unknown-route',
                          arguments: course,
                        ),
                      ),
                    ],
                    if (course.numberOfExams > 0) ...[
                      const SizedBox(height: 10),
                      CourseInfoTile(
                        image: MediaRes.courseInfoExam,
                        title: '${course.numberOfExams} Exam(s)',
                        subTitle: 'Take our exams ${course.title}',
                        onTap: () => Navigator.of(context).pushNamed(
                          '/unknown-route',
                          arguments: course,
                        ),
                      ),
                    ],
                    if (course.numberOfMaterials > 0) ...[
                      const SizedBox(height: 10),
                      CourseInfoTile(
                        image: MediaRes.courseInfoMaterial,
                        title: '${course.numberOfMaterials} Material(s)',
                        subTitle: 'Access to '
                            '${course.numberOfMaterials.estimate} materials for'
                            ' ${course.title}',
                        onTap: () => Navigator.of(context).pushNamed(
                          '/unknown-route',
                          arguments: course,
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
