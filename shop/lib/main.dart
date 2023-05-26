import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/screens/auth_screen.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/product_detail_screen.dart';
import 'package:shop/screens/product_form_screen.dart';
import 'package:shop/screens/products_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';
import 'package:shop/utils/app_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato',
        ),
        // home: const ProductsOverviewScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.AUTH: (ctx) => const AuthScreen(),
          AppRoutes.HOME: (ctx) => const ProductsOverviewScreen(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailScreen(),
          AppRoutes.CART: (ctx) => const CartScreen(),
          AppRoutes.ORDERS: (ctx) => const OrdersScreen(),
          AppRoutes.PRODUCTS: (ctx) => const ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => const ProductFormScreen(),
        },
      ),
    );
  }
}
