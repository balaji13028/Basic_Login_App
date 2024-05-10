import 'package:devpoint_solutions/firebase_options.dart';
import 'package:devpoint_solutions/pages/splash_screen.dart';
import 'package:devpoint_solutions/provider/firestore_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FireStoreProvider(),
      child: MaterialApp(
        title: 'DevPoint Solutions',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(
          useMaterial3: true,
        ).copyWith(
          primaryColor: Colors.blue,
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.blue,
              iconTheme: IconThemeData(color: Colors.white, size: 28),
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
