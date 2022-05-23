
import '../models/Transaction.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

  class TransactionList extends StatelessWidget {

    final List<Transaction> transactions;
    final Function deleteTx;

    TransactionList(this.transactions,this.deleteTx);


    @override
    Widget build(BuildContext context) {
      return  transactions.isEmpty ?
      LayoutBuilder(builder: (ctx ,constraints) {
        return     Column(
          children: [
           const Text('No Transaction Added Yet!',
                style: TextStyle(fontFamily: 'Quicksand',fontSize: 15,fontWeight: FontWeight.bold)),
           const SizedBox(
              height: 15,
            ),
            Container(
                height: constraints.maxHeight * 0.6 ,
                child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,))
          ],
        );

      },)
           : ListView.builder(
           itemBuilder: (ctx,index){
             return Card(
               elevation: 5,

                     margin: const EdgeInsets.symmetric(
                       vertical: 10,
                       horizontal: 15,

                     ),

               child: ListTile(
                 leading: CircleAvatar(
                   radius: 30,
                   child: Padding(
                     padding: const EdgeInsets.all(6),
                     child: FittedBox(
                       child: Text('\$${transactions[index].amount}'),

                     ),
                   ),
                 ),
                 title: Text(
                   transactions[index].title,
                   style: const TextStyle(fontWeight: FontWeight.bold),
                   //Theme.of(context).textTheme.titleMedium,

                 ),
                 subtitle: Text(
                   DateFormat.yMMMd().format(transactions[index].date),
                 ),
                 trailing: MediaQuery.of(context).size.width > 460
                   ? FlatButton.icon(onPressed: () => deleteTx(transactions[index].id),
                     icon: const Icon(Icons.delete),
                     label: const Text('Delete'),
                 textColor: Theme.of(context).errorColor,)
                         : IconButton(
                   icon: const Icon(Icons.delete),
                   color: Theme.of(context).errorColor,
                   onPressed: () => deleteTx(transactions[index].id),
                 ),
               ),
               );
           },

         itemCount: transactions.length,



       );
    }
  }
