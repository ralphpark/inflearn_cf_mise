import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inflearn_cf_mise/component/card_tilte.dart';
import 'package:inflearn_cf_mise/component/category_card.dart';
import 'package:inflearn_cf_mise/component/hourly_card.dart';
import 'package:inflearn_cf_mise/component/main_app_bar.dart';
import 'package:inflearn_cf_mise/component/main_color.dart';
import 'package:inflearn_cf_mise/component/main_drawer.dart';
import 'package:inflearn_cf_mise/component/main_stat.dart';
import 'package:inflearn_cf_mise/constant/data.dart';
import 'package:inflearn_cf_mise/constant/regions.dart';
import 'package:inflearn_cf_mise/constant/status_level.dart';
import 'package:inflearn_cf_mise/model/stat_and_status_model.dart';
import 'package:inflearn_cf_mise/model/stat_model.dart';
import 'package:inflearn_cf_mise/repository/stat_repository.dart';
import 'package:inflearn_cf_mise/utils/data_utils.dart';

import '../constant/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    // Map<ItemCode, List<StatModel>> stats = {};

    List<Future> futures = [];

    for (ItemCode itemCode in ItemCode.values) {
      futures.add(StatRepository.fetchData(itemCode: itemCode));
    }
    final results = await Future.wait(futures);

    //hive에 데이터 넣기
    for (int i = 0; i < results.length; i++) {
      //ItemCode
      final key = ItemCode.values[i];
      //List<StatModel>
      final value = results[i];
      final box = Hive.box<StatModel>(key.name);
      for(StatModel stat in value){
        box.put(stat.dataTime.toString(), stat); // (key, value)
      }
    }
    return ItemCode.values.fold<Map<ItemCode, List<StatModel>>>(
        {}, (prev, itemCode) {
      final box = Hive.box<StatModel>(itemCode.name);
      prev.addAll({itemCode: box.values.toList()
      });
      return prev;
    },
    );
  }

  scrollListener() {
    bool isExpanded = scrollController.offset < (500 - kToolbarHeight);
    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<ItemCode, List<StatModel>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          // 에러가 발생하면
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('데이터를 불러오는 중에 에러가 발생했습니다.'),
              ),
            );
          }
          // 데이터가 없다면
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          Map<ItemCode, List<StatModel>> stats = snapshot.data!;
          StatModel pm10RecentStat = stats[ItemCode.PM10]![0];
          //미세먼지 최근 데이터의 현재 상태
          final status = DataUtils.getStatusFromItemCodeAndValue(
            value: pm10RecentStat.seoul,
            itemCode: ItemCode.PM10,
          );

          final ssModel = stats.keys.map((key) {
            final stat = stats[key]![0];
            return StatAndStatusModel(
                itemCode: key,
                stat: stat,
                statusModel: DataUtils.getStatusFromItemCodeAndValue(
                  value: stat.getLevelFromRegion(region),
                  itemCode: key,
                ));
          }).toList();
          return Scaffold(
            drawer: MainDrawer(
              darkColor: status.darkColor,
              lightColor: status.lightColor,
              selectedRegion: region,
              onRegionSelected: (String region) {
                setState(() {
                  this.region = region;
                });
                Navigator.of(context).pop();
              },
            ),
            body: Container(
              color: status.primaryColor,
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  MainAppBar(
                    isExpanded: isExpanded,
                    dataTime: pm10RecentStat.dataTime,
                    region: region,
                    stat: pm10RecentStat,
                    status: status,
                  ),
                  SliverToBoxAdapter(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryCard(
                        darkColor: status.darkColor,
                        lightColor: status.lightColor,
                        models: ssModel,
                        region: region,
                      ),
                      SizedBox(height: 16),
                      ...stats.keys.map(
                        (itemCode) {
                          // 리스트안에 리스트 형태는 불가하기 때문에 하위 리스트는 ...을 붙여서 풀어준다.
                          final stat = stats[itemCode]!;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: HourlyCard(
                              darkColor: status.darkColor,
                              lightColor: status.lightColor,
                              category: DataUtils.getItemCodeKrString(
                                itemCode: itemCode,
                              ),
                              stats: stat,
                              region: region,
                            ),
                          );
                        },
                      ).toList(),
                      SizedBox(height: 16),
                    ],
                  )),
                ],
              ),
            ),
          );
        });
  }
}
