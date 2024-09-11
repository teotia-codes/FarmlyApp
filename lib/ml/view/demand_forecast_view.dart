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
      body: Center(
        child: Container(
          color: Color(0xFFFFF8E1), // Pale yellow background
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height / 2, // Half screen height
          child: SfCartesianChart(
            backgroundColor: Colors.white,
            borderColor: Colors.grey.shade300,
            primaryXAxis: DateTimeAxis(
              intervalType: DateTimeIntervalType.days,
              dateFormat: DateFormat('d MMM'),
              majorGridLines: MajorGridLines(width: 0),
              axisLine: AxisLine(width: 2),
            ),
            primaryYAxis: NumericAxis(
              majorGridLines: MajorGridLines(width: 0),
              axisLine: AxisLine(width: 2),
            ),
            series: <SplineSeries<ChartData, DateTime>>[
              SplineSeries<ChartData, DateTime>(
                dataSource: _getChartData(),
                xValueMapper: (ChartData data, _) => data.date,
                yValueMapper: (ChartData data, _) => data.value,
                color: Colors.blue,
                splineType: SplineType.natural, // Smooth spline
                markerSettings: MarkerSettings(
                  isVisible: true, // Show markers
                  shape: DataMarkerType.circle, // Circle markers
                  color: Colors.blue.shade700,
                  borderColor: Colors.white,
                  borderWidth: 2,
                ),
                name: 'Demand',
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ChartData> _getChartData() {
    return [
      ChartData(DateTime(2024, 1, 15), 518.81),
      ChartData(DateTime(2024, 1, 30), 658.81),
      ChartData(DateTime(2024, 2, 15), 700.50),
      ChartData(DateTime(2024, 2, 30), 750.25),
      ChartData(DateTime(2024, 3, 15), 800.00), // Predicted 75th day
    ];
  }
}

class ChartData {
  final DateTime date;
  final double value;

  ChartData(this.date, this.value);
}
