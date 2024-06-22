import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/Logic/bloc/localisation_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Gmap extends StatefulWidget {
  const Gmap({super.key});

  @override
  State<Gmap> createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  @override
  void initState() {
    super.initState();
    // You can call GetLocalisation here with some default coordinates if necessary
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalisationBloc()..add(GetLocalisation(latitude: 0.0, longitude: 0.0)),
      child: BlocBuilder<LocalisationBloc, LocalisationState>(
        builder: (context, state) {
          if (state is LocalisationGetting) {
            final double latitude = state.latitude;
            final double longitude = state.longitude;
            print('Longitude: $longitude, Latitude: $latitude');
            return Scaffold(
              body: GoogleMap(
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(latitude, longitude),
                  zoom: 5,
                ),
              ),
            );
          } else if (state is LocalisationError) {
            return Scaffold(
              body: Center(
                child: Text(state.message),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<LocalisationBloc>(context)
                      .add(GetLocalisation(latitude: 0.0, longitude: 0.0));
                },
                child: const Icon(Icons.location_searching),
              ),
            );
          } else {
            return Scaffold(
              body: const Center(
                child: CircularProgressIndicator(),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<LocalisationBloc>(context)
                      .add(GetLocalisation(latitude: 0.0, longitude: 0.0));
                },
                child: const Icon(Icons.location_searching),
              ),
            );
          }
        },
      ),
    );
  }
}
