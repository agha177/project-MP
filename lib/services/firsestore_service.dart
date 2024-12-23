import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_mp/models/gift_model.dart';


class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a new gift
  Future<void> addGift(Gift gift) async {
    try {
      await _db.collection('gifts').add(gift.toMap());
    } catch (e) {
      print('Error adding gift: $e');
      throw e;
    }
  }

  // Update an existing gift
  Future<void> updateGift(Gift gift) async {
    try {
      await _db.collection('gifts').doc(gift.id).update(gift.toMap());
    } catch (e) {
      print('Error updating gift: $e');
      throw e;
    }
  }

  // Delete a gift
  Future<void> deleteGift(String id) async {
    try {
      await _db.collection('gifts').doc(id).delete();
    } catch (e) {
      print('Error deleting gift: $e');
      throw e;
    }
  }

  // Get a stream of gifts
  Stream<List<Gift>> getGifts() {
    return _db.collection('gifts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Gift.fromFirestore(doc)).toList();
    });
  }
}
