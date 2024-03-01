import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inflearn_cf_mise/component/card_tilte.dart';
import 'package:inflearn_cf_mise/component/main_color.dart';
import 'package:inflearn_cf_mise/component/main_stat.dart';
import 'package:inflearn_cf_mise/constant/colors.dart';
import 'package:inflearn_cf_mise/model/stat_and_status_model.dart';
import 'package:inflearn_cf_mise/utils/data_utils.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.models, required this.region, required this.darkColor, required this.lightColor});

  final List<StatAndStatusModel> models;
  final String region;
  final Color darkColor;
  final Color lightColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(
            builder: (context, constraint) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CardTitle(
                    backgroundColor: darkColor,
                    title: '종류별통계',
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: PageScrollPhysics(),
                      children: models.map((model) =>
                          MainStat(
                            width: constraint.maxWidth / 3,
                            category: DataUtils.getItemCodeKrString(
                                itemCode: model.itemCode),
                            imgPath: model.statusModel.imagePath,
                            level: model.statusModel.label,
                            stat: '${model.stat.getLevelFromRegion(
                                region)}${DataUtils.getUnitFromItemCode(
                              itemCode: model.itemCode,)}',
                          ),
                      ).toList(),
                      //   List.generate(
                      //     20,
                      //     (index) => MainStat(
                      //       width: constraint.maxWidth / 3,
                      //       category: '미세먼지$index',
                      //       imgPath: 'asset/img/best.png',
                      //       level: '최고',
                      //       stat: '0㎍/㎥',
                      //     ),
                      // ),
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}
