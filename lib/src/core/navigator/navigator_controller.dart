import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigator_controller.freezed.dart';

@freezed
class MgDefaultNavigatorState with _$MgDefaultNavigatorState {
  factory MgDefaultNavigatorState({required int tabIndex}) = _MgDefaultNavigatorState;
}

class NavigatorController extends ValueNotifier<MgDefaultNavigatorState> {
  NavigatorController() : super(MgDefaultNavigatorState(tabIndex: 0));

  void changeTabIndex(int index) => value = value.copyWith(tabIndex: index);
}
