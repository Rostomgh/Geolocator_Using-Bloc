import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/Logic/bloc/localisation_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Update the import path as necessary

class Gmap extends StatefulWidget {
  const Gmap({super.key});

  @override
  State<Gmap> createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  @override
  void initState() {
    super.initState();
    // Initialize the localisation event
    BlocProvider.of<LocalisationBloc>(context)
        .add(GetLocalisation(latitude: 0.0, longitude: 0.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocalisationBloc, LocalisationState>(
        builder: (context, state) {
          if (state is LocalisationGetting) {
            final double latitude = state.latitude;
            final double longitude = state.longitude;
            print('Longitude: $longitude, Latitude: $latitude');
            return GoogleMap(
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 5,
              ),
            );
          } else if (state is LocalisationError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
}
