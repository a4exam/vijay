import 'package:flutter/material.dart';
import 'package:mcq/checkScore/cut_off.dart';
import 'package:mcq/checkScore/your_score.dart';

import 'admit_card.dart';
import 'check_score.dart';
import 'key_url.dart';

class CutoffScore extends StatefulWidget {
  const CutoffScore({super.key});

  @override
  State<CutoffScore> createState() => _CutoffScoreState();
}

class _CutoffScoreState extends State<CutoffScore> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: mq.height*.10,
          bottom: TabBar(
            indicatorColor: Colors.white70,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4,
            tabs: [
              Container(
                margin: EdgeInsets.only(bottom: mq.height*.025),
                child: const Row(
                  children: [
                    Icon(
                      Icons.equalizer,
                      color: Colors.white,
                      size: 35,
                    ),
                    Text(
                      'Cut-off',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: mq.height*.025),
                child: const Row(
                  children: [
                    Icon(
                      Icons.speed,
                      color: Colors.white,
                      size: 35,
                    ),
                    Text(
                      'Your Score',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
              // Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
          title: const Text(
            'Exam name',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: const TabBarView(
          children: [
            CutOff(),
            YourScore()
          ],
        ),
      ),
    );
  }
}
