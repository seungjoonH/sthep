import 'package:flutter/material.dart';
import 'package:sthep/global/global.dart';
import 'package:sthep/model/user/user.dart';
import 'package:sthep/config/palette.dart';
import 'package:sthep/model/question/question.dart';
import 'package:sthep/page/widget/profile.dart';

bool isGrid = true;
User tempUser = User(
  id: 'zihoo1234',
  name: '양지후',
  nickname: 'zihoo',
  password: '',
);

Question tempQuestion = Question(
  id: 1,
  title: "2016년도 수능 알려주세요..",
  questioner: tempUser,
  image: Image.asset(
    'assets/images/math.jpeg',
    height: 200.0,
  ),
);

PreferredSizeWidget mainPageAppBar = AppBar(
  backgroundColor: Palette.appbarColor,
  foregroundColor: Palette.iconColor,
  title: Image.asset(
    'assets/images/logo_horizontal.png',
    fit: BoxFit.contain,
    width: 120,
  ),
  actions: [
    Builder(builder: (context) {
      return IconButton(
          onPressed: () => Navigator.pushNamed(context, '/My'),
          icon: const Icon(Icons.search));
    }),
    StatefulBuilder(
      builder: (context, setState) => IconButton(
        onPressed: () => setState(() => isGrid = !isGrid),
        icon: Icon(
          isGrid ? Icons.list_alt : Icons.window,
        ),
      ),
    ),
    StatefulBuilder(
      builder: (context, setState) => IconButton(
        onPressed: () => Scaffold.of(context).openEndDrawer(),
        icon: const Icon(Icons.menu),
      ),
    ),
  ],
);

class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  // animation control variables
  bool animate = true;
  int aniVelocity = 15000;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: aniVelocity), vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });

    _animation.addListener(() => setState(() {}));

    late final Animation<Offset> _offsetAnimation = Tween<Offset>(
      begin: Offset(animate ? 1.0 : 0.0, 0.0),
      end: Offset(animate ? -1.0 : 0.0, 0.0),
    ).animate(_animation as Animation<double>);


    return SlideTransition(
      position: _offsetAnimation,
      child: Stack(
        children: [
          Positioned(
            child: SizedBox(
              height: 100.0,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: myText('오늘의 최다 답변자', 20.0, Palette.fontColor1),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    color: Colors.yellow,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                  profile(tempUser),
                  const SizedBox(width: 30),
                  Container(
                    width: 30,
                    height: 30,
                    color: Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                  profile(tempUser),
                  const SizedBox(width: 30),
                  Container(
                    width: 30,
                    height: 30,
                    color: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                  profile(tempUser),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          elevation: 10.0,
          margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/images/math.jpeg',
                    height: 200.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      myText('#수학', 10.0, Palette.hyperColor),
                      const SizedBox(width: 8),
                      myText('#수능', 10.0, Palette.hyperColor),
                      Expanded(
                        child: Container(),
                      ),
                      myText('5 min ago', 10.0, Colors.grey),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      myText(tempQuestion.title, 20.0, Colors.black),
                      const SizedBox(height: 50.0),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: simpleProfile(tempUser)),
                      const Icon(Icons.comment_rounded, size: 20.0),
                      const SizedBox(width: 5.0),
                      myText('5', 15.0, Colors.black),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 30,
          top: 10,
          child: adoptState,
        ),
      ],
    );
  }
}
