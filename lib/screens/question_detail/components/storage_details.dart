import 'package:flutter/material.dart';

import '../../../constants.dart' as constant;
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(constant.defaultPadding),
      decoration: BoxDecoration(
        color: constant.secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tình trạng câu hỏi",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: constant.defaultPadding),
          StorageInfoCard(title: constant.status, stat: "Created"),
          Text(constant.status.toString()),
        ],
      ),
    );
  }
}
