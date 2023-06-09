import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/helpers/custom_route.dart';


import '../screens/cart_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/orders_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //value:Products(),
          create:(context) => Products(), //create or builder attribute name
         ),
        ChangeNotifierProvider(
          create:(context) => Cart(),
          ),
          ChangeNotifierProvider(
          create:(context) => Orders(),
          ),
        ],       
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.deepOrange,
          fontFamily:'Lato',
          //evey route has same animation
          // pageTransitionsTheme: PageTransitionsTheme( 
          //   builders: {
          //     TargetPlatform.android:CustomPageTransitionBuiler(), 
          //   }
          // ),
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routName:(ctx)=> ProductDetailScreen(),
          CartScreen.routeName:(ctx)=> CartScreen(),
          OrdersScreen.routeName:(ctx)=> OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),

        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
