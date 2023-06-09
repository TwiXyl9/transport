import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:transport/blocs/account_bloc.dart';
import 'package:transport/blocs/authentication_bloc.dart';
import 'package:transport/blocs/cars_bloc.dart';
import 'package:transport/blocs/news_bloc.dart';
import 'package:transport/blocs/order_bloc.dart';
import 'package:transport/blocs/registration_bloc.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/models/prefs.dart';
import 'package:transport/views/layout_template/layout_template.dart';

import 'blocs/additional_service_bloc.dart';
import 'blocs/cargo_type_bloc.dart';
import 'blocs/tail_type_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegistrationBloc>(
          create: (context) => RegistrationBloc()..add(RegistrationInitialEvent()),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(context.read<RegistrationBloc>())..add(AuthenticationCheckStatusEvent()),
        ),
        BlocProvider<CarsBloc>(
          create: (context) => CarsBloc()..add(InitialCarsEvent()),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(context.read<AuthenticationBloc>())..add(InitialNewsEvent()),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc()..add(InitialOrderEvent()),
        ),
        BlocProvider<AccountBloc>(
          create: (context) => AccountBloc(context.read<AuthenticationBloc>())..add(InitialAccountEvent()),
        ),
        BlocProvider<CargoTypeBloc>(
          create: (context) => CargoTypeBloc()..add(InitialCargoTypeEvent()),
        ),
        BlocProvider<TailTypeBloc>(
          create: (context) => TailTypeBloc()..add(InitialTailTypeEvent()),
        ),
        BlocProvider<AdditionalServiceBloc>(
          create: (context) => AdditionalServiceBloc()..add(InitialAdditionalServiceEvent()),
        ),
      ],
      child: MaterialApp.router(
          title: 'Transport',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.interTextTheme(
                  Theme.of(context).textTheme
              )
          ),
          routerConfig: locator<NavigationHelper>().router,

          debugShowCheckedModeBanner: false,
      ),
    );
  }

}
