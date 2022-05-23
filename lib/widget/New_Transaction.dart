
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {

  final Function addtx;

  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedDate;

  void _submitted()
  {
    if(_amountController.text.isEmpty)
    {
      return;
    }
   final enterTitle = _titleController.text;
   final enterAmount = double.parse( _amountController.text);

   if(enterTitle.isEmpty || enterAmount <=0 || _selectedDate == null){
     return;
   }
   widget.addtx(
        enterTitle,
    enterAmount,
   _selectedDate);
   Navigator.of(context).pop();
  }

  void _presentDatePicker () {
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });

    });

    print('...');
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
         top: 10,
          right: 10,
          left: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            TextField(decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
            onSubmitted: (_) => _submitted ,
            ),
            TextField(decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
            keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitted,
            ),
            Container(
              height: 60,
            child:Row(
              children: [
                Expanded(child:Text(_selectedDate == null ? 'No Date Chosen!'
                    :'Picked Date:${ DateFormat.yMd().format(_selectedDate)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),),),
                TextButton(child: const Text('Choose Date',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: _presentDatePicker,)
              ],
            ),),

            TextButton(onPressed: _submitted,
              child:  Text('Add Transaction',
                style:  TextStyle(
              color: Theme.of(context).primaryColor,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
            ),),),
          ],
        ),
      ),
    ),
    );
  }
}
