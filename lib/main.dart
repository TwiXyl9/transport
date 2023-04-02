import 'package:flutter/material.dart';
import 'package:transport/locator.dart';
import 'package:transport/models/prefs.dart';
import 'package:transport/views/home/home_view.dart';
import 'package:transport/views/layout_template/layout_template.dart';
import 'package:transport/widgets/sliders/news_slider_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transport',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      home: LayoutTemplate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
