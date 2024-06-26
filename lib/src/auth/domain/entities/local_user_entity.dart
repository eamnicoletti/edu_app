import 'package:equatable/equatable.dart';

class LocalUserEntity extends Equatable {
  const LocalUserEntity({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullName,
    this.groupId = const [],
    this.enrolledCourseIds = const [],
    this.following = const [],
    this.followers = const [],
    this.profilePic,
    this.bio,
  });

  const LocalUserEntity.empty()
      : this(
          uid: '',
          email: '',
          points: 0,
          fullName: '',
          profilePic: '',
          bio: '',
          groupId: const [],
          enrolledCourseIds: const [],
          followers: const [],
          following: const [],
        );

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupId;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  bool get isAdmin => email == 'eyaymyn@gmail.com';

  @override
  List<Object?> get props => [
        uid,
        email,
        profilePic,
        bio,
        points,
        fullName,
        groupId.length,
        enrolledCourseIds.length,
        following.length,
        followers.length,
      ];

  @override
  String toString() => 'LocalUserEntity{uid: $uid, email: $email, bio: $bio, '
      'points: $points, fullName: $fullName}';
}
