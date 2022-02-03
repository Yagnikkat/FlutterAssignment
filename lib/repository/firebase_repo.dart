import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseRepo{
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<FirebaseApp> initializeFirebase() async {

    FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
    FirebaseFirestore firestore = FirebaseFirestore.instanceFor(app: secondaryApp);

    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

}