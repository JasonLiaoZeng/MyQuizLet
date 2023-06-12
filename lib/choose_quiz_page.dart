import 'package:flutter/material.dart';
import 'quiz_page.dart';
import 'package:firebase_database/firebase_database.dart';

class ChooseQuizPage extends StatelessWidget {
  static String id = 'choose_quiz';
  final _db = FirebaseDatabase.instance.ref();

  Future<Map<String, List<question>>> getQuizzes() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await _db.ref.child("Quizzes").get();
    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    Map<String, List<question>> convertedData = {};
    //
    // data.forEach((key, value) {
    //   // final List<question> questions =
    //   //     value.convertedData[key.toString()] = value;
    //   List<question> questionList = [];
    //   value.map((obj) => obj as question).toList();
    //   convertedData[key.toString()] = value as List<question>;
    // });

    // Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    // Map<String, List<question>> convertedData = {};
    // data.forEach((key, value) {});

    print(snapshot.value);

    return convertedData;
  }

  ChooseQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List<question>>>(
      future: getQuizzes(),
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, List<question>>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = [];
          snapshot.data!.forEach((key, value) {
            children.add(
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPage(
                        questionSet: value,
                      ),
                    ),
                  );
                },
                child: Text(key),
              ),
            );
          });
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            ),
          ];
        }
        return Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: ListView(
            children: [
              Column(
                children: children,
              )
            ],
          ),
        );
      },

      // builder: Scaffold(
      //   backgroundColor: Colors.grey.shade900,
      //   body: ListView(
      //     children: [
      //       Column(
      //         children: [],
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
