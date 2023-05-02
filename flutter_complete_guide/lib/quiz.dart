import 'package:flutter/material.dart';
import './qusetion.dart';
import './answer.dart';
class Quiz extends StatelessWidget {
  final List<Map<String,Object>> questions;
  final int questionsIndex;
  final Function answerQuestion;
  Quiz({
    @required this.answerQuestion,
    @required this.questions,
    @required this.questionsIndex
    });

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Question(questions[questionsIndex]['qusetionText'] as String,),
            ...(questions[questionsIndex]['answers'] as List<Map<String,Object>>).map((answer) {
              return Answer(() => answerQuestion((answer['score'])),answer['text'] as String);
            }).toList(),
          ],
        );
  }
}