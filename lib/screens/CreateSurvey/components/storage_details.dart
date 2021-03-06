import 'package:flutter/material.dart';
import 'package:mtp_choice_web/screens/CreateSurvey/components/storage_info_card.dart';

import '../../../constants.dart';

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
            "Khảo sát",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          StorageInfoCard(),
          // StorageInfoCard(
          //   svgSrc: "icons/Documents.svg",
          //   title: "top100",
          // ),
          // StorageInfoCard(
          //   svgSrc: "icons/media.svg",
          //   title: "tài khoản mới",
          // ),
          // StorageInfoCard(
          //   svgSrc: "icons/folder.svg",
          //   title: "Tài khoản bị ẩn",
          // ),
          // StorageInfoCard(
          //   svgSrc: "icons/folder.svg",
          //   title: "Tài khoản admin",
          // ),
        ],
      ),
    );
  }
}
