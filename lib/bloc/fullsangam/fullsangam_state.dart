import 'package:flutter/material.dart';

abstract class FullsangamState {}

class FullsangamInitial extends FullsangamState {}

class FullsangamLoading extends FullsangamState {}

class FullsangamLoaded extends FullsangamState {
  final String walletBalance;
  final TextEditingController openPannaController;
  final TextEditingController closePannaController;
  final TextEditingController pointsController;
  final List<Map<String, String>> entries;
  final int totalPoints;

  FullsangamLoaded({
    required this.walletBalance,
    required this.openPannaController,
    required this.closePannaController,
    required this.pointsController,
    required this.entries,
    required this.totalPoints,
  });

  FullsangamLoaded copyWith({
    String? walletBalance,
    TextEditingController? openPannaController,
    TextEditingController? closePannaController,
    TextEditingController? pointsController,
    List<Map<String, String>>? entries,
    int? totalPoints,
  }) {
    return FullsangamLoaded(
      walletBalance: walletBalance ?? this.walletBalance,
      openPannaController: openPannaController ?? this.openPannaController,
      closePannaController: closePannaController ?? this.closePannaController,
      pointsController: pointsController ?? this.pointsController,
      entries: entries ?? this.entries,
      totalPoints: totalPoints ?? this.totalPoints,
    );
  }
}

class FullsangamError extends FullsangamState {
  final String message;

  FullsangamError({required this.message});
}
