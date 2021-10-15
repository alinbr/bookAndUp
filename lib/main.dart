import 'package:books_app_up/presentation/screens/register_screen.dart';
import 'package:books_app_up/presentation/widgets/core/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Books App and Up',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const AuthWrapper());
  }
}
