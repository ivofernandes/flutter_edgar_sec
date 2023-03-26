import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/utils/number_utils.dart';

class FunnelStep extends StatelessWidget {
  final String label;
  final double value;
  final double maxValue;
  final Color color;
  final double top;

  const FunnelStep({
    required this.label,
    required this.value,
    required this.maxValue,
    required this.color,
    required this.top,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double widthPercentage = value / maxValue;

    return Positioned(
      left: 0,
      right: 0,
      top: top,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
            child: Text(
              '$label: ${value.reportFormat}',
              style: TextStyle(
                color: color,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 20,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: color.withOpacity(0.2),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * widthPercentage,
                  color: color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Get the opposite color of the given color
  Color _inverseColor(Color color) {
    final int r = 255 - color.red;
    final int g = 255 - color.green;
    final int b = 255 - color.blue;
    final int a = color.alpha; // You can keep the alpha channel unchanged

    return Color.fromARGB(a, r, g, b);
  }
}
