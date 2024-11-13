import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClickService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<int> getClickCount() async {
    User? user = _auth.currentUser;
    if (user == null) return 0;

    DocumentSnapshot doc = await _firestore
        .collection('clicks')
        .doc(user.uid)
        .get();

    return doc.exists ? (doc['count'] ?? 0) as int : 0;
  }

  Future<void> incrementClickCount() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentReference docRef = _firestore.collection('clicks').doc(user.uid);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);

      int newCount = (snapshot.exists ? (snapshot['count'] ?? 0) as int : 0) + 1;
      transaction.set(docRef, {'count': newCount});
    });
  }
}
