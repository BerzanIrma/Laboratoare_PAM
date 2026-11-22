
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/store_remote_data_source.dart';
import 'data/repositories/store_repository_impl.dart';
import 'domain/usecases/get_categories.dart';
import 'domain/usecases/get_products.dart';
import 'presentation/cubit/store_cubit.dart';
import 'presentation/pages/home_page.dart';

void main() {
  final httpClient = http.Client();

  final remoteDataSource = StoreRemoteDataSource(
    client: httpClient,
  );

  final repository = StoreRepositoryImpl(
    remoteDataSource: remoteDataSource,
  );

  final getCategories = GetCategories(repository);
  final getProducts = GetProducts(repository);

  runApp(
    BlocProvider(
      create: (_) => StoreCubit(
        repository: repository,
        getCategories: getCategories,
        getProducts: getProducts,
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
