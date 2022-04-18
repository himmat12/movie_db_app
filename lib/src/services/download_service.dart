import 'dart:async';
import 'dart:io';

import '../exceptions/app_exceptions.dart';
import 'base_service.dart';

// 'https://img.youtube.com/vi/gmRKv7n2If8/hqdefault.jpg'  //default test img url
class DownloadService extends BaseService {
  // download file
  Future<dynamic> downloadFile(
      {required String url, required String downloadPath}) async {
    try {
      final _response = await client.get(Uri.parse(url)).then((value) {
        File(downloadPath).writeAsBytes(value.bodyBytes).then((value) {
          print('DOWNLOAD COMPLETED:  $value');
        });
      });

      return _response;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }
}
