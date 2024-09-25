import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_demo/utils/google_map_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'google maps Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'google maps Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;
  final _mapController = Completer<GoogleMapController>();

  final List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    init();
  }

  late final LocationSettings _locationSettings;
  late final StreamSubscription<Position> _liveLocationStream;
  bool showGetDirectionsButton = false;

  Map<PolylineId, Polyline> polyLinesMap = {};

  void init() async {
    _currentPosition = await GoogleMapUtils.determinePosition();
    _locationSettings = GoogleMapUtils.getLocationSettings();
    //_liveLocationStream = _startLocationStream();
    final myPosition = LatLng(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
    _mapController.future.then((controller) => controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: myPosition,
                zoom: 15.0,
                bearing: _currentPosition?.heading ?? 0),
          ),
        ));
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
      String assetName) async {
    String svgString =
        await DefaultAssetBundle.of(context).loadString(assetName);
    //Draws string representation of svg to DrawableRoot
    final PictureInfo pictureInfo =
        await vg.loadPicture(SvgStringLoader(svgString), null);
    ui.Image image = await pictureInfo.picture.toImage(26, 37);
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.bytes(bytes!.buffer.asUint8List());
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromPngAsset(
      String assetName) async {
    return BitmapDescriptor.asset(
      const ImageConfiguration(
        size: Size(30, 30),
      ),
      assetName,
    );
  }

  StreamSubscription<Position> _startLocationStream() {
    return Geolocator.getPositionStream().listen((Position? position) async {
      print("____________${position?.heading}");
      final currMarker = Marker(
        markerId: const MarkerId("curr_loc"),
        flat: true,
        rotation: position?.heading ?? 0.0,
        position: LatLng(position!.latitude, position.longitude),
        icon: await _bitmapDescriptorFromPngAsset(
          "assets/navigation_icon.png",
        ),
      );
      if (_markers.any((marker) => marker.markerId.value == "curr_loc")) {
        _markers[_markers.indexWhere(
            (marker) => marker.markerId.value == "curr_loc")] = currMarker;
      } else {
        _markers.add(currMarker);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GoogleMap(
        onMapCreated: (gController) => _mapController.complete(gController),
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
        ),
        markers: _markers.toSet(),
        polylines: polyLinesMap.values.toSet(),
        onLongPress: (destination) async {
          final desMarker = Marker(
            markerId: const MarkerId("destination"),
            position: destination,
            infoWindow: const InfoWindow(title: "destination"),
          );
          if (_markers
              .any((marker) => marker.markerId.value == "destination")) {
            _markers[_markers.indexWhere(
                    (marker) => marker.markerId.value == "destination")] =
                desMarker;
          } else {
            _markers.add(desMarker);
          }
          setState(() {});

          final polyLines = await fetchPolyLines(
              origin: _currentPosition!.toLatLng(),
              destination: destination);
          generatePolyLineFromPoints(polyLines);
        },
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }

  Future<List<LatLng>> fetchPolyLines(
      {required LatLng origin, required LatLng destination}) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "AIzaSyD4-HHVfSUur0PtuG-BAA4CNjZZeQzYJa0",
      request: PolylineRequest(
        origin: PointLatLng(origin.latitude, origin.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        mode: TravelMode.driving,
      ),
    );
    print("_____________${result.points}");
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 4);
    setState(() {
      polyLinesMap[id] = polyline;
    });
  }
  @override
  void dispose() {
    _liveLocationStream.cancel();
    _mapController.future.then((value) => value.dispose());
    super.dispose();
  }
}

extension on Position {
  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}

