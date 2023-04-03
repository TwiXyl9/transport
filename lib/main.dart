import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/authentication_bloc.dart';
import 'package:transport/blocs/cars_bloc.dart';
import 'package:transport/blocs/news_bloc.dart';
import 'package:transport/blocs/registration_bloc.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/models/prefs.dart';
import 'package:transport/routing/route.dart';
import 'package:transport/routing/route_names.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<CarsBloc>(
          create: (context) => CarsBloc()..add(InitialCarEvent()),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc()..add(InitialNewsEvent()),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc()..add(AuthenticationCheckStatusEvent()),
        ),
        BlocProvider<RegistrationBloc>(
          create: (context) => RegistrationBloc()..add(RegistrationInitialEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Transport',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: (context, child) => LayoutTemplate(
          child: child!,
        ),
        navigatorKey: locator<NavigationHelper>().navigatorKey,
        onGenerateRoute: generateRoute,
        initialRoute: homeRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
