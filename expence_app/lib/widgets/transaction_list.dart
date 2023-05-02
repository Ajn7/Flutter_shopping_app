import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final Function deleteTransaction;
  final List<Transaction> transactions;
 
  TransactionList(this.transactions,this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
     final mediaQuery=MediaQuery.of(context);
    return  transactions.isEmpty?LayoutBuilder(builder:(ctx,constraints){
      return Column(
        children: [
          Container(
            height: constraints.maxHeight*0.6,
            child: Image.asset('assets/images/image.png',fit: BoxFit.cover,)
            ),
            SizedBox(height: 10,),
          Text('No Data Available',style:TextStyle(fontSize: 18),),
        ],
      );
    }
    )
    : ListView.builder(
      itemBuilder:(ctx,index){
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
          child: ListTile(
            leading: CircleAvatar(radius: 30,child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text('\$${transactions[index].amount}')
                ),
            ),
              ),
          title:Text(
            transactions[index].title,
            style: TextStyle(fontWeight: FontWeight.bold ,fontSize:18) ,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(transactions[index].date),style: TextStyle(color: Colors.grey),
          ),
          trailing: mediaQuery.size.width>395?ElevatedButton( 
            onPressed: ()=>deleteTransaction(transactions[index].id), child: Text('Delete')
            ): IconButton(
           icon: Icon(Icons.delete_rounded),
           color: Colors.red,
           onPressed: ()=>deleteTransaction(transactions[index].id),
          ),
          ),
        );
        // return Card(
        //           child:Row(
        //             children: [
        //               Container(
        //                 margin: EdgeInsets.symmetric(
        //                   vertical: 10,
        //                   horizontal: 15,
        //                 ),
        //                 decoration: BoxDecoration(
        //                   border:Border.all(width: 2,color:Theme.of(context).primaryColorLight,),
        //                 ),
        //                 child:Text(
        //                   '\$${transactions[index].amount.toStringAsFixed(2)}',
        //                   style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 20,
        //                   color:Theme.of(context).primaryColorDark),),
        //                 ),
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text(transactions[index].title,style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold),),
        //                     Text(DateFormat.yMMMd().format(transactions[index].date),style: TextStyle(color: Colors.grey),),
        //                   ],
        //                 )
        //             ],
        //           )
        //         ); 
      },
      itemCount: transactions.length,
            
          );
  }
}