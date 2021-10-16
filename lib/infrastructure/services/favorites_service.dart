import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesService = Provider<BaseFavoritesService>((ref) {
  return FavoritesService(FirebaseFirestore.instance);
});

abstract class BaseFavoritesService {
  Future<String> add(String userId, String bookUrl);
  Future<String> remove(String userId, String bookUrl);
  Stream<List<String>> getForUser(String userId);
}

class FavoritesService extends BaseFavoritesService {
  final FirebaseFirestore _firebaseFirestore;

  FavoritesService(this._firebaseFirestore);

  @override
  Future<String> add(String userId, String bookUrl) async {
    try {
      print("adding book");
      await _firebaseFirestore
          .collection('favorites')
          .doc(userId)
          .collection('user_books')
          .add({'book_url': bookUrl});
      return 'Added';
    } on FirebaseException catch (e) {
      return e.message ?? 'Unkown error';
    }
  }

  @override
  Future<String> remove(String userId, String bookUrl) async {
    try {
      print("removing book");
      var snapshot = await _firebaseFirestore
          .collection('favorites')
          .doc(userId)
          .collection('user_books')
          .where('book_url', isEqualTo: bookUrl)
          .get();
      await snapshot.docs.first.reference.delete();
      return 'Deleted';
    } on FirebaseException catch (e) {
      return e.message ?? 'Unkown error';
    }
  }

  @override
  Stream<List<String>> getForUser(String userId) {
    return _firebaseFirestore
        .collection('favorites')
        .doc(userId)
        .collection('user_books')
        .snapshots()
        .map(
          (list) => list.docs.map((e) {
            print(e.data());
            return e.data()['book_url'].toString();
          }).toList(),
        );
  }
}
