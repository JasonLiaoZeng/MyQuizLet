import 'package:flutter/material.dart';
import 'quiz_page.dart';

void main() {
  runApp(MaterialApp(home: Quizzler()));
}

void doNothing() {}

class Quizzler extends StatelessWidget {
  List<question> demoQuizQuestions = [
    const question(
      ques: "1+1=?",
      ans: 1,
      choices: ['1', '2', 'IDK'],
    ),
    const question(
        ques: "Who is the Creater of this app?",
        ans: 0,
        choices: ['Jason Liao-Zeng', 'ChatGPT 4.0', 'Elun Musk']),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "WELCOME TO MYQUIZLET",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () => (Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  QuizScreen(questionSet: demoQuizQuestions)),
                        )),
                        child: const Text(
                          'Choose Quiz',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: TextButton(
                        onPressed: doNothing,
                        child: Text(
                          'Modify Quizzes',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
