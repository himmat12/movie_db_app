import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../service_locator.dart';
import '../configs/configs.dart';
import '../services/download_service.dart';
import 'base_controller.dart';

class DownloadController extends BaseController {
  final _service = sl<DownloadService>();

  var downloadState = ViewState.idle.obs;
  var filePath = ''.obs;
  var isExpanded = true.obs;

  Directory? dir;

  void setFileUrl(url) => filePath.value = url;

  void resetDownloadState() => downloadState.value = ViewState.idle;

  void toggleExpanded() => isExpanded.value = !isExpanded.value;

  // download image files
  void downloadFile({required String url}) async {
    downloadState.value = ViewState.busy;
    if (Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
      print(dir!.path);
    }
    await _service.downloadFile(
        url: url, downloadPath: '${dir!.path}/${Random().hashCode}.jpg');
    Get.showSnackbar(GetBar(
      icon: const Icon(
        Icons.file_download_done,
        size: 26,
        color: primaryWhite,
      ),
      messageText: Text(
        "path: ${dir!.path}",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: n - 4,
          color: primaryWhite,
        ),
      ),
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      duration: const Duration(milliseconds: 1800),
    ));

    downloadState.value = ViewState.retrived;
  }
}
