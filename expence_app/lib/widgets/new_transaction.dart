import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
 final Function addTx;
 NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
 final _titleController=TextEditingController();
 final _amountController=TextEditingController();
 DateTime _selectDate;



 void _submitted(){
   if(_amountController.text.isEmpty){
  return;
 }
  String title=_titleController.text;
  double amount= double.parse(_amountController.text);
  if(title.isEmpty || amount<=0 || _selectDate==null){
      return;
  }
  
  widget.addTx(title, amount,_selectDate);
  Navigator.of(context).pop(); //to remove bottom sheet
 }
 void _presentDatePicker(){
  showDatePicker(
   context: context,
   initialDate: DateTime.now(), 
   firstDate: DateTime(2020), 
   lastDate: DateTime.now()
   ).then((pickedDate){
    if (pickedDate==null){
      return;
    }
   
    setState(() {
       _selectDate=pickedDate;
    });
   });
 }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Card(
              elevation: 5,
              child:Container(
                padding: EdgeInsets.only(
                  top:10,
                  left: 10,
                  right:10,
                  bottom:MediaQuery.of(context).viewInsets.bottom+10 // keyboard overlay solution
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  controller: _titleController,
                  onSubmitted: (_) {
                    _submitted;
                  },
                  // onChanged:(val){
                  //   titleInput=val;
                  // },
                  ),
                  TextField(decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  // onChanged:(val){
                  //   amountInput=val;
                  // },
                  onSubmitted:(_){
                    _submitted;
                  } ,
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: [
                      Expanded(
                        child: Text(
                          _selectDate==null?'No Date Choosen!':'Picked Date : ${DateFormat.yMd().format(_selectDate)}' 
                          )
                          ),
                      TextButton(
                        onPressed: (){
                          _presentDatePicker();
                        },
                        child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),),)
                    ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed:_submitted,
                    child: Text(
                      'Add Transaction',
                      style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                        ),
                      )
                    )
                ],
                        ),
              ),
              ),
    );
  }
}