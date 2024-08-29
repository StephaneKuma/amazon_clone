import 'package:amazon_clone/src/models/user/user.dart';
import 'package:amazon_clone/src/ui/views/create_account.dart';
import 'package:amazon_clone/src/ui/views/otp_view.dart';
import 'package:amazon_clone/src/ui/views/phone_number_view.dart';
import 'package:flutter/material.dart';

import 'src/models/order.dart';
import 'src/models/product.dart';
import 'src/ui/views/address_view.dart';
import 'src/ui/views/admin/create_product_view.dart';
import 'src/ui/views/authentication_view.dart';
import 'src/ui/views/category_products_view.dart';
import 'src/ui/views/home_view.dart';
import 'src/ui/views/order_detail_view.dart';
import 'src/ui/views/product_detail_view.dart';
import 'src/ui/views/search_view.dart';
import 'src/ui/views/starter_view.dart';
import 'src/ui/views/wrapper_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case StarterView.name:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const StarterView(),
      );
    case AuthenticationView.name:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthenticationView(),
      );
    case CreateAccountView.name:
      final user = settings.arguments as User;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => CreateAccountView(
          user: user,
        ),
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

    case PhoneNumberView.name:
      String? phone = settings.arguments as String?;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => PhoneNumberView(phone: phone),
      );

    case OtpView.name:
      final user = settings.arguments as User;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => OtpView(
          user: user,
        ),
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
