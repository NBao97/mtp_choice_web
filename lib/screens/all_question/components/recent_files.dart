import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/models/RecentFile.dart';
import 'package:mtp_choice_web/screens/question_detail/question_detail.dart';

import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Theme(child: QuestionFiles(), data: new ThemeData.dark());
  }
}

class QuestionFiles extends StatefulWidget {
  const QuestionFiles({
    Key? key,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<QuestionFiles> {
  late Future<List<RecentFile>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecentFile>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<RecentFile>? data = snapshot.data;
            final _dtSource = DTS(
              data: data,
            );
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
                    child: PaginatedDataTable(
                      horizontalMargin: 0,
                      showCheckboxColumn: false,
                      showFirstLastButtons: true,
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
                      rowsPerPage: 10,
                      source: _dtSource,
                      // rows: List.generate(
                      //   demoRecentFiles.length,
                      //   (index) => recentFileDataRow(demoRecentFiles[index]),
                      // ),
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

class DTS extends DataTableSource {
  DTS({
    required List<RecentFile>? data,
  }) : _data = data;
  final List<RecentFile>? _data;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    if (index >= _data!.length) {
      return null;
    }
    final _user = _data![index];
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (value) {
        Get.toNamed(QuestionDetail.route);
      },
      cells: [
        DataCell(
          Row(
            children: [
              SvgPicture.asset(
                _user.type!,
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(_user.title!),
              ),
            ],
          ),
        ),
        DataCell(Text('${_user.date}')),
        DataCell(Text('${_user.author}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data!.length;

  @override
  int get selectedRowCount => 0;
}
