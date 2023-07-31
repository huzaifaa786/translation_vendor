import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:translation_vendor/models/service.dart';
import 'package:translation_vendor/static/locationField.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';

class VendorMapScreen extends StatefulWidget {
   const VendorMapScreen({super.key, this.service});
  final VendorService? service;
  @override
  _VendorMapScreenState createState() => _VendorMapScreenState();
}

class _VendorMapScreenState extends State<VendorMapScreen> {
  GoogleMapController? mapController;
  // List<LatLng> polygonVertices = [];
  // Set<Polygon> polygons = {};
  Set<Circle> circles = {};
  double radius = 1000;
  LatLng? chnagePoint;

  // bool isCircleMode = false;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    print('widget.service&&&&&&');
    print(widget.service!.lat);
    print(widget.service!.lng);
     setState(() {
      circles.clear();
      circles.add(
        Circle(
          circleId: CircleId('delivery_radius'),
          center: LatLng(widget.service!.lat!, widget.service!.lng!),
          radius: widget.service!.radius!,
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.3),
          strokeWidth: 2,
        ),
      );
  });
  }

  void onchange(String rad) {
    if (rad.isEmpty) {
      setState(() {
        radius = 1000;
        _handleCircleTap(chnagePoint!);
      });
    } else {
      double meters = double.parse(rad) * 1000;
      setState(() {
        radius = meters;
        _handleCircleTap(chnagePoint!);
      });
    }
  }

  // void _handlePolygonTap(LatLng point) {
  //   setState(() {
  //     if (!isCloseToExistingVertices(point)) {
  //       polygonVertices.add(point);
  //       polygons.clear();
  //       polygons.add(
  //         Polygon(
  //             polygonId: PolygonId('delivery_area'),
  //             points: polygonVertices,
  //             strokeColor: Colors.blue,
  //             fillColor: Colors.blue.withOpacity(0.3),
  //             strokeWidth: 2),
  //       );
  //     }
  //   });
  // }

  void _handleCircleTap(LatLng point) {
    chnagePoint = point;
    setState(() {
      circles.clear();
      circles.add(
        Circle(
          circleId: CircleId('delivery_radius'),
          center: point,
          radius: radius,
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.3),
          strokeWidth: 2,
        ),
      );
    });
  }

  // bool isCloseToExistingVertices(LatLng point) {
  //   if (polygonVertices.length < 3) {
  //     return false; // No need to check proximity if less than 3 vertices
  //   }
  //   final double threshold = 0.0001;
  //   for (var vertex in polygonVertices) {
  //     final double latDiff = (vertex.latitude - point.latitude).abs();
  //     final double lngDiff = (vertex.longitude - point.longitude).abs();

  //     if (latDiff < threshold && lngDiff < threshold) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // void _toggleMode() {
  //   setState(() {
  //     isCircleMode = !isCircleMode;
  //     polygons.clear();
  //     polygonVertices.clear();
  //     circles.clear();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Determine range of service'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(serviceController.locationData!.latitude!,
                  serviceController.locationData!.longitude!),
              zoom: 12.0,
            ),
            // polygons: polygons,
            circles: circles,
            mapType: MapType.normal,
            compassEnabled: true,
            zoomControlsEnabled: false,
            onTap: _handleCircleTap,
            // onTap: isCircleMode ? _handleCircleTap : _handlePolygonTap,
          ),
          circles.isEmpty
              ? Container()
              : Positioned(
                  top: 16,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: LocationField(
                      onChange: onchange,
                      labelText: 'Radius',
                      type: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      hint: 'Enter Radius In KiloMeters',
                    ),
                  ),
                ),
          // Positioned(
          //   bottom: 16,
          //   left: 16,
          //   child: FloatingActionButton(
          //     heroTag: "btn1",
          //     backgroundColor: mainColor,
          //     onPressed: _toggleMode,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(
          //           Icons.compare_arrows,
          //           size: 20,
          //           color: White,
          //         ),
          //         Text(
          //           isCircleMode ? "Polygon" : "Circle",
          //           style: TextStyle(fontSize: 9, color: White),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn2",
        backgroundColor: mainColor,
        onPressed: () {
          if (circles.isNotEmpty) {
            saveCircleCoordinates(circles.first);
            return;
          } else {
            Get.snackbar(
              "Empty!",
              'Please Select Area first before saving range.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
          // if (isCircleMode && circles.isNotEmpty) {
          //   saveCircleCoordinates(circles.first);
          //   return;
          // } else if (!isCircleMode && polygonVertices.isNotEmpty) {
          //   savePolygonCoordinates(polygonVertices);
          //   return;
          // } else {
          //   Get.snackbar(
          //     "Empty!",
          //     'Please Select Area first before saving range.',
          //     snackPosition: SnackPosition.BOTTOM,
          //     backgroundColor: Colors.red,
          //     colorText: Colors.white,
          //   );
          // }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save, size: 20, color: Colors.white),
            Text(
              "Save",
              style: TextStyle(fontSize: 9, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> savePolygonCoordinates(List<LatLng> coordinates) async {
  //   print('Polygon LatLng');
  //   print(coordinates);
  // }

  Future<void> saveCircleCoordinates(Circle circle) async {
    serviceController.chnagePoint = circle.center;
    serviceController.radius = radius;
    print(serviceController.chnagePoint);
    setState(() {});
    Get.back();
    Get.snackbar(
      'Selected',
      'Loaction Selected Successfully.',
      colorText: White,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: mainColor,
    );
  }
}
