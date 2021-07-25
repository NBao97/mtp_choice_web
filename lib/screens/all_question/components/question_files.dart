import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/models/RecentFile.dart';
import 'package:mtp_choice_web/screens/question_detail/question_detail.dart';
import 'package:get/get.dart';
import '../../../constants.dart' as constant;

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
  late Future<List<QuestionFile>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchQuestion(constant.page);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuestionFile>>(
        future: futureData,
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
                  Text(
                    "Câu hỏi mới",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: PaginatedDataTable(
                      horizontalMargin: 0,
                      onPageChanged: (value) => {
                        if (value < 1)
                          {constant.page = 1, setState(() {})}
                        else if (value < constant.page)
                          {constant.page = constant.page--, setState(() {})}
                        else if (value > constant.page)
                          {constant.page = constant.page++, setState(() {})}
                      },
                      showCheckboxColumn: false,
                      showFirstLastButtons: true,
                      columnSpacing: constant.defaultPadding,
                      columns: [
                        DataColumn(
                          label: Text("Nội dung"),
                        ),
                        DataColumn(
                          label: Text("độ khó"),
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

class SearchField extends State<QuestionFiles> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: TextStyle(color: Colors.white),
        fillColor: constant.secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {
            constant.search = _controller.text;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(constant.defaultPadding * 0.75),
            margin:
                EdgeInsets.symmetric(horizontal: constant.defaultPadding / 2),
            decoration: BoxDecoration(
              color: constant.primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset('icons/Search.svg'),
          ),
        ),
      ),
    );
  }
}

class DTS extends DataTableSource {
  DTS({
    required List<QuestionFile>? data,
  }) : _data = data;
  final List<QuestionFile>? _data;

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
                "icons/xd_file.svg",
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: constant.defaultPadding),
                child: Text(_user.questionContent!),
              ),
            ],
          ),
        ),
        DataCell(Text('${_user.difficulty}')),
        DataCell(Text('${_user.creator}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 0;

  @override
  int get selectedRowCount => 0;
}
