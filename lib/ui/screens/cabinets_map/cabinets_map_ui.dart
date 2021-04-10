import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import 'cabinets_map_logic.dart';

Widget buildLoadingIndicator() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildMapImage(String imageUrl, PhotoViewController photoController) {
  return Center(
    child: PhotoView.customChild(
      minScale: PhotoViewComputedScale.contained * 0.8,
      backgroundDecoration: BoxDecoration(color: Colors.transparent),
      controller: photoController,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        errorWidget: (context, url, error) => Text(
          "Ошибка загрузки:\n$error",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    ),
  );
}

class BuildChips extends StatefulWidget {
  final Function callback;

  BuildChips({@required void updateScreen()}) : callback = updateScreen;

  @override
  _BuildChipsState createState() => _BuildChipsState();
}

class _BuildChipsState extends State<BuildChips> {
  @override
  Widget build(BuildContext context) {
    FloorStorage floorStorage = Get.put(FloorStorage());

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 6.0,
            children: [
              InputChip(
                label: Text('1 этаж'),
                onPressed: () {
                  floorStorage.setFloor(1);
                  floorStorage.getScaledImage();
                  widget.callback();
                },
              ),
              InputChip(
                label: Text('2 этаж'),
                onPressed: () async {
                  floorStorage.setFloor(2);
                  floorStorage.getScaledImage();
                  widget.callback();
                },
              ),
              InputChip(
                label: Text('3 этаж'),
                onPressed: () {
                  floorStorage.setFloor(3);
                  floorStorage.getScaledImage();
                  widget.callback();
                },
              ),
              InputChip(
                label: Text('4 этаж'),
                onPressed: () {
                  floorStorage.setFloor(4);
                  floorStorage.getScaledImage();
                  widget.callback();
                },
              ),
            ],
          ),
        ));
  }
}
