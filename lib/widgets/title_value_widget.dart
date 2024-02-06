import 'package:dockcheck_web/utils/colors.dart';
import 'package:flutter/material.dart';

import '../utils/theme.dart';

class TitleValueWidget extends StatelessWidget {
  const TitleValueWidget({
    super.key,
    required this.title,
    required this.value,
    this.color = Colors.black,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: DockTheme.body.copyWith(
              color: DockColors.slate100,
              fontSize: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              value,
              style: DockTheme.h3.copyWith(
                color: color,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
