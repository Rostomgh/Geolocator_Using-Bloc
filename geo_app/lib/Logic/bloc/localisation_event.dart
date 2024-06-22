part of 'localisation_bloc.dart';

@immutable
abstract class LocalisationEvent {}

class GetLocalisation extends LocalisationEvent {
  final double latitude;
  final double longitude;

  GetLocalisation({required this.latitude, required this.longitude});
}
