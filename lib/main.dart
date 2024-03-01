import 'package:flutter/material.dart';
import 'package:inflearn_cf_mise/model/stat_model.dart';
import 'package:inflearn_cf_mise/screen/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inflearn_cf_mise/screen/test_screen.dart';

const testBox = 'test';


void main() async {

  await Hive.initFlutter();  // NoSQL DB

  Hive.registerAdapter<StatModel>(StatModelAdapter()); //코드제너레이션 이후 등록 코드
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter()); //코드제너레이션 이후 등록 코드

  await Hive.openBox(testBox); // NoSQL DB

  for(ItemCode itemCode in ItemCode.values){
    await Hive.openBox<StatModel>(itemCode.name);
  }

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'sunflower',
      ),
      home: HomeScreen(),
    )
  );
}

// 미세먼지 API 링크
// https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15073855
//일반 인증키(Encoding)
// sfXt%2FeIO7IfeUJBq8oyIDALUeUSwfEuI22l5L34J24QZ%2B7HUxNnMYDSUNh1RaNDYnYQ3WarXO57FCZ%2Fgim%2Be3Q%3D%3D
//일반 인증키(Decoding)
// sfXt/eIO7IfeUJBq8oyIDALUeUSwfEuI22l5L34J24QZ+7HUxNnMYDSUNh1RaNDYnYQ3WarXO57FCZ/gim+e3Q==
// endpoint
// http://apis.data.go.kr/B552584/ArpltnStatsSvc

// 시도별 실시간 평균정보 조회
// getCtprvnMesureLIst
// Call Back URL
// http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst