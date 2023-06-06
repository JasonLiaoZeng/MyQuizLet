import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  final List<question> questionSet;
  const QuizScreen({super.key, required this.questionSet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: QuizPage(questionSet: this.questionSet),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  List<question> questionSet;
  QuizPage({required this.questionSet});
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  List<Widget> choicesPannel = [];
  int quesIndex = 0;
  List<MaterialColor> colors = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.brown,
  ];
  int score = 0;

  @override
  void initState() {
    super.initState();
    refreshChoicesPannel();
  }

  void refreshChoicesPannel() {
    choicesPannel.clear();
    for (int i = 0; i < widget.questionSet[quesIndex].choices.length; i++) {
      choicesPannel.add(Expanded(
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: colors[i],
              ),
              child: Text(
                widget.questionSet[quesIndex].choices[i],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                setState(() {
                  scoreKeeper.add(score_icon(
                    ans: widget.questionSet[quesIndex].ans,
                    index: i,
                  ));
                  if (quesIndex >= widget.questionSet.length - 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            QuizResult(scoreKeeper: scoreKeeper)));
                  } else {
                    quesIndex += 1;
                    refreshChoicesPannel();
                  }
                });
              },
            ),
          ),
        ),
      ));
    }
  }

  int getNumCorrect() {
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment(1.1, 0),
            child: Text(
              "Question ${quesIndex} of ${widget.questionSet.length}",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ),
        )),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                widget.questionSet[quesIndex].ques,
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
          flex: 4,
          child: Column(
            children: choicesPannel,
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

class score_icon extends StatelessWidget {
  const score_icon({super.key, required this.ans, required this.index});
  final int ans;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (ans == index) {
      return score_correct_icon();
    } else {
      return score_wrong_icon();
    }
  }
}

class score_correct_icon extends StatelessWidget {
  const score_correct_icon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check,
      color: Colors.green,
    );
  }
}

class score_wrong_icon extends StatelessWidget {
  const score_wrong_icon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.close,
      color: Colors.red,
    );
  }
}

void doNothing() {}

class question {
  final String ques;
  final int ans;
  final List<String> choices;

  const question({
    required this.ques,
    required this.ans,
    required this.choices,
  });
}

class QuizResult extends StatelessWidget {
  final List<Widget> scoreKeeper;
  const QuizResult({super.key, required this.scoreKeeper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Center(
            child: Column(children: [
              Text(
                "Your Score:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  children: scoreKeeper,
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
            ]),
          ),
        ));
  }
}
