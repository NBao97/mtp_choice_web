import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:mtp_choice_web/models/SurveyFile.dart';
import 'package:mtp_choice_web/screens/survey_detail/survey_detail.dart';
import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Theme(child: SurveyFiles(), data: new ThemeData.dark());
  }
}

class SurveyFiles extends StatefulWidget {
  const SurveyFiles({
    Key? key,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SurveyFiles> {
  late Future<List<Survey>> futureData;

  @override
  void initState() {
    super.initState();
    constant.questId = '';
    futureData = fetchSurAll(constant.questId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Survey>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Survey>? data = snapshot.data;
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
                    "Người dùng mới",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: PaginatedDataTable(
                      horizontalMargin: 0,
                      showFirstLastButtons: true,
                      showCheckboxColumn: false,
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(
                          label: Text("Nội dung"),
                        ),
                        DataColumn(
                          label: Text("Ngày tạo"),
                        ),
                        DataColumn(
                          label: Text("Ngày kết thúc"),
                        ),
                      ],
                      rowsPerPage: 10,
                      source: _dtSource,
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
    required List<Survey>? data,
  }) : _data = data;
  final List<Survey>? _data;

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
        constant.questId = _user.gameId!;
        Get.toNamed(SurveyDetail.route);
      },
      cells: [
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text((_user.description!.length < 10)
              ? '${_user.description}'
              : _user.description!.substring(0, 10)),
        )),
        DataCell(Text('${_user.startTime.toString()}')),
        DataCell(Text('${_user.endTime.toString()}')),
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
