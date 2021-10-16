import 'package:books_app_up/infrastructure/services/favorites_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesServiceProvider = Provider<BaseFavoritesService>(
    (ref) => FavoritesService(FirebaseFirestore.instance));

final favoritesProvider =
    StreamProvider.autoDispose.family<List<String>, String>((ref, id) {
  return ref.watch(favoritesServiceProvider).getForUser(id);
});

class UserBook {
  final String userId;
  final String bookUrl;

  UserBook(this.userId, this.bookUrl);
}

final isUserFavoriteProvider =
    Provider.autoDispose.family<bool, UserBook>((ref, userBook) {
  final favorites = ref.watch(favoritesProvider(userBook.userId));

  return favorites.when(
      data: (data) =>
          data.where((element) => element == userBook.bookUrl).isNotEmpty,
      error: (_, __, ___) => false,
      loading: (_) => false);
});
