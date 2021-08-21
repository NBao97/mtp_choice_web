import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/models/SurveyFile.dart';
import '../../../constants.dart' as constant;
import '../../../constants.dart';
import '../survey_detail.dart';

class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    Key? key,
    required this.title,
    required this.svgSrc,
  }) : super(key: key);

  final String title, svgSrc;

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black12,
        ),
        onPressed: () async {
          (constant.order != "Delete")
              ? await removeSurvey(constant.questId).then((value) async {
                  if (value != "") {
                    if (value.contains("Success")) {
                      Get.snackbar('Thông báo', 'Xóa thành công',
                          duration: Duration(seconds: 4),
                          animationDuration: Duration(milliseconds: 800),
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.white);
                    } else {
                      Get.snackbar(
                          'Thông báo', 'Cập nhật trạng thái thất bại' + value,
                          duration: Duration(seconds: 4),
                          animationDuration: Duration(milliseconds: 800),
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.white);
                    }
                  }
                }).catchError((error) {
                  Get.snackbar(
                      'Thông báo', 'Cập nhật trạng thái thất bại' + error,
                      duration: Duration(seconds: 4),
                      animationDuration: Duration(milliseconds: 800),
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.white);
                })
              : null;
        },
        child: Container(
          margin: EdgeInsets.only(top: defaultPadding),
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
            borderRadius: const BorderRadius.all(
              Radius.circular(defaultPadding),
            ),
          ),
          child: (constant.order != "Delete")
              ? Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset(svgSrc),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(
                  height: heightSize * 0.2,
                  width: widthSize * 0.15,
                  child: Image.asset('images/mtp_logo.png')),
        ));
  }
}
