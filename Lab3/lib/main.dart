import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';
import 'cubit/store_cubit.dart';
import 'repositories/store_repository.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => StoreCubit(
        StoreRepository(),
      )..loadStore(),
      child: const GemStoreApp(),
    ),
  );
}

class GemStoreApp extends StatelessWidget {
  const GemStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GemStore',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}