import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 2)),
        builder: (c, s) => s.connectionState == ConnectionState.done
            ? Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lựa chọn hành động",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    StorageInfoCard(
                      svgSrc: "icons/Documents.svg",
                      title: "Xóa",
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator());
  }
}
