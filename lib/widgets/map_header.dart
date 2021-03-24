import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../style.dart';

class MapHeader extends StatefulWidget {
  final double latFrom;
  final double latTo;
  final double lonFrom;
  final double lonTo;
  final List<LatLng> routePoints;
  const MapHeader({
    @required this.latFrom,
    @required this.latTo,
    @required this.lonFrom,
    @required this.lonTo,
    @required this.routePoints,
    Key key,
  }) : super(key: key);

  @override
  _MapHeaderState createState() => _MapHeaderState();
}

class _MapHeaderState extends State<MapHeader> {
  MapController _mapController;

  @override
  void initState() {
    print(widget.routePoints);
    _mapController = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 353,
          width: double.infinity,
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng((widget.latFrom + widget.latTo) / 2 - 1,
                  (widget.lonFrom + widget.lonTo) / 2),
              zoom: 5.0,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/tonishiva/ckduqbyhs05kj19qngzgcswpy/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidG9uaXNoaXZhIiwiYSI6ImNrZHVxODh1eDJhNHQyd21xdnN0ZmVieG4ifQ.NsQZXSLTOrVCPYOowGKi3g",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1IjoidG9uaXNoaXZhIiwiYSI6ImNrZHVxODh1eDJhNHQyd21xdnN0ZmVieG4ifQ.NsQZXSLTOrVCPYOowGKi3g',
                    'id': 'mapbox.mapbox-streets-v8',
                  }),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: LatLng(widget.latFrom, widget.lonFrom),
                    anchorPos: AnchorPos.align(AnchorAlign.top),
                    builder: (ctx) => Container(
                      child: Icon(
                        Icons.place,
                        size: 40,
                        color: Style.primaryColor,
                      ),
                    ),
                  ),
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: LatLng(widget.latTo, widget.lonTo),
                    anchorPos: AnchorPos.align(AnchorAlign.top),
                    builder: (ctx) => Container(
                      child: Icon(
                        Icons.place,
                        size: 40,
                        color: Style.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              PolylineLayerOptions(
                polylines: [
                  Polyline(
                    points: widget.routePoints,
                    strokeWidth: 2.5,
                    color: Style.primaryColor,
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        )
      ],
    );
  }
}
