import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'quiz_page.dart';
import 'choose_quiz_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        ChooseQuizPage.id: (context) => ChooseQuizPage()
      },
    );
  }
}

void doNothing() {}

class HomePage extends StatelessWidget {
  static String id = "home";

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
                        // onPressed: () => (Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           QuizScreen(questionSet: demoQuizQuestions)),
                        // )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseQuizPage()));
                        },
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
