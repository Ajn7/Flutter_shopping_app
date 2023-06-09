// import 'package:flutter/material.dart';

// import '../screens/orders_screen.dart';

// class AppDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: <Widget>[
//           AppBar(
//             title: Text('Hello Friend!'),
//             automaticallyImplyLeading: false, //never add back button
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.shop),
//             title: Text('Shop'),
//             onTap: () {
//               Navigator.of(context).pushReplacementNamed('/'); //back to rrot
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.payment),
//             title: Text('Orders'),
//             onTap: () {
//               Navigator.of(context)
//                   .pushReplacementNamed(OrdersScreen.routeName);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shoppingapp/helpers/custom_route.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(OrdersScreen.routeName);
              Navigator.of(context).pushReplacement(
                CustomRoute(
                  builder:(ctx)=>OrdersScreen()
                ),
                );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
