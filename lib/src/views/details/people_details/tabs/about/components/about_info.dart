import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../../../configs/configs.dart';
import '../../../../../../models/peoples/people_model.dart';

Widget aboutInfo({required PeopleModel people}) {
  /// age calculation
  final String? birthDate = people.birthday;
  final String? currentDate = DateFormat.y().format(DateTime.now());
  final String? dateNow = currentDate!.substring(0, 4);
  final String? dateOfBirth =
      people.birthday == null ? '-' : birthDate!.substring(0, 4);
  final String? age = people.birthday == null
      ? '-'
      : '${int.parse(dateNow!) - int.parse(dateOfBirth!)}';

  final String? birthday = people.birthday == null
      ? '-'
      : DateFormat.yMMMMd().format(DateTime.parse(people.birthday!));

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      children: [
        rowBuilder(prefixText: 'Age', suffixText: age),
        rowBuilder(prefixText: 'Born on', suffixText: birthday),
        rowBuilder(prefixText: 'From', suffixText: people.placeOfBirth ?? "-"),
      ],
    ),
  );
}

// helper

Widget rowBuilder({String? prefixText, String? suffixText}) => Padding(
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
