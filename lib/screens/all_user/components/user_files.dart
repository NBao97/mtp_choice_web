import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/models/UserFile.dart';
import 'package:mtp_choice_web/screens/user_detail/user_detail.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Theme(child: UserFiles(), data: new ThemeData.dark());
  }
}

class UserFiles extends StatefulWidget {
  const UserFiles({
    Key? key,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<UserFiles> {
  late Future<List<Users>> futureData;

  @override
  void initState() {
    super.initState();
    constant.questId = '';
    futureData = fetchUserAll(constant.questId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Users>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Users>? data = snapshot.data;
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
    required List<Users>? data,
  }) : _data = data;
  final List<Users>? _data;

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
        constant.questId = _user.userId!;
        Get.toNamed(UserDetail.route);
      },
      cells: [
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text('${_user.userId}'),
        )),
        DataCell(Text('${_user.fullname}')),
        DataCell(Text('${_user.phone}')),
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
