import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/product.dart';
import '../providers/cart.dart';

import '../screens/product_detail_screen.dart';


class ProductItem extends StatelessWidget {
  
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context,listen: false);
    final cart=Provider.of<Cart>(context,listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(
               ProductDetailScreen.routName,
               arguments:product.id, 
                );
            },
            child: FadeInImage.assetNetwork(
              image:product.imageUrl,
              fit:BoxFit.cover,
              placeholder:'assets/images/nonetwork.png',
             
              ),
          ),
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              title: Text(
                product.title,
                textAlign: TextAlign.center,
                ),
                leading:  Consumer<Product>(  // now only iconButton rebuilds
                  builder: (ctx,product,child)=>IconButton(
                  onPressed: (){
                    product.toggleFavouriteStatus();
                  },
                  icon: Icon(
                    product.isFavourite ?Icons.favorite:Icons.favorite_border,
                  ),
                  color:Theme.of(context).accentColor
                  ),
                ),
                trailing: IconButton(
                  icon:Icon(
                    Icons.shopping_cart
                    ),
                    onPressed: (){
                      cart.addItems(product.id, product.price, product.title);
                      //Scaffold.of(context).hideCurrentSnackBar();
                      // Scaffold.of(context).showSnackBar(
                      // SnackBar(
                      // content: Text('Added item to the cart'),
                      // duration: Duration(seconds: 3),
                      // action:SnackBarAction(
                      // label:'UNDO', 
                      // onPressed: (){
                      //   cart.removeSingleItem(product.id);
                      // }
                      // ),
                      // ),
                      // );
                     
                    },
                    color:Theme.of(context).accentColor
                 ),
            ),
        ),
      );
  }
}