import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thống kê giờ chơi trong tháng",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: "icons/Documents.svg",
            title: "Ai là triệu phú",
            amountOfFiles: "50%",
            numOfFiles: 500,
          ),
          StorageInfoCard(
            svgSrc: "icons/media.svg",
            title: "Thách Đấu",
            amountOfFiles: "30%",
            numOfFiles: 300,
          ),
          StorageInfoCard(
            svgSrc: "icons/folder.svg",
            title: "Survey",
            amountOfFiles: "20%",
            numOfFiles: 200,
          ),
        ],
      ),
    );
  }
}
