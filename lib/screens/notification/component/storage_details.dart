import 'package:flutter/material.dart';

import '../../../constants.dart';
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
            "Dạng câu hỏi",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          StorageInfoCard(
            svgSrc: "icons/Documents.svg",
            title: "text",
          ),
          StorageInfoCard(
            svgSrc: "icons/media.svg",
            title: "video",
          ),
          StorageInfoCard(
            svgSrc: "icons/folder.svg",
            title: "picture",
          ),
          StorageInfoCard(
            svgSrc: "icons/media_file.svg",
            title: "sound",
          ),
        ],
      ),
    );
  }
}
