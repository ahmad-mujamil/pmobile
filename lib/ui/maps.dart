import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';


class Maps extends StatefulWidget {
  const Maps({super.key});
  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lokasi Saat Ini',style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: false,
        
        ),
        body: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(-8.5911597,116.1152131),
            initialZoom: 15,
            minZoom: 10,
            maxZoom: 19,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            maxZoom: 19,
          ),
          CurrentLocationLayer(
            alignPositionOnUpdate: AlignOnUpdate.always,
            style: LocationMarkerStyle(
              marker: const DefaultLocationMarker(
                color: Colors.green,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              markerSize: const Size.square(40),
              accuracyCircleColor: Colors.green.withOpacity(0.1),
              headingSectorColor: Colors.green.withOpacity(0.8),
              headingSectorRadius: 120,
            ),
          ),
        ],
      ),
    
      );
  }
}
