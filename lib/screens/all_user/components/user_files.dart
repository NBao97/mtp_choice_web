import 'dart:convert';

import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/models/UserFile.dart';
import 'package:mtp_choice_web/screens/user_detail/user_detail.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:http/http.dart' as http;

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
  late Future<List<RecentFile>> futureData;
  DTS _source = DTS();
  @override
  void initState() {
    super.initState();
    _source.controller = BsDatatableController();
    super.initState();
  }

  Future loadApi(Map<String, dynamic> params) {
    return http.get(
      Uri.parse('https://api.wimln.ml/api/Question'),
      headers: <String, String>{
        'Content-Type': 'application/json ; charset=UTF-8',
        'Authorization': 'Bearer ' + constant.key,
      },
    ).then((value) {
      Map<String, dynamic> json = jsonDecode(value.body);
      setState(() {
        _source.response = BsDatatableResponse.createFromJson(json['data']);
        // _source.onEditListener = (typeid) {
        //   _source.controller.reload();
        // };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            "Bảng người dùng",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: BsDatatable(
              source: _source,
              title: Text('Datatables Data'),
              columns: DTS.columns,
              pagination: BsPagination.input,
              language: BsDatatableLanguage(
                  nextPagination: 'Next',
                  previousPagination: 'Previous',
                  information:
                      'Show __START__ to __END__ of __FILTERED__ entries',
                  informationFiltered: 'filtered from __DATA__ total entries',
                  firstPagination: 'First Page',
                  lastPagination: 'Last Page',
                  hintTextSearch: 'Search data ...',
                  perPageLabel: 'Page Length',
                  searchLabel: 'Search Form'),
              serverSide: loadApi,
            ),
          )
        ],
      ),
    );
  }
}

class DTS extends BsDatatableSource {
  ValueChanged<RecentFile> onEditListener = (value) {};
  ValueChanged<RecentFile> onDeleteListener = (value) {};
  static List<BsDataColumn> get columns => <BsDataColumn>[
        BsDataColumn(
            label: Text('Tài khoản'), columnName: 'Account', width: 100.0),
        BsDataColumn(label: Text('Ngày tạo'), columnName: 'Date', width: 200.0),
        BsDataColumn(
          label: Text('Tổng điểm'),
          columnName: 'Score',
        ),
      ];
  @override
  BsDataRow getRow(int index) {
    return BsDataRow(index: index, cells: <BsDataCell>[
      BsDataCell(Text('${response.data[index]['Account']}')),
      BsDataCell(Text('${response.data[index]['Date']}')),
      BsDataCell(Text('${response.data[index]['Score']}')),
    ]);
  }
}
