import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

///
///
///
///
///
/// models
class Questions {
  Questions({
    this.qtnId,
    this.crsId,
    this.tblCourses,
    this.chpId,
    this.tblChapters,
    this.qtnImage,
    this.qtnAudio,
    this.qtnItalianAudio,
    this.qtnItalianImage,
    this.qtnAudio1,
    this.qtnVideoLink,
    this.qtnNumber,
    this.qtnItalian,
    this.qtnCategory,
    this.qtnScalaNumber,
    this.qtnTrueAnswer,
    this.qtnCreatedAt,
    this.qtnCreatedBy,
    this.qtnEnabled,
    this.qtnPageNo,
    this.sgnId,
    this.qtnType,
  });

  int? qtnId;
  int? crsId;
  TblCourses? tblCourses;
  int? chpId;
  TblChapters? tblChapters;
  String? qtnImage;
  String? qtnAudio;
  String? qtnItalianAudio;
  String? qtnItalianImage;
  String? qtnAudio1;
  String? qtnVideoLink;
  int? qtnNumber;
  String? qtnItalian;
  String? qtnCategory;
  String? qtnScalaNumber;
  bool? qtnTrueAnswer;
  String? qtnCreatedAt;
  String? qtnCreatedBy;
  bool? qtnEnabled;
  int? qtnPageNo;
  int? sgnId;
  bool? qtnType;

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        qtnId: json["qtnID"],
        crsId: json["crsID"],
        tblCourses: TblCourses.fromJson(json["tblCourses"]),
        chpId: json["chpID"],
        tblChapters: TblChapters.fromJson(json["tblChapters"]),
        qtnImage: json["qtnImage"],
        qtnAudio: json["qtnAudio"],
        qtnItalianAudio: json["qtnItalianAudio"],
        qtnItalianImage: json["qtnItalianImage"],
        qtnAudio1: json["qtnAudio1"],
        qtnVideoLink: json["qtnVideoLink"],
        qtnNumber: json["qtnNumber"],
        qtnItalian: json["qtnItalian"],
        qtnCategory: json["qtnCategory"],
        qtnScalaNumber: json["qtnScalaNumber"],
        qtnTrueAnswer: json["qtnTrueAnswer"],
        qtnCreatedAt: json["qtnCreatedAt"],
        qtnCreatedBy: json["qtnCreatedBy"],
        qtnEnabled: json["qtnEnabled"],
        qtnPageNo: json["qtnPageNo"],
        sgnId: json["sgnId"],
        qtnType: json["qtnType"],
      );
}

class TblChapters {
  TblChapters({
    this.chpId,
    this.bokId,
    this.tblBooks,
    this.chpName,
    this.chpCreatedBy,
    this.chpCreatedAt,
    this.chpEnabled,
  });

  int? chpId;
  int? bokId;
  TblBooks? tblBooks;
  String? chpName;
  String? chpCreatedBy;
  String? chpCreatedAt;
  bool? chpEnabled;

  factory TblChapters.fromJson(Map<String, dynamic> json) => TblChapters(
        chpId: json["chpID"],
        bokId: json["bokID"],
        tblBooks: TblBooks.fromJson(json["tblBooks"]),
        chpName: json["chpName"],
        chpCreatedBy: json["chpCreatedBy"],
        chpCreatedAt: json["chpCreatedAt"],
        chpEnabled: json["chpEnabled"],
      );
}

class TblBooks {
  TblBooks({
    this.bokId,
    this.crsId,
    this.tblCourses,
    this.bokName,
    this.bokType,
    this.bokCreatedBy,
    this.bokCreatedAt,
    this.bokEnabled,
  });

  int? bokId;
  int? crsId;
  TblCourses? tblCourses;
  String? bokName;
  String? bokType;
  String? bokCreatedBy;
  String? bokCreatedAt;
  bool? bokEnabled;

  factory TblBooks.fromJson(Map<String, dynamic> json) => TblBooks(
        bokId: json["bokID"],
        crsId: json["crsID"],
        tblCourses: TblCourses.fromJson(json["tblCourses"]),
        bokName: json["bokName"],
        bokType: json["bokType"],
        bokCreatedBy: json["bokCreatedBy"],
        bokCreatedAt: json["bokCreatedAt"],
        bokEnabled: json["bokEnabled"],
      );
}

