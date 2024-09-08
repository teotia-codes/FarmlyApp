
import 'package:app/utils/texttheme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SyncfusionGaugeView extends StatefulWidget {
  final String label; // Label passed through the widget

  const SyncfusionGaugeView({super.key, required this.label});

  @override
  State<SyncfusionGaugeView> createState() => _SyncfusionGaugeViewState();
}

class _SyncfusionGaugeViewState extends State<SyncfusionGaugeView> {
  double value = 80; // Example gauge value

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 100,
              startAngle: 180, // Start from left
              endAngle: 0, // End at right
              showLabels: false,
              showTicks: false,
              axisLineStyle: AxisLineStyle(
                thickness: 0.05, // Slightly increased thickness for the line
                thicknessUnit: GaugeSizeUnit.factor,
                cornerStyle:
                    CornerStyle.bothCurve, // Rounded edges for the line
                gradient: SweepGradient(
                  colors: [Colors.red, Colors.orange, Colors.green],
                  stops: [0.33, 0.66, 1.0], // Stop positions for gradient
                ),
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  value: value,
                  width: 0.05, // Increased line thickness
                  pointerOffset: 0.05,
                  color: Colors.transparent, // Transparent to show gradient
                  cornerStyle: CornerStyle.bothCurve,
                  gradient: const SweepGradient(
                    colors: [Colors.red, Colors.orange, Colors.green],
                    stops: [0.33, 0.66, 1.0],
                  ),
                ),
                MarkerPointer(
                  value: value,
                  markerHeight: 10,
                  markerWidth: 10,
                  markerType: MarkerType.circle, // Triangle pointer
                  color: Colors.black, // Black triangle pointer
                  enableAnimation: true,
                  animationType: AnimationType.ease,
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 130, // Adjust positioning as needed
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              widget.label,
              style: TextPref.opensans.copyWith(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "/800",
              style: TextPref.opensans.copyWith(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
