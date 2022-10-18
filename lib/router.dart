import 'package:amazon_clone/src/models/order.dart';
import 'package:amazon_clone/src/models/product.dart';
import 'package:amazon_clone/src/ui/views/address_view.dart';
import 'package:amazon_clone/src/ui/views/admin/create_product_view.dart';
import 'package:amazon_clone/src/ui/views/authentication_view.dart';
import 'package:amazon_clone/src/ui/views/category_products_view.dart';
import 'package:amazon_clone/src/ui/views/home_view.dart';
import 'package:amazon_clone/src/ui/views/order_detail_view.dart';
import 'package:amazon_clone/src/ui/views/product_detail_view.dart';
import 'package:amazon_clone/src/ui/views/search_view.dart';
import 'package:amazon_clone/src/ui/views/wrapper_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthenticationView.name:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthenticationView(),
      );

    case WrapperView.name:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const WrapperView(),
      );

    case HomeView.name:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomeView(),
      );

    case CreateProductView.name:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const CreateProductView(),
      );

    case CategoryProductsView.name:
      String category = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => CategoryProductsView(category: category),
      );

    case SearchView.name:
      String query = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => SearchView(query: query),
      );

    case ProductDetailView.name:
      Product product = settings.arguments as Product;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => ProductDetailView(product: product),
      );

    case AddressView.name:
      String totalAmount = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => AddressView(totalAmount: totalAmount),
      );

    case OrderDetailView.name:
      Order order = settings.arguments as Order;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => OrderDetailView(order: order),
      );

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Error 404!! This view does not exist."),
          ),
        ),
      );
  }
}
