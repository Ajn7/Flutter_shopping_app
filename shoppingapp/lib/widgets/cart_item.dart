
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String prodId;
  final double price;
  final int quantity;
  final String title;
  CartItem(
     this.id,
     this.prodId,
    this.price,
    this.quantity,
    this.title);
  @override
  Widget build(BuildContext context) {

    return  Dismissible(
      key: ValueKey(id),
      background: Container(color: Theme.of(context).errorColor,
      child: Icon(
        Icons.delete,
        color: Colors.white,
        size:40,
      ),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
       margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (directio){
         return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure ?'),
            content: Text('Do you want to remove'),
            actions: [
              ElevatedButton(
                onPressed: (){
                  Navigator.of(ctx).pop(false);
                }
              , child:Text('No')
              ),
               ElevatedButton(
                onPressed: (){
                  Navigator.of(ctx).pop(true);
                }
              , child:Text('Yes')
              )
            ],
          ),
          );
          
      },
      onDismissed:(direction){
        Provider.of<Cart>(context,listen: false).removeItem(prodId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
        child:Padding(padding: EdgeInsets.all(8),
        child:ListTile(
          leading:CircleAvatar(
            child:FittedBox(child: Text('\$${price}'))
          ),
          title: Text(title),
          subtitle:Text('Total \$${(price*quantity)}'),
          trailing: Text('$quantity x'),
          ),
          ),
      ),
    );
  }
}