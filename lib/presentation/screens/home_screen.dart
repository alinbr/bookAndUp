import 'package:books_app_up/application/home/home_state.dart';
import 'package:books_app_up/application/providers.dart';
import 'package:books_app_up/infrastructure/dtos/book_dto.dart';
import 'package:books_app_up/presentation/widgets/core/my_drawer.dart';
import 'package:books_app_up/presentation/widgets/home/book_card.dart';
import 'package:books_app_up/presentation/widgets/home/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(homeControllerProvider);

    final Widget content;
    if (home is HomeStateLoading) {
      content = buildLoadingState();
    } else if (home is HomeStateLoaded) {
      content = buildLoadedState(home.books);
    } else if (home is HomeStateError) {
      content = buildErrorState(home.error);
    } else {
      content = const SizedBox.shrink();
    }

    return Scaffold(
      drawer: const MyDrawer(),
      body: SafeArea(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: content),
      ),
    );
  }

  Widget buildLoadedState(List<BookDto> books) {
    return ListView.builder(
      itemCount: books.length + 1,
      itemBuilder: (context, index) =>
          (index == 0) ? const Header() : BookCard(book: books[index - 1]),
    );
  }

  Widget buildLoadingState() {
    return Column(
      children: const [
        Header(),
        Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }

  Widget buildErrorState(Exception error) {
    return Column(
      children: const [
        Header(),
        Expanded(
          child: Center(
            child: Text("Some unexpected error occured."),
          ),
        )
      ],
    );
  }
}
