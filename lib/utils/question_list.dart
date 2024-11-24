
import 'package:mcq/models/question_model.dart';

List<QuestionModel> questionList = <QuestionModel>[
  QuestionModel(
    enQuestion: Question(
      bookName: "DP Constable",
      question: "this is en que 1",
      option: ["enOp1","enOp2","enOp3","enOp4"],
      rightOption: "op2",
      solution: "this is solution"
    ),
    hiQuestion: Question(
        bookName: "DP Constable",
        question: "this is hi que 1",
        option: ["hiOp1","hiOp2","hiOp3","hiOp4"],
        rightOption: "op2",
        solution: "this is solution"
    ),
  ),
  QuestionModel(
    enQuestion: Question(
      bookName: "DP Constable",
      question: "this is en que 2",
      option: ["op1","op2","op3","op4"],
      rightOption: "op2",
      solution: "this is solution"
    ),
    hiQuestion: Question(
        bookName: "DP Constable",
        question: "this is hi que 2",
        option: ["hiOp1","hiOp2","hiOp3","hiOp4"],
        rightOption: "op2",
        solution: "this is solution"
    ),
  ),
];
