import 'package:mtp_choice_web/models/UserFile.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Theme(child: UserFiles(), data: new ThemeData.dark());
  }
}

class UserFiles extends StatelessWidget {
  const UserFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dtSource = DTS(
      data: demoRecentFiles,
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
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                  label: Text(" UserID"),
                ),
                DataColumn(
                  label: Text("Ngày tạo"),
                ),
                DataColumn(
                  label: Text("Tổng điểm"),
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
  }
}

class DTS extends DataTableSource {
  DTS({
    required List data,
  }) : _data = data;
  final List _data;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    if (index >= _data.length) {
      return null;
    }
    final _user = _data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text('${_user.title}'),
        )),
        DataCell(Text('${_user.date}')),
        DataCell(Text('${_user.score}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
