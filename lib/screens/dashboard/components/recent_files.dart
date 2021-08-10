import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/models/RecentFile.dart';
import 'package:mtp_choice_web/screens/question_detail/question_detail.dart';
import '../../../constants.dart' as constant;

import '../../../constants.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RecentFiles> {
  late Future<List<QuestionFile>> futureData;
  @override
  void initState() {
    super.initState();
    constant.questId = '';
    constant.page = 1;
    constant.order = 'first page';
    constant.imageUrl = '';
    constant.image = '';
    futureData = fetchQuestion(constant.page, constant.order, constant.questId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuestionFile>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QuestionFile>? data = snapshot.data;
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
                    "Bảng câu hỏi mới",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      horizontalMargin: 0,
                      showCheckboxColumn: false,
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(
                          label: Text("Nội dung"),
                        ),
                        DataColumn(
                          label: Text("Độ khó"),
                        ),
                        DataColumn(
                          label: Text("Người tạo"),
                        ),
                      ],
                      rows: List.generate(
                        data!.length,
                        (index) => recentFileDataRow(data[index]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}

DataRow recentFileDataRow(QuestionFile fileInfo) {
  return DataRow(
    onSelectChanged: (value) {
      constant.questId = fileInfo.questionId!;
      if (constant.email == fileInfo.creator) {
        constant.order = 'update';
      }
      Get.toNamed(QuestionDetail.route);
    },
    cells: [
      DataCell(Row(
        children: [
          SvgPicture.asset(
            "icons/media_file.svg",
            height: 30,
            width: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(fileInfo.questionContent!.length > 10
                ? fileInfo.questionContent!.substring(0, 10)
                : fileInfo.questionContent!),
          ),
        ],
      )),
      DataCell(Text(
          fileInfo.difficulty == null ? '0' : fileInfo.difficulty!.toString())),
      DataCell(Text(
        (fileInfo.creator == null) ? "no information" : fileInfo.creator!,
      )),
    ],
  );
}
