import 'package:inflearn_cf_mise/model/status_model.dart';

import 'stat_model.dart';

class StatAndStatusModel{
  final ItemCode itemCode;
  final StatusModel statusModel;
  final StatModel stat;

  StatAndStatusModel({
    required this.itemCode,
    required this.statusModel,
    required this.stat,
  });
}