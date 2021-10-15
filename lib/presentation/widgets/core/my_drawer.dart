import 'package:books_app_up/application/auth/auth_controller.dart';
import 'package:books_app_up/presentation/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('View favorites'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesScreen(),
                  ));
            },
          ),
          ListTile(
            title: const Icon(Icons.logout),
            onTap: () {
              ref.read(authProvider).signOut();
            },
          ),
        ],
      ),
    );
  }
}
