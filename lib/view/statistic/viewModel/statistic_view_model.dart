
import '../service/statistic_service.dart';
import '../view/statistic_view.dart';
import '../model/statistic_model.dart';
import 'package:flutter/material.dart';

import '../../../product/widget/null_return_widget.dart';

class StatisticViewModel extends StatefulWidget {
  final String countryName;
  const StatisticViewModel({Key key, @required this.countryName})
      : super(key: key);

  @override
  _StatisticModelStateView createState() => _StatisticModelStateView();
}

class _StatisticModelStateView extends State<StatisticViewModel> {
  Statistic statistic;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatisticService().getStatistic(widget.countryName) == null
        ? circularProgressIndicator()
        : FutureBuilder(
            future: StatisticService().getStatistic(widget.countryName),
            builder: (context, snapshot) {
              return StaticView(
                response: snapshot.data,
                countryName: widget.countryName,
              );
            });
  }
}
