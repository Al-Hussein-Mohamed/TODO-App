import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/setting_provider.dart';

DateTime extractDate(DateTime selectedDate){
  return DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
}