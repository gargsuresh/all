import 'package:flutter/material.dart';

abstract class FullsangamEvent {}

class LoadFullsangam extends FullsangamEvent {
  final String mid;
  final String cmid;

  LoadFullsangam({required this.mid, required this.cmid});
}

class AddEntry extends FullsangamEvent {}

class RemoveEntry extends FullsangamEvent {
  final Map<String, String> entry;

  RemoveEntry({required this.entry});
}

class SubmitEntries extends FullsangamEvent {}
