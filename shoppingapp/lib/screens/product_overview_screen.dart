import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';

enum filterOptions{
  Favourite,
  All

}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavourites=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (selectdValue){
              setState(() {
                 if(selectdValue==filterOptions.Favourite){
                _showFavourites=true;
              }else{
               _showFavourites=false;
              }
              });
             
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_)=>[
              PopupMenuItem(
                child: Text('Only Favorite'),
                value: filterOptions.Favourite,
                ),
              PopupMenuItem(
                child: Text('Show All'),
                value: filterOptions.All,
                ),
            ],
            ),
          Consumer<Cart>(
            builder: (_,cart,ch) =>
            Badges(
              child:ch,
           value:cart.itemCount.toString()),
           child: IconButton(onPressed: (){
            Navigator.of(context).pushNamed(CartScreen.routeName);
           // cart.addItems,
           }, //this wont rebuilds
           icon: Icon(
            Icons.shopping_cart,
           ),
           ), 
          ),
        ],
      ),
      drawer: AppDrawer(),
      body:ProductGrid(_showFavourites),
    );
  }
}

