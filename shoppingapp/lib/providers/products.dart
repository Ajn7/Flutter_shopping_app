import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class Products with ChangeNotifier { //ChangeNotifier used by provider for communication
 List<Product> _items=[
  Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
 ];

//  var _showFavouriteOnly=false;

 List<Product> get items{
  // if(_showFavouriteOnly){
  //   return _items.where((prodItem) => prodItem.isFavourite).toList();
  // }
  return [..._items]; //only giving a copy
 }
//  void showFavouriteOnly(){
//   _showFavouriteOnly=true;
//   notifyListeners();
//  }
//  void showAll(){
//   _showFavouriteOnly=false;
//   notifyListeners();
//  }
 Future<void> addProduct(Product product){

  final url = Uri.parse('https://flutter-update.firebaseio.com/products.json');
 //json - firebase-flutter
  return http.post(
    url,
    body: json.encode({
    'title': product.title,
    'description': product.description,
    'price': product.price,
    'imageUrl': product.imageUrl,
    'isFavourite': product.isFavourite,
  }),
  )//.catchError(onError) - here then block will also executes after catchError
  .then((response){ //works after post
    print(json.decode(response.body));  
  final newProduct = Product(
    id: DateTime.now().toString(), //id:json.decode(response.body)['name']
    title: product.title,
    description: product.description,
    price: product.price,
    imageUrl: product.imageUrl);
  _items.add(newProduct);
   notifyListeners();
  }).catchError( //catchErrors in post and .then function
    (error){
      print(error);
      throw error;
    }
  );

  // final newProduct = Product(
  //   id: DateTime.now().toString(),
  //   title: product.title,
  //   description: product.description,
  //   price: product.price,
  //   imageUrl: product.imageUrl);
  // _items.add(newProduct);
  // //_items.insert(0, newProduct); // add the new product to beginning of the list


  // notifyListeners(); //notifies the change
 }

 Product findById(String Id){
  return _items.firstWhere((prod) => prod.id==Id);
 }

 //filter products
 List<Product> get favouriteItem{
  return _items.where((prodItem) => prodItem.isFavourite).toList();
 }

 void updateProduct(String id,Product newProduct){
  final prodIndex=_items.indexWhere((prod) => prod.id==id);
  if(prodIndex > 0){
  _items[prodIndex]=newProduct;
  notifyListeners();
  }else{
    print('.....no product');
  }
 }

 void deleteProduct(String id){
  _items.removeWhere((prod) => prod.id==id);
  notifyListeners();
 }

}