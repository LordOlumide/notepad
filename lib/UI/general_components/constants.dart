import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Prepare the date and time formats with intl
DateFormat dayDateFormat = DateFormat.yMMMMd('en_US'); // month date, year
DateFormat hourDateFormat = DateFormat.jm(); // time

const kTitleTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

const kBodyTextStyle = TextStyle(
  fontSize: 12,
);

const kDateTimeTextStyle = TextStyle(
  fontSize: 11,
  color: Colors.black45,
);
