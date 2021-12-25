import 'package:assignment/providers/data_provider.dart';
import 'package:assignment/providers/theme_provider.dart';
import 'package:assignment/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_theme/animated_theme_app.dart';
import 'package:flutter_animated_theme/animation_type.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => DataProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return AnimatedThemeApp(
      title: 'JAKES APP',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      animationType: AnimationType.CIRCULAR_ANIMATED_THEME,
      animationDuration: const Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
