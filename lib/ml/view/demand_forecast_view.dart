import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart'; // For date formatting

class DemandForecastingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demand Forecasting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(
            intervalType: DateTimeIntervalType.months,
            dateFormat: DateFormat.yMMM(),
          ),
          primaryYAxis: NumericAxis(),
          series: <CartesianSeries>[
            SplineSeries<ChartData, DateTime>(
              dataSource: _getChartData(),
              xValueMapper: (ChartData data, _) => data.date,
              yValueMapper: (ChartData data, _) => data.value,
              name: 'Demand',
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  List<ChartData> _getChartData() {
    return [
      ChartData(DateTime(2024, 1, 1), 518.81),
      ChartData(DateTime(2024, 2, 1), 658.81),
      ChartData(DateTime(2024, 3, 1), 700.50),
      ChartData(DateTime(2024, 4, 1), 750.25),
      ChartData(DateTime(2024, 5, 1), 800.00), // Predicted 5th month sales
    ];
  }
}

class ChartData {
  final DateTime date;
  final double value;

  ChartData(this.date, this.value);
}
