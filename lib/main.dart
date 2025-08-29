import 'package:all/bloc/market/market_bloc.dart';
import 'package:all/repository/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Add your MarketBloc here
        BlocProvider<MarketBloc>(
          create: (context) => MarketBloc(),
        ),
        // Add other Blocs if needed
      ],
      child: MaterialApp(
        title: 'All in One',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: const Splashscreen(),
      ),
    );
  }
}
