import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/product.dart';
import '../models/category.dart';
import '../models/review.dart';

class StoreRepository {
  Future<Map<String, dynamic>> _loadJson() async {
    final String jsonString =
    await rootBundle.loadString('assets/data/store.json');

    return json.decode(jsonString) as Map<String, dynamic>;
  }

  Future<List<Category>> getCategories() async {
    final data = await _loadJson();

    final List categoriesJson = data['homePage']['categories'];

    return categoriesJson
        .map((category) => Category.fromJson(category))
        .toList();
  }

  Future<List<Product>> getFeatureProducts() async {
    final data = await _loadJson();

    final List productsJson = data['homePage']['featureProducts'];

    return productsJson
        .map((product) => Product.fromJson(product))
        .toList();
  }

  Future<List<Product>> getRecommendedProducts() async {
    final data = await _loadJson();

    final List productsJson = data['homePage']['recommended'];

    return productsJson
        .map((product) => Product.fromJson(product))
        .toList();
  }

  Future<Product> getProduct() async {
    final data = await _loadJson();

    final productJson = data['productPage']['product'];

    return Product.fromJson(productJson);
  }

  Future<List<Review>> getReviews() async {
    final data = await _loadJson();

    final List reviewsJson =
    data['productPage']['product']['reviews'];

    return reviewsJson
        .map((review) => Review.fromJson(review))
        .toList();
  }

  Future<List<Product>> getSimilarProducts() async {
    final data = await _loadJson();

    final List productsJson =
    data['productPage']['product']['similarProducts'];

    return productsJson
        .map((product) => Product.fromJson(product))
        .toList();
  }
}