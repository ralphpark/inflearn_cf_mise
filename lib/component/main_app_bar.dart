import 'package:flutter/material.dart';
import 'package:inflearn_cf_mise/constant/colors.dart';
import 'package:inflearn_cf_mise/model/stat_model.dart';
import 'package:inflearn_cf_mise/model/status_model.dart';
import 'package:inflearn_cf_mise/utils/data_utils.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key, required this.status, required this.stat, required this.region, required this.dataTime, required this.isExpanded});
  final StatusModel status;
  final StatModel stat;
  final String region;
  final DateTime dataTime;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 30,
    );
    return SliverAppBar(
      pinned: true,
      title: isExpanded
          ? null
          : Text(
        '$region ${DataUtils.getTimeFromDateTime(dateTime: dataTime)}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      centerTitle: true,
      expandedHeight: 500,
      backgroundColor: status.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                Text(
                  region,
                  style: ts.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  DataUtils.getTimeFromDateTime(dateTime: stat.dataTime),
                  style: ts.copyWith(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(height: 20),
                Text(
                  status.label,
                  style: ts.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  status.comment,
                  style: ts.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
