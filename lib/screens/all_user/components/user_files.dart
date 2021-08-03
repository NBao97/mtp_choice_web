import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  final TextEditingController _controller = TextEditingController(text: '');
  bool _isAscending = true;
  @override
  void initState() {
    super.initState();
    constant.questId = '';
    _controller.clear();
    futureData = fetchUserAll(constant.questId);
  }

  List<Users>? dataSearch = [];
  int sortcolumn = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Users>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Users>? data = snapshot.data;
            MyData _dtSource = MyData(
              data: (_controller.text == '') ? data : dataSearch,
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
                  Container(
                    width: 1000.0,
                    alignment: Alignment.topRight,
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (value) {
                        setState(() {
                          dataSearch = data!
                              .where((user) => user.userId!.contains(value))
                              .toList();
                        });
                      }.call,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: constant.secondaryColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              dataSearch = data!
                                  .where((user) =>
                                      user.userId!.contains(_controller.text))
                                  .toList();
                            });
                          },
                          child: Container(
                            padding:
                                EdgeInsets.all(constant.defaultPadding * 0.75),
                            margin: EdgeInsets.symmetric(
                                horizontal: constant.defaultPadding / 2),
                            decoration: BoxDecoration(
                              color: constant.primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: SvgPicture.asset('icons/Search.svg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Bảng Người dùng ",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: PaginatedDataTable(
                      horizontalMargin: 0,
                      showCheckboxColumn: false,
                      sortColumnIndex: sortcolumn,
                      columnSpacing: defaultPadding,
                      sortAscending: _isAscending,
                      columns: [
                        DataColumn(
                          label: Text(" UserID"),
                        ),
                        DataColumn(
                          label: Text("Chức vụ"),
                        ),
                        DataColumn(
                            label: Text("Tổng điểm"),
                            onSort: (columnIndex, sortAscending) {
                              setState(() {
                                if (columnIndex == sortcolumn) {
                                  sortAscending = true;
                                } else {
                                  sortcolumn = columnIndex;
                                }
                                if (_controller.text == '') {
                                  if (_isAscending == true) {
                                    _isAscending = false;
                                    data!.sort((a, b) =>
                                        a.bonusPoint!.compareTo(b.bonusPoint!));
                                  } else {
                                    _isAscending = true;
                                    data!.sort((a, b) =>
                                        a.bonusPoint!.compareTo(b.bonusPoint!));
                                  }
                                } else {
                                  if (_isAscending == true) {
                                    _isAscending = false;
                                    dataSearch!.sort((a, b) =>
                                        a.bonusPoint!.compareTo(b.bonusPoint!));
                                  } else {
                                    _isAscending = true;
                                    dataSearch!.sort((a, b) =>
                                        a.bonusPoint!.compareTo(b.bonusPoint!));
                                  }
                                }
                              });
                            }),
                      ],
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

class MyData extends DataTableSource {
  // Generate some made-up data
  MyData({
    required List<Users>? data,
  }) : _data = data;
  final List<Users>? _data;

  bool get isRowCountApproximate => false;
  int get rowCount => _data!.length;
  int get selectedRowCount => 0;
  DataRow getRow(int index) {
    final _user = _data![index];
    return DataRow(
      onSelectChanged: (value) {
        constant.questId = _user.userId!;
        Get.toNamed(UserDetail.route);
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
              child: Text((_user.userId!.length < 15)
                  ? _user.userId!
                  : _user.userId!.substring(0, 15)),
            ),
          ],
        )),
        DataCell(Text(_user.userRole == 'ADMIN' ? 'Quản lý' : 'Người Dùng')),
        DataCell(Text(
          _user.bonusPoint == null ? '0' : _user.bonusPoint!.toString(),
        )),
      ],
    );
  }
}
