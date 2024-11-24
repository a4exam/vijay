import 'package:flutter/material.dart';
import 'package:mcq/checkScore/sco1.dart';



class SingleCardView extends StatelessWidget {
  const SingleCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RankTile(
            title: "Rank",
            rank: 25315,
            total: 126432,
            progress: 25315 / 126432,
          ),
          RankTile(
            title: "Rank after normalisation",
            rank: 25465,
            total: 126432,
            progress: 25465 / 126432,
          ),
          RankTile(
            title: "Category Rank - OBC",
            rank: 2545,
            total: 126432,
            progress: 2545 / 126432,
          ),
          RankTile(
            title: "Category Rank AN - OBC",
            rank: 2505,
            total: 126432,
            progress: 2505 / 126432,
          ),
        ],
      ),
    );
  }
}


