import 'package:books_app_up/application/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeaderTitle extends ConsumerWidget {
  const HeaderTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(top: 22, bottom: 32),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                ref.read(authProvider).signOut();
              },
              icon: const Icon(Icons.logout)),
          const Expanded(
            child: Text("Explore thousands of books on the go",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
