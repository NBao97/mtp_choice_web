import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/DTO/FeedbackDTO.dart';
import 'package:mtp_choice_web/models/FeedbackFile.dart';

import '../../../constants.dart';
import '../notification.dart';

import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:http/http.dart' as http;

class RemindersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Theme(child: Reminders(), data: new ThemeData.dark());
  }
}

class Reminders extends StatefulWidget {
  const Reminders({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Reminders> {
  late Future<List<Reminder>> futureAlbum;
  final TextEditingController _controller = TextEditingController(text: '');
  bool _isAscending = true;
  @override
  void initState() {
    super.initState();
    _controller.clear();
    futureAlbum = fetchFeedback();
  }

  List<Remind>? dataSearch = [];
  int sortcolumn = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reminder>>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Reminder>? remind = snapshot.data;

            List<Remind>? rem = [];
            for (Reminder re in remind!) {
              if (re.fed != null) {
                for (Feedbacks fe in re.fed!) {
                  rem.add(
                    Remind(
                        feedbackId: fe.feedbackId,
                        userId: re.userId,
                        content: fe.content,
                        imageUrl: fe.imageUrl,
                        created: fe.created),
                  );
                }
              }
            }
            MyData _dtSource = MyData(
              data: (_controller.text == '') ? rem : dataSearch,
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
                          dataSearch = rem
                              .where((user) => user.userId!.contains(value))
                              .toList();
                        });
                      }.call,
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm người dùng",
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
                              dataSearch = rem
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
                  SizedBox(height: defaultPadding),
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
                          label: Text("    ID Người dùng"),
                        ),
                        DataColumn(
                          label: Text("Nội dung"),
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
                                    rem.sort((a, b) =>
                                        a.created!.compareTo(b.created!));
                                  } else {
                                    _isAscending = true;
                                    rem.sort((a, b) =>
                                        a.created!.compareTo(b.created!));
                                  }
                                } else {
                                  if (_isAscending == true) {
                                    _isAscending = false;
                                    dataSearch!.sort((a, b) =>
                                        a.created!.compareTo(b.created!));
                                  } else {
                                    _isAscending = true;
                                    dataSearch!.sort((a, b) =>
                                        a.created!.compareTo(b.created!));
                                  }
                                }
                              });
                            }),
                        DataColumn(
                          label: Text("Lựa chọn"),
                        ),
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
    required List<Remind>? data,
  }) : _data = data;
  final List<Remind>? _data;

  bool get isRowCountApproximate => false;
  int get rowCount => _data!.length;
  int get selectedRowCount => 0;
  DataRow getRow(int index) {
    final _user = _data![index];
    return DataRow(
      onSelectChanged: (value) {
        Get.defaultDialog(
            title: 'Nội dung FeedBack',
            content: Container(
              child: _user.imageUrl != null
                  ? Container(
                      height: 300,
                      width: 400,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              _user.imageUrl!,
                              height: 250,
                            ),
                            Text(_user.content!.toString())
                          ]),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: Text(_user.content!.toString())),
            ),
            backgroundColor: Colors.black87);
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
              child: Text(_user.userId!),
            ),
          ],
        )),
        DataCell(Container(
          width: 200, //SET width
          child: Text(
            _user.content!.length > 15
                ? _user.content!.substring(0, 15)
                : _user.content!,
          ),
        )),
        DataCell(Text(
          _user.created == null ? '' : _user.created!.substring(0, 10),
        )),
        DataCell(
          ElevatedButton(
              child: Text('Xóa feedback',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
              ),
              onPressed: () async {
                removeFeed(_user.feedbackId!).then((result) async {
                  if (result.contains('Success')) {
                    Get.snackbar('Tình trạng', 'Xóa thành công',
                        duration: Duration(seconds: 4),
                        animationDuration: Duration(milliseconds: 800),
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.white);
                    Get.back();
                    Get.toNamed(NotificationScreen.route);
                  }
                }).catchError((error) {
                  Get.snackbar('Thông báo', 'Nhập thất bại' + error,
                      duration: Duration(seconds: 4),
                      animationDuration: Duration(milliseconds: 800),
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.white);
                });
              }),
        ),
      ],
    );
  }
}
