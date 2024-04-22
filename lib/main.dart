import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main()=> runApp(Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon>scorekeeper = [];

  //List<String>Question = [
   // 'You can lead a cow down stairs but not up stairs.',
    //'Approximately one quarter of human bones are in the feet.',
    //'A slug\'s blood is green.',
  //];
  //List<bool>answer = [
    //false,
    //true,
    //true
  //];

  //Question q1 = Question(q: "You can lead a cow down stairs but not up stairs.", a: false);

  void checkAnswer(bool userPickedAnswer){
    bool crrectAnswer = quizBrain.getCorrectAnswer();

   setState(() {
     //use if/else to check if we have reached the end of the quiz, if so show an alert using rFlutter_alert, reset the question number, and empty out the scorekeeper.
     //if we have not reached the end, else do the answer checking steps below
     if (quizBrain.isFinished()) {
       // Show alert using rFlutter_alert
       Alert(
         context: context,
         title: 'Quiz Finished!',
         desc: 'You have reached the end of the quiz.',
       ).show();

       // Reset question number and empty score keeper
       quizBrain.reset();
       scorekeeper = [];
     }
     if (
     userPickedAnswer==crrectAnswer){
       scorekeeper.add(Icon(Icons.check,color: Colors.green,));
     }
    else{
      scorekeeper.add(Icon(Icons.close,color: Colors.red,));
    }

      quizBrain.nextQuestion();
   });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(child:
        Padding(
          padding:EdgeInsets.all(10),
        child: Center(
          child: Text(
            quizBrain.getQuestionText(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),),
        ),),
          flex: 5,
        ),
        Expanded(child:
        Padding(padding: EdgeInsets.all(15),
        child: MaterialButton(
         color: Colors.green,
         textColor: Colors.white,
         child: Text(
           "True",
           style: TextStyle(
             fontSize: 20,
             color: Colors.white
           ),
         ),

         onPressed: (){
          checkAnswer(true);
         },
        ),
        ),
        ),
        Expanded(child:
    Padding(padding: EdgeInsets.all(15),
    child: MaterialButton(
    color: Colors.red,
    textColor: Colors.white,
    child: Text(
    "False",
    style: TextStyle(
    fontSize: 20,
    color: Colors.white
    ),
    ),

    onPressed: (){

      checkAnswer(false);
    },
    ),
    ),
    ),
        Row(
          children: scorekeeper),
      ],
    );
  }
}
