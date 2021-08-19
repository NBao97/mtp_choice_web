import 'package:flutter/material.dart';
import 'package:mtp_choice_web/screens/notification/component/ListView.dart';

import '../../../constants.dart';

class RemindMain extends StatelessWidget {
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
          Align(
            alignment: Alignment.center,
            child: Text(
              "Nội dung feedback",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(height: defaultPadding),
          Text(
            "Danh sách feedback",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.vertical,
                child: Flexible(
                  child: RemindersList(),
                ),
              )),
        ],
      ),
    );
  }
}
