import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Reminder.dart';

class RemindersList extends StatelessWidget {
  final List<Reminder> remind = [
    Reminder(
      type: "icons/xd_file.svg",
      name: "XD File",
      description: "as xjkas njxnsajxmoasmxoas",
      date: "01-03-2021",
      author: "Nguyễn văn A",
    ),
    Reminder(
      type: "icons/Figma_file.svg",
      name: "Figma File",
      description: "as xjkas njxnsajxmoasmxoas",
      date: "27-02-2021",
      author: "Nguyễn văn A",
    ),
    Reminder(
      type: "icons/doc_file.svg",
      name: "Documetns",
      description: "as xjkas njxnsajxmoasmxoas",
      date: "23-02-2021",
      author: "Nguyễn văn A",
    ),
    Reminder(
      type: "icons/sound_file.svg",
      name: "Sound File",
      description: "as xjkas njxnsajxmoasmxoas",
      date: "21-02-2021",
      author: "Nguyễn văn A",
    ),
    Reminder(
      type: "icons/media_file.svg",
      name: "Media File",
      description: "as xjkas njxnsajxmoasmxoas",
      date: "23-02-2021",
      author: "Dương thị D",
    ),
    Reminder(
      type: "icons/pdf_file.svg",
      name: "Sals PDF",
      description: "as xjkas njxnsajxmoasmxoas",
      date: "25-02-2021",
      author: "Đoàn văn C",
    ),
    Reminder(
      type: "icons/excle_file.svg",
      name: "Excel File",
      description: "as xjkas njxnsajxmoasmxoas",
      date: "25-02-2021",
      author: "Nguyễn văn B",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        shrinkWrap: true,
        itemCount: remind.length,
        itemBuilder: (context, index) {
          final item = remind[index];
          return ListTile(
              hoverColor: Colors.blueAccent,
              title: Row(
                children: [
                  SvgPicture.asset(
                    item.type!,
                    height: 30.0,
                  ),
                  Text(item.name!)
                ],
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text(
                              "Description: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              item.description!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        )),
                    Text(
                      item.date!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      item.author!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )
                  ]));
        });
  }
}
