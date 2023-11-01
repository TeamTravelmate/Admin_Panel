import 'package:flutter/material.dart';
import 'package:travel_mate_admin/constants.dart';
import 'package:travel_mate_admin/places_page.dart';
import 'package:travel_mate_admin/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        canvasColor: const Color.fromARGB(255, 255, 255, 255),
        useMaterial3: true,
      ),
      // home: PlacesPage(),
      home: WidgetTree(),
      routes: {
        '/places': (context) => PlacesPage(),
        '/notifications': (context) => PlacesPage(),
      },
    );
  }
}
