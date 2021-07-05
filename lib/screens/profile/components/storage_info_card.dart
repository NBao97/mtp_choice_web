import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    Key? key,
    required this.svgSrc,
  }) : super(key: key);

  final String svgSrc;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: defaultPadding),
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding),
          ),
        ),
        child: Row(children: [
          SizedBox(
            height: 400,
            width: 200,
            child: SvgPicture.asset(svgSrc),
          ),
        ]));
  }
}