class TblCourses {
  TblCourses({
    this.crsId,
    this.crsName,
    this.crsType,
    this.crsRegFee,
    this.crsOnlineFee,
    this.crsZoomAppFee,
    this.crsCreatedBy,
    this.crsCreatedAt,
    this.crsEnabled,
  });

  int? crsId;
  String? crsName;
  String? crsType;
  int? crsRegFee;
  int? crsOnlineFee;
  int? crsZoomAppFee;
  String? crsCreatedBy;
  String? crsCreatedAt;
  bool? crsEnabled;

  factory TblCourses.fromJson(Map<String, dynamic> json) => TblCourses(
        crsId: json["crsID"],
        crsName: json["crsName"],
        crsType: json["crsType"],
        crsRegFee: json["crsRegFee"],
        crsOnlineFee: json["crsOnlineFee"],
        crsZoomAppFee: json["crsZoomAppFee"],
        crsCreatedBy: json["crsCreatedBy"],
        crsCreatedAt: json["crsCreatedAt"],
        crsEnabled: json["crsEnabled"],
      );
}

///
///
///
///
///
/// services

class QuestionService {
  String authority = 'student.romylicensecenter.com';
  String path = '/api/demo/LicenseDemo';
  Map<String, String> queryParameters = {
    "userId": "6d026aea-3099-4b46-a728-36be50558b39",
    "id": "1",
    "catName": "SEGNALEI VERTICALI DI PERICOLO"
  };
  final client = http.Client();

  var questions = <Questions>[];

  Future<List<Questions>?> getQuestions({int? sgnId}) async {
    try {
      final response =
          await client.get(Uri.http(authority, path, queryParameters));

      // ignore: avoid_print
      print(response.statusCode);
      if (response.statusCode == 200) {
        questions = List.from(
            (jsonDecode(response.body)['questions'] as List<dynamic>)
                .map((e) => Questions.fromJson(jsonDecode(jsonEncode(e)))));

        questions =
            List<Questions>.from(questions.where((e) => e.sgnId == sgnId));

        // for (var i in questions) {
        //   // ignore: avoid_print
        //   print(i.sgnId);
        // }
        return questions;
      }
      return null;
    } catch (e) {
      // ignore: avoid_print
      // print(e);
      rethrow;
    }
  }
}

///
///
///
///
///
///
/// widget
///
///
enum LOADING_STATE { idle, loading, retrived }

class TestApiWidget extends StatefulWidget {
  const TestApiWidget({Key? key}) : super(key: key);

  @override
  State<TestApiWidget> createState() => _TestApiWidgetState();
}

class _TestApiWidgetState extends State<TestApiWidget> {
  final _service = QuestionService();

  LOADING_STATE _isLoading = LOADING_STATE.idle;

  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = LOADING_STATE.loading;
      _service.getQuestions(sgnId: 10).whenComplete(() {
        setState(() {
          _isLoading = LOADING_STATE.retrived;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: 'enter sgnId to filter questions'),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    setState(() {
                      _isLoading = LOADING_STATE.loading;
                      _service
                          .getQuestions(sgnId: int.parse(_controller.text))
                          .whenComplete(() {
                        setState(() {
                          _isLoading = LOADING_STATE.retrived;
                        });
                      });
                    });
                  }
                },
                child: const Text('fetchData'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              child: Text(
                'Total: ${_isLoading == LOADING_STATE.loading ? '-' : _service.questions.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            _isLoading == LOADING_STATE.loading
                ? const Center(child: CircularProgressIndicator())
                : _isLoading == LOADING_STATE.idle
                    ? const SizedBox()
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _service.questions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SGN ID: ${_service.questions[index].sgnId ?? 'null'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                  'question id: ${_service.questions[index].qtnId ?? 'null'}'),
                              Text(
                                  'question italian: ${_service.questions[index].qtnItalian ?? 'null'}'),
                              Text(
                                  'question audio: ${_service.questions[index].qtnAudio ?? 'null'}'),
                              Text(
                                  'question image: ${_service.questions[index].qtnImage ?? 'null'}'),
                            ],
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}
