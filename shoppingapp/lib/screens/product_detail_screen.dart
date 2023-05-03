import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // ProductDetailScreen(this.title);
  static const routName='/productDetailScreen';
  @override
  Widget build(BuildContext context) {
    final productId=ModalRoute.of(context).settings.arguments as String;
    final loadProduct=Provider.of<Products>(context,listen: false).findById(productId); //listen:false change happens but donot rebuilds this sectio
    return  Scaffold(
      // appBar: AppBar(
      //   title: Text(loadProduct.title),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(title:Text(loadProduct.title) ,
            background:Hero(
                tag: loadProduct.id,
                child: Image.network(loadProduct.imageUrl,fit: BoxFit.cover,),
                ),),
          ),
          SliverList(
            delegate:SliverChildListDelegate(
                [
            SizedBox(height:10),
            Text('\$${loadProduct.price}',style:TextStyle(color:Colors.grey,fontSize: 20)),
            SizedBox(height:10),
            Container(
              padding:EdgeInsets.symmetric(horizontal: 10) ,
              width:double.infinity,
              child: Text(
                loadProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,),
                ),
                SizedBox(height: 800,),
                ]
            ),
             ),
        ],
      ) ,
    
    );
  }
}