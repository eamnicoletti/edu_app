// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/core/errors/exceptions.dart';
import 'package:edu_app/core/utils/datasource_utils.dart';
import 'package:edu_app/src/course/features/videos/data/models/video_model.dart';
import 'package:edu_app/src/course/features/videos/domain/entities/video_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class VideoRemoteDataSrc {
  Future<List<VideoModel>> getVideos(String courseId);

  Future<void> addVideo(VideoEntity video);
}

class VideoRemoteDataSrcImpl implements VideoRemoteDataSrc {
  VideoRemoteDataSrcImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _auth = auth,
        _firestore = firestore,
        _storage = storage;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  @override
  Future<void> addVideo(VideoEntity video) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_auth);

      // Create a reference to the video document in Firestore.
      final videoRef = _firestore
          .collection('courses')
          .doc(video.courseId)
          .collection('videos')
          .doc();

      // Create a VideoModel instance with a unique ID.
      var videoModel = (video as VideoModel).copyWith(id: videoRef.id);

      // If the video has a thumbnail file, upload it to Firebase Storage.
      if (videoModel.thumbnailIsFile) {
        final thumbnailFileRef = _storage.ref().child(
              'courses/${videoModel.courseId}/videos/${videoRef.id}/thumbnail',
            );
        await thumbnailFileRef
            .putFile(File(videoModel.thumbnail!))
            .then((value) async {
          final url = await value.ref.getDownloadURL();
          videoModel = videoModel.copyWith(thumbnail: url);
        });
      }

      // Set the video data in Firestore.
      await videoRef.set(videoModel.toMap());

      // Update the number of videos in the associated course document.
      await _firestore.collection('courses').doc(video.courseId).update({
        'numberOfVideos': FieldValue.increment(1),
      });
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to ServerException.
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw ServerException to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to ServerException.
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<VideoModel>> getVideos(String courseId) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);

      final videos = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('videos')
          .get();

      return videos.docs.map((doc) => VideoModel.fromMap(doc.data())).toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }
}
