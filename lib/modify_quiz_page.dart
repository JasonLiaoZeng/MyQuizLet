import 'package:flutter/material.dart';
import 'quiz_page.dart';
import 'package:firebase_database/firebase_database.dart';

void doNodthing() {}

class ModifyQuizPage extends StatelessWidget {
  static String id = 'modify_quiz';
  final _db = FirebaseDatabase.instance.ref();

  Future<Map<String, List<question>>> getQuizzes() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await _db.ref.child("Quizzes").get();
    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    Map<String, List<question>> convertedData = {};

    data.forEach((key, value) {
      var objList = value as List<dynamic>;
      List<question> questionSet =
          objList.map((e) => question.fromJson(e)).toList();
      convertedData[key.toString()] = questionSet;
    });

    return convertedData;
  }

  ModifyQuizPage({super.key});

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
              SizedBox(
                width: 400,
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                        ),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              key,
                            ),
                            Icon(Icons.edit),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        color: Colors.greenAccent,
                        icon: Icon(Icons.cloud_upload_outlined),
                        onPressed: doNothing,
                      ),
                    )
                  ],
                ),
              ),
            );
          });
          children.add(
            SizedBox(
                width: 400,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.orangeAccent,
                        ),
                        onPressed: doNothing,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle_outline),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        color: Colors.redAccent,
                        icon: Icon(Icons.cloud_download_outlined),
                        onPressed: doNothing,
                      ),
                    )
                  ],
                )),
          );
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
          body: SafeArea(
            child: Column(
              children: [
                Text(
                  "MyQuizLet",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        children: children,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Return to Home Screen',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
