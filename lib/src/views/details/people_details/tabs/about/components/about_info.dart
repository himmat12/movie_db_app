import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../configs/configs.dart';
import '../../../../../../models/peoples/people_model.dart';

// ignore: must_be_immutable
class AboutInfo extends StatelessWidget {
  AboutInfo({required this.people, Key? key}) : super(key: key);
  final PeopleModel people;

  /// age calculation
  String? birthDate;
  String? currentDate;
  String? dateNow;
  String? dateOfBirth;
  String? age;

  String? birthday;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(initState: (_) {
      birthDate = people.birthday;
      currentDate = DateFormat.y().format(DateTime.now());
      dateNow = currentDate!.substring(0, 4);
      dateOfBirth = people.birthday == null ? '-' : birthDate!.substring(0, 4);
      age = people.birthday == null
          ? '-'
          : '${int.parse(dateNow!) - int.parse(dateOfBirth!)}';
      birthday = people.birthday == null
          ? '-'
          : DateFormat.yMMMMd().format(DateTime.parse(people.birthday!));
    }, builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            _RowBuilder(prefixText: 'Age', suffixText: age),
            _RowBuilder(prefixText: 'Born on', suffixText: birthday),
            _RowBuilder(
                prefixText: 'From', suffixText: people.placeOfBirth ?? "-"),
          ],
        ),
      );
    });
  }
}

// helper
class _RowBuilder extends StatelessWidget {
  const _RowBuilder({this.prefixText, this.suffixText, Key? key})
      : super(key: key);
  final String? prefixText;
  final String? suffixText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            prefixText ?? 'prefix Text',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: n - 2,
              color: primaryDarkBlue.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              suffixText ?? 'suffix text',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: n - 2,
                color: primaryDarkBlue.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
