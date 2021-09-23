import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mtp_choice_web/models/QuestFile.dart';

import '../../../constants.dart';

Color colorS = Colors.blue;
IconData icon = Icons.check_circle_outline;

String til = '';

class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  void checkStatus() {
    if (title == 'APPROVED') {
      til = 'Đã chấp nhận';
      colorS = Colors.blue;
      icon = Icons.check_circle_outline;
    } else if (title == 'NOT_APPROVED') {
      til = 'Chờ duyệt';
      colorS = Colors.yellowAccent;
      icon = Icons.help_outline;
    } else if (title == 'KHAO_SAT_QUESTION') {
      til = 'Câu hỏi khảo sát';
      colorS = Colors.blueAccent;
      icon = Icons.question_answer_outlined;
    } else if (title == 'Xóa') {
      til = ' Xóa câu hỏi';
      colorS = Colors.red;
      icon = Icons.close_outlined;
    } else if (title == 'DELETED') {
      til = ' Đã xóa';
      colorS = Colors.red;
      icon = Icons.close_outlined;
    } else {
      til = title;
      colorS = Colors.white;
      icon = Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkStatus();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black12,
      ),
      onPressed: () async {
        await approveQuestion(title).then((value) async {
          if (value != "") {
            if (value == "Success") {
              Get.snackbar('Thông báo', 'Cập nhật trạng thái thành công',
                  duration: Duration(seconds: 4),
                  animationDuration: Duration(milliseconds: 800),
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.white);
            } else if (value == "SuccessD") {
              Get.snackbar('Thông báo', 'Xóa thành công',
                  duration: Duration(seconds: 4),
                  animationDuration: Duration(milliseconds: 800),
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.white);
            } else {
              Get.snackbar('Thông báo', 'Cập nhật trạng thái thất bại' + value,
                  duration: Duration(seconds: 4),
                  animationDuration: Duration(milliseconds: 800),
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.white);
            }
          }
        }).catchError((error) {
          Get.snackbar('Thông báo', 'Cập nhật trạng thái thất bại' + error,
              duration: Duration(seconds: 4),
              animationDuration: Duration(milliseconds: 800),
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white);
        });
      },
      child: Container(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        til,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
