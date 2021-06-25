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
          Text(
            "Thông báo",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                reverse: true,
                child: Flexible(
                  child: RemindersList(),
                ),
              )),
        ],
      ),
    );
  }
}
