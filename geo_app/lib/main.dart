import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/Logic/bloc/localisation_bloc.dart';
import 'package:geo_app/Screen/Gmap.dart';
import 'package:geo_app/Screen/HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocationService.determinePosition();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalisationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        home: const Gmap(),
      ),
    );
  }
}
