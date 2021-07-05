import 'package:flutter/material.dart';
import 'package:mtp_choice_web/constants.dart';

class CloudStorageInfo {
  final String? svgSrc, title;
  final int? numOfFiles;
  final Color? color;

  CloudStorageInfo({
    this.title,
    this.numOfFiles,
    this.svgSrc,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Text",
    numOfFiles: 1000,
    svgSrc: 'icons/Documents.svg',
    color: primaryColor,
  ),
  CloudStorageInfo(
    title: "Video",
    numOfFiles: 200,
    svgSrc: 'icons/media_file.svg',
    color: Color(0xFFFFA113),
  ),
  CloudStorageInfo(
    title: "Sound",
    numOfFiles: 300,
    svgSrc: 'icons/sound_file.svg',
    color: Color(0xFFA4CDFF),
  ),
  CloudStorageInfo(
    title: "Ảnh",
    numOfFiles: 400,
    svgSrc: 'icons/media_file.svg',
    color: Color(0xFF007EE5),
  ),
];
