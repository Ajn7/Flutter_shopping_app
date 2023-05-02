import 'package:flutter/material.dart';

import './result.dart';
import './quiz.dart';
void  main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _MyappState();
  }
}
class _MyappState extends State<MyApp>{
  final _question = const[
                    {
                    'qusetionText':'What is your favourite color?',
                    'answers':[{'text':'Black','score':10},{'text':'Red','score':3},{'text':'Blue','score':7}]
                    },
                    {
                      'qusetionText':'what is your favourite animal?',
                      'answers':[{'text':'Lion','score':10},{'text':'Cat','score':3},{'text':'Dog','score':5}]
                      },
                    {'qusetionText':'What is your favourite car?',
                    'answers':[{'text':'BMW','score':5},{'text':'Benz','score':10},{'text':'Audi','score':3}]
                    },
                   ];
  var _questionIndex = 0;
  var _total = 0;
  _answerQuestion(int score){
    _total+=score;
    setState(() {
       _questionIndex=_questionIndex+1;
    });
    
    print('Answer 1');
    print(_questionIndex);
  }
  void _resetQuiz(){
    setState(() {
      _questionIndex=0;
    _total=0;
    });
    
  }
  @override
  Widget build(BuildContext context){
    
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(title:Text('My First App'),),
        body: _questionIndex < _question.length
         ? Quiz(answerQuestion:_answerQuestion,
          questions:_question,
          questionsIndex:_questionIndex
          ):Center(
          child:Result(_total,_resetQuiz),
        )
      ),
    );
  }
}