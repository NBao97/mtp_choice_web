import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/models/RecentFile.dart';
import 'package:mtp_choice_web/screens/add/add_question.dart';
import 'package:mtp_choice_web/screens/question_detail/question_detail.dart';

import '../../../constants.dart' as constant;
import '../../../constants.dart';
import '../../../responsive.dart';

class RecentFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Theme(child: QuestionFiles(), data: new ThemeData.dark());
  }
}

List<QuestionFile>? dataSave = [];

class QuestionFiles extends StatefulWidget {
  const QuestionFiles({
    Key? key,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<QuestionFiles> {
  late Future<List<QuestionFile>> futureDataQuest;
  @override
  void initState() {
    super.initState();
    constant.order = '';

    constant.questId = '';
    constant.imageUrl = '';
    constant.image = '';

    futureDataQuest =
        fetchQuestion(constant.page, constant.order, constant.questId);
  }

  @override
  void dispose() {
    constant.page = 1;
    constant.order = '';

    constant.questId = '';
    constant.imageUrl = '';
    constant.image = '';
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuestionFile>>(
        future: futureDataQuest,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QuestionFile>? data = snapshot.data;
            final _dtSource = DTS(
              data: data,
            );
            return Container(
              padding: EdgeInsets.all(constant.defaultPadding),
              decoration: BoxDecoration(
                color: constant.secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bảng câu hỏi",
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
                          constant.imageUrl = '';
                          constant.form = 'text';
                          Get.toNamed(AddQuestion.route);
                        },
                        icon: Icon(Icons.add),
                        label: Text("Thêm câu hỏi"),
                      ),
                    ],
                  ),
                  Container(
                    width: 1000.0,
                    alignment: Alignment.topRight,
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        constant.search = _controller.text;
                        setState(() {
                          dataSave!.clear();
                          constant.page = 1;
                          futureDataQuest = fetchQuestion(
                              constant.page, constant.order, constant.questId);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm câu hỏi",
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
                            constant.search = _controller.text;
                            setState(() {
                              dataSave!.clear();
                              constant.page = 1;
                              futureDataQuest = fetchQuestion(constant.page,
                                  constant.order, constant.questId);
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
                  SizedBox(
                    width: double.infinity,
                    child: PaginatedDataTable(
                      horizontalMargin: 0,

                      onPageChanged: (value) => {
                        if (value > constant.page * 1000 - 50)
                          {
                            setState(() {
                              constant.page = constant.page + 1;
                              futureDataQuest = fetchQuestion(constant.page,
                                  constant.order, constant.questId);
                            })
                          }
                      },
                      showCheckboxColumn: false,
                      showFirstLastButtons: false,
                      columnSpacing: constant.defaultPadding,
                      columns: [
                        DataColumn(
                          label: Text("    Nội dung"),
                        ),
                        DataColumn(
                          label: Text("Độ khó"),
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
    required List<QuestionFile>? data,
  }) : _data = data;
  List<QuestionFile>? _data;
  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    _data!.addAll(dataSave!);
    if (index >= _data!.length) {
      return null;
    }
    final _user = _data![index];
    dataSave!.add(_user);
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (value) {
        constant.questId = _user.questionId!;
        if (constant.email == _user.creator) {
          constant.order = 'update';
        }
        Get.toNamed(QuestionDetail.route);
      },
      cells: [
        DataCell(
          Row(
            children: [
              Text("  "),
              SvgPicture.asset(
                "icons/xd_file.svg",
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: constant.defaultPadding),
                child: Text(
                  _user.questionContent!.length > 10
                      ? _user.questionContent!.substring(0, 10)
                      : _user.questionContent!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(
          (('${_user.difficulty}').toString() == "0")
              ? 'Dễ'
              : (('${_user.difficulty}').toString() == "1")
                  ? "Trung bình"
                  : (('${_user.difficulty}').toString() == "2")
                      ? "Khó"
                      : 'Dễ',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        )),
        DataCell(Text(
          (_user.creator == null) ? "no information" : '${_user.creator}',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
