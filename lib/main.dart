import 'Package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash_screen.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to upright portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: const Color.fromARGB(255, 3, 4, 46),          // makes status bar transparent
      statusBarIconBrightness: Brightness.dark,    // dark icons for light backgrounds
      statusBarBrightness: Brightness.light,       // for iOS devices
    ),
  );

  runApp(ChangeNotifierProvider(create: (BuildContext context) { 
    return ThemeProvider();
  },
  child: MyApp(),),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color.fromARGB(255, 177, 169, 169),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          displayLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch:  Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromRGBO(26, 25, 25, 1),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18,
            color: const Color.fromARGB(255, 200, 200, 200),
          ),
          displayLarge: TextStyle(
            fontSize: 20,
            color: const Color.fromARGB(255, 220, 220, 220),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      themeMode: themeProvider.themeMode,
      home: SplashScreen(),
    );
  }
}
