import 'package:flutter/material.dart';
import 'package:sthep/global/global.dart';
import 'package:sthep/page/main/home/home_materials.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    screenSize = MediaQuery.of(context).size;

    return GridView.count(
      padding: const EdgeInsets.all(30.0),
      crossAxisCount: 3,
      children: List.generate(100, (index) {
        return const Center(
          child: QuestionCard(),
        );
      }),
    );
  }
}

