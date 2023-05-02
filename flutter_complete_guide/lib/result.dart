import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int total;
  final Function rest;
  Result(this.total,this.rest);
  String get resultPhase{
   String result;
   if(total<10){
    result='Bad!';
   }else{
    result='Good!';
   }
   return result;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(resultPhase,style: TextStyle(fontSize: 30),),
        TextButton(child:Text('Restart'),onPressed: rest),
      ],
    );
  }
}