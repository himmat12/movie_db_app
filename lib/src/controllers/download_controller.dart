import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/services/download_service.dart';
import 'package:path_provider/path_provider.dart';

class DownloadController extends BaseController {
  final _service = sl<DownloadService>();

  var downloadState = ViewState.idle.obs;

  Directory? dir;

  // download image files
  void downloadFile({required String url}) async {
    downloadState.value = ViewState.busy;
    if (Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
      print(dir!.path);
    }
    await _service.downloadFile(
        url: url, downloadPath: '${dir!.path}/${Random().hashCode}.jpg');

    downloadState.value = ViewState.retrived;
  }
}
