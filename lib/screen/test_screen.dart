import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inflearn_cf_mise/main.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test Screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder<Box>(
            valueListenable: Hive.box(testBox).listenable(),
            builder: (context, box, widget){
              return Column(
                children:
                  box.values.map((e) => Text(e.toString())).toList());
            },
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print('keys : ${box.keys.toList()}');
              print('values : ${box.values.toList()}');
            },
            child: Text('박스프린트 하기'),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              //put은 기존값을 덮어쓰고, add는 기존값을 덮어쓰지 않는다.
              //put은 데이터를 생성하거나 업데이트 할때 사용된다.
              box.put(2, 'test 999');
            },
            child: Text('박스에 값 넣기'),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print(box.getAt(2));
            },
            child: Text('특정값 가져오기'),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              box.delete(2);
            },
            child: Text('삭제하기'),
          ),
        ],
      ),
    );
  }
}
