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
  late Future<List<QuestionFile>> futureDataQuestFirst;
  @override
  void initState() {
    super.initState();
    constant.questId = '';
    constant.page = 1;
    constant.order = 'first page';
    constant.imageUrl = '';
    constant.image = '';
    futureDataQuestFirst =
        fetchQuestion(constant.page, constant.order, constant.questId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuestionFile>>(
        future: futureDataQuestFirst,
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
                        DataColumn(
                          label: Text("Phiên bản"),
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
      if (constant.email == fileInfo.creatorUserId) {
        constant.order = 'update';
      }
      Get.toNamed(QuestionDetail.route);
    },
    cells: [
      DataCell(Row(
        children: [
          fileInfo.status == "DELETED"
              ? Container(
                  width: 30,
                  height: 30,
                  color: Colors.lightBlue,
                  child: Icon(
                    Icons.delete_forever_outlined,
                    size: 20,
                    color: Colors.white,
                  ))
              : fileInfo.status == "NOT_APPROVED"
                  ? Container(
                      width: 30,
                      height: 30,
                      color: Colors.orange,
                      child: Icon(
                        Icons.motion_photos_pause,
                        size: 20,
                        color: Colors.white,
                      ))
                  : fileInfo.status == "KHAO_SAT_QUESTION"
                      ? Container(
                          width: 30,
                          height: 30,
                          color: Colors.deepPurple,
                          child: Icon(
                            Icons.query_stats_rounded,
                            size: 20,
                            color: Colors.white,
                          ))
                      : SvgPicture.asset(
                          "icons/xd_file.svg",
                          height: 30,
                          width: 30,
                        ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(fileInfo.questionContent!.length > 40
                ? fileInfo.questionContent!.substring(0, 20) +
                    "..." +
                    fileInfo.questionContent!.substring(
                        fileInfo.questionContent!.length - 20,
                        fileInfo.questionContent!.length)
                : fileInfo.questionContent!),
          ),
        ],
      )),
      DataCell(Text(
        (('${fileInfo.difficulty}').toString() == "0")
            ? 'Dễ'
            : (('${fileInfo.difficulty}').toString() == "1")
                ? "Trung bình"
                : (('${fileInfo.difficulty}').toString() == "2")
                    ? "Khó"
                    : 'Dễ',
      )),
      DataCell(Text(
        (fileInfo.creatorUserId == null)
            ? "Không có thông tin"
            : fileInfo.creatorUserId!,
      )),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(
            (fileInfo.version == null) ? "0" : fileInfo.version!.toString(),
          ))),
    ],
  );
}
