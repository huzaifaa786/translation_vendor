import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InPersonMeetingLocationScreen extends StatefulWidget {
  const InPersonMeetingLocationScreen({Key? key, this.latitude, this.longitude}) : super(key: key);

  final double? latitude;
  final double? longitude;

  @override
  _InPersonMeetingLocationScreenState createState() => _InPersonMeetingLocationScreenState();
}

class _InPersonMeetingLocationScreenState extends State<InPersonMeetingLocationScreen> {
  Set<Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) {
    // Add a marker at the specified latitude and longitude
    if (widget.latitude != null && widget.longitude != null) {
      setState(() {
        markers.add(
          Marker(
            markerId: MarkerId('selected_location'),
            position: LatLng(widget.latitude!, widget.longitude!),
            infoWindow: InfoWindow(
              title: 'Selected Location',
              snippet: 'Lat: ${widget.latitude}, Lng: ${widget.longitude}',
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('In Person Meeting Location'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude ?? 0.0, widget.longitude ?? 0.0),
          zoom: 12.0,
        ),
        markers: markers,
        mapType: MapType.normal,
        compassEnabled: true,
        zoomControlsEnabled: false,
      ),
    );
  }
}
