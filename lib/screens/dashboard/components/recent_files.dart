import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/models/RecentFile.dart';
import 'package:mtp_choice_web/screens/question_detail/question_detail.dart';

import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
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
            "Câu hỏi mới",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                  label: Text("Nội dung"),
                ),
                DataColumn(
                  label: Text("Ngày chấp nhận"),
                ),
                DataColumn(
                  label: Text("Người tạo"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    onSelectChanged: (value) {
      Get.toNamed(QuestionDetail.route);
    },
    cells: [
      DataCell(Row(
        children: [
          SvgPicture.asset(
            fileInfo.type!,
            height: 30,
            width: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(fileInfo.title!),
          ),
        ],
      )),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.author!)),
    ],
  );
}
