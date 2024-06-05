import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/core/services/injection_container.dart';
import 'package:edu_app/src/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<LocalUserModel> get userDataSream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => LocalUserModel.fromMap(event.data()!));
}
