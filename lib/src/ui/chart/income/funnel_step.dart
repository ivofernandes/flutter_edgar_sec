import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/utils/number_utils.dart';

/// A single step of the funnel chart
class FunnelStep extends StatelessWidget {
  /// The label of the step
  final String label;

  /// The value of the step
  final double value;

  /// The maximum value of the funnel (revenues)
  final double maxValue;

  /// The color of the step to distinguish between positive and negative values
  final Color color;

  final double height;

  const FunnelStep({
    required this.label,
    required this.value,
    required this.maxValue,
    required this.color,
    this.height = 30,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double widthPercentage = 0;

    if (!maxValue.isNaN && !value.isNaN && maxValue != 0) {
      widthPercentage = value / maxValue;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: height,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: color.withOpacity(0.2),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * widthPercentage,
                  color: color,
                  child: SizedBox(
                    height: height,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 6,
                  ),
                  child: Text(
                    '$label: ${value.reportFormat}',
                    style: TextStyle(
                      color: _inverseColor(color),
                    ),
                  ),
                ),
                widthPercentage != 1 ? Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 6,
                      ),
                      child: Text(
                        '${(widthPercentage * 100).toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: _inverseColor(color),
                        ),
                      ),
                    )
                ) : SizedBox.shrink(),
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
