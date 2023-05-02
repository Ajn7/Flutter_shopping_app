
import 'package:flutter/foundation.dart';

class CartItem {
 final String id;
 final String title;
 final int quantity;
 final double price;

CartItem({
  @required this.id,
  @required this.title,
  @required this.quantity,
  @required this.price,
});

}

class Cart with ChangeNotifier{
  Map<String,CartItem> _items={};

  Map<String,CartItem> get items{
    return {..._items};
  }
  void addItems(String prodId,double price,String title){

    if(_items.containsKey(prodId)){
      _items.update(prodId
      , (existingValue) => CartItem(
        id: existingValue.id,
        title: existingValue.title,
        quantity: existingValue.quantity + 1,
        price: existingValue.price),);
    }else{
      _items.putIfAbsent(
        prodId,
        ()=>CartItem(
          id:DateTime.now().toString(),
          title: title,
          price:price,
          quantity: 1),
          );
    }
    notifyListeners();
  }
  int get itemCount{
    return _items.length;
  }
  double get totalAmount{
    var total=0.0;
     _items.forEach((key, cartItem) {
      total+=cartItem.price * cartItem.quantity;
    });
    return total;
  }
  void removeItem(String prodId){
    _items.remove(prodId);
    notifyListeners();

  }

  void clear(){
    _items={};
    notifyListeners();
      }

      void removeSingleItem(String prodId){
        if(!_items.containsKey(prodId))
        {
            return;
          }    
        if(_items[prodId].quantity > 1){
          _items.update(prodId, (existingItem) => CartItem(
            id: existingItem.id,
            title:existingItem.title,
            quantity:existingItem.quantity - 1,
            price:existingItem.price));
        }else{
          _items.remove(prodId);
        }
        notifyListeners();
      }
}