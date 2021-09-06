import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:mtp_choice_web/models/SurveyFile.dart';
import 'package:mtp_choice_web/screens/CreateSurvey/create_survey.dart';
import 'package:mtp_choice_web/screens/survey_detail/survey_detail.dart';
import '../../../constants.dart';
import '../../../responsive.dart';

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
  late Future<List<Survey>> futureDataSurvey;
  final TextEditingController _controller = TextEditingController(text: '');
  @override
  void initState() {
    super.initState();
    _controller.clear();
    constant.questId = '';
    futureDataSurvey = fetchSurAll(constant.questId);
  }

  bool _isAscending = true;
  int sortcolumn = 0;
  List<Survey>? dataSearch = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Survey>>(
        future: futureDataSurvey,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Survey>? data = snapshot.data;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bảng khảo sát",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      ElevatedButton.icon(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: defaultPadding /
                                (Responsive.isMobile(context) ? 2 : 1),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(CreateSurvey.route);
                        },
                        icon: Icon(Icons.add),
                        label: Text("Thêm khảo sát"),
                      ),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  TextField(
                    controller: _controller,
                    onSubmitted: (value) {
                      setState(() {
                        dataSearch = data!
                            .where((user) => user.description!.contains(value))
                            .toList();
                      });
                    }.call,
                    decoration: InputDecoration(
                      hintText: "Tìm kiếm khảo sát",
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
                                    (user.description!
                                        .contains(_controller.text)) ||
                                    (user.startTime != null &&
                                        user.startTime!
                                            .contains(_controller.text)) ||
                                    (user.endTime != null &&
                                        user.endTime!
                                            .contains(_controller.text)))
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
                  SizedBox(height: defaultPadding),
                  SizedBox(
                    width: double.infinity,
                    child: PaginatedDataTable(
                      horizontalMargin: 0,
                      showCheckboxColumn: false,
                      columnSpacing: defaultPadding,
                      sortColumnIndex: sortcolumn,
                      sortAscending: _isAscending,
                      columns: [
                        DataColumn(
                          label: Text("  Nội dung"),
                        ),
                        DataColumn(
                            label: Text("Ngày tạo"),
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
                                        a.startTime!.compareTo(b.startTime!));
                                  } else {
                                    _isAscending = true;
                                    data!.sort((a, b) =>
                                        a.startTime!.compareTo(b.startTime!));
                                  }
                                } else {
                                  if (_isAscending == true) {
                                    _isAscending = false;
                                    dataSearch!.sort((a, b) =>
                                        a.startTime!.compareTo(b.startTime!));
                                  } else {
                                    _isAscending = true;
                                    dataSearch!.sort((a, b) =>
                                        a.startTime!.compareTo(b.startTime!));
                                  }
                                }
                              });
                            }),
                        DataColumn(
                            label: Text("Ngày kết thúc"),
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
                                        a.endTime!.compareTo(b.endTime!));
                                  } else {
                                    _isAscending = true;
                                    data!.sort((a, b) =>
                                        a.endTime!.compareTo(b.endTime!));
                                  }
                                } else {
                                  if (_isAscending == true) {
                                    _isAscending = false;
                                    dataSearch!.sort((a, b) =>
                                        a.endTime!.compareTo(b.endTime!));
                                  } else {
                                    _isAscending = true;
                                    dataSearch!.sort((a, b) =>
                                        a.endTime!.compareTo(b.endTime!));
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
    required List<Survey>? data,
  }) : _data = data;
  final List<Survey>? _data;

  bool get isRowCountApproximate => false;
  int get rowCount => _data!.length;
  int get selectedRowCount => 0;
  DataRow getRow(int index) {
    final _user = _data![index];
    return DataRow(
      onSelectChanged: (value) {
        constant.questId = _user.gameId!;

        Get.toNamed(SurveyDetail.route);
      },
      cells: [
        DataCell(Row(
          children: [
            Text("  "),
            SvgPicture.asset(
              "icons/media_file.svg",
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text((_user.description!.length < 20)
                  ? _user.description!
                  : _user.description!.substring(0, 20)),
            ),
          ],
        )),
        DataCell(
            Text(_user.startTime == null ? "" : _user.startTime.toString())),
        DataCell(Text(
          _user.endTime == null ? "" : _user.endTime!.toString(),
        )),
      ],
    );
  }
}
