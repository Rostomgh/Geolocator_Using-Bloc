part of 'localisation_bloc.dart';

@immutable
abstract class LocalisationState {}

class LocalisationInitial extends LocalisationState {}

class LocalisationLoding extends LocalisationState {}

class LocalisationGetting extends LocalisationState {
  final double longitude;
  final double latitude;

  LocalisationGetting(this.longitude, this.latitude);
}

class LocalisationError extends LocalisationState {
  final String message;

  LocalisationError({required this.message});
}
