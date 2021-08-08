import 'package:flutter/material.dart';
import 'package:mtp_choice_web/screens/profile/components/upload_button.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hình đại diện",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  StorageInfoCard(
                    svgSrc: constant.imageUrl == ''
                        ? constant.image
                        : constant.imageUrl,
                  ),
                  FileUploadButton(),
                ],
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}
