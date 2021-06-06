import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {}

class LogOutEvent extends SettingsEvent {
  @override
  List<Object?> get props => [];
}
