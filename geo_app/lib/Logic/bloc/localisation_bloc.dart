import 'package:bloc/bloc.dart';
import 'package:geo_app/Screen/HomePage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'localisation_event.dart';
part 'localisation_state.dart';

class LocalisationBloc extends Bloc<LocalisationEvent, LocalisationState> {
  LocalisationBloc() : super(LocalisationInitial()) {
    on<GetLocalisation>(_onGetLocalisation);
  }

  void _onGetLocalisation(GetLocalisation event, Emitter<LocalisationState> emit) async {
    emit(LocalisationLoding());
    try {
      Position position = await LocationService.determinePosition();
      print('Longitude: ${position.longitude}, Latitude: ${position.latitude}');
      emit(LocalisationGetting(position.latitude, position.longitude));
    } catch (e) {
      emit(LocalisationError(message: 'Failed to fetch location: $e'));
    }
  }
}
