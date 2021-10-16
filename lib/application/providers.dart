import 'package:books_app_up/application/auth/auth_controller.dart';
import 'package:books_app_up/application/favorites/favorites_state.dart';
import 'package:books_app_up/application/home/home_controller.dart';
import 'package:books_app_up/application/home/home_state.dart';
import 'package:books_app_up/application/search/search_controller.dart';
import 'package:books_app_up/application/search/search_state.dart';
import 'package:books_app_up/infrastructure/services/authentication_service.dart';
import 'package:books_app_up/infrastructure/services/book_service.dart';
import 'package:books_app_up/infrastructure/services/favorites_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth/auth_enum.dart';
import 'favorites/favorites_controller.dart';
import 'favorites/helper.dart';

// AUTH
//
//
//

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authServiceProvider = Provider<BaseAuthService>(
    (ref) => FirebaseAuthService(ref.watch(firebaseAuthProvider)));

final authStateProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthMode>((ref) {
  return AuthController(ref.watch(authServiceProvider));
});

// FAVORITES
//
//
//
final favoritesServiceProvider = Provider<BaseFavoritesService>(
    (ref) => FavoritesService(FirebaseFirestore.instance));

final userFavoritesProvider =
    StreamProvider.autoDispose.family<List<String>, String>((ref, id) {
  return ref.watch(favoritesServiceProvider).getForUser(id);
});

final isUserFavoriteProvider =
    Provider.autoDispose.family<bool, UserBook>((ref, userBook) {
  final favorites = ref.watch(userFavoritesProvider(userBook.userId));

  return favorites.when(
      data: (data) =>
          data.where((element) => element == userBook.bookUrl).isNotEmpty,
      error: (_, __, ___) => false,
      loading: (_) => false);
});

final favoritesControllerProvider =
    StateNotifierProvider.autoDispose<FavoritesController, FavoritesState>(
        (ref) {
  final service = ref.watch(bookService);
  final userId = ref.watch(authStateProvider).value!.uid;
  final favoritesList = ref.watch(userFavoritesProvider(userId));

  return FavoritesController(service, favoritesList);
});

// HOME
//
//
//

final homeControllerProvider =
    StateNotifierProvider<HomeController, HomeState>((ref) {
  final repository = ref.watch(bookService);
  return HomeController(repository);
});

// SEARCH
//
//
//

final searchTextEditorProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());

final focusSearchProvider = StateProvider<bool>((ref) => false);

final searchControllerProvider =
    StateNotifierProvider<SearchController, SearchState>((ref) {
  final repository = ref.watch(bookService);
  final searchEditor = ref.watch(searchTextEditorProvider).state;
  return SearchController(repository, searchEditor);
});
