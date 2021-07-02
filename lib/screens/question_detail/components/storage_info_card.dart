import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

Color colorS = Colors.blue;
IconData icon = Icons.check_circle_outline;

class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    Key? key,
    required this.title,
    required this.status,
  }) : super(key: key);

  final String title, status;

  void checkStatus() {
    if (status == 'Active') {
      colorS = Colors.blue;
      icon = Icons.check_circle_outline;
    } else {
      colorS = Colors.red;
      icon = Icons.close_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkStatus();
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.15),
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: colorS,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
