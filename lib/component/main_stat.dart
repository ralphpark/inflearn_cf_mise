import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  const MainStat({
    super.key,
    required this.category,
    required this.imgPath,
    required this.level,
    required this.stat, required this.width,
  });
  // 미세먼지, 초미세먼지 등
  final String category;
  // 아이콘 위치(경로)
  final String imgPath;
  // 오염 정도
  final String level;
  // 오염 수치
  final String stat;
  final double width;

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.black,);

    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category,
            style: ts,
            ),
          SizedBox(height: 8),
          Image.asset(
            imgPath,
            width: 50,
          ),
          SizedBox(height: 8),
          Text(
            level,
            style: ts
          ),
          SizedBox(height: 8),
          Text(
            stat,
            style: ts
          ),
        ],
      ),
    );
  }
}
