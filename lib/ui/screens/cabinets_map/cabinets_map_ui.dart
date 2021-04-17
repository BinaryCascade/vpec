import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../widgets/loading_indicator.dart';
import 'cabinets_map_logic.dart';

class ImageMap extends StatelessWidget {
  final PhotoViewController photoController;
  final String imageUrl;

  const ImageMap({Key key, this.photoController, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PhotoView.customChild(
        minScale: PhotoViewComputedScale.contained * 0.8,
        backgroundDecoration: BoxDecoration(color: Colors.transparent),
        controller: photoController,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (_,__) => LoadingIndicator(),
          errorWidget: (context, url, error) => Text(
            "Ошибка загрузки:\n$error",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}

class FloorChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  context.read<CabinetsMapLogic>().setFloor(1);
                  context.read<CabinetsMapLogic>().updateImage();
                },
              ),
              InputChip(
                label: Text('2 этаж'),
                onPressed: () {
                  context.read<CabinetsMapLogic>().setFloor(2);
                  context.read<CabinetsMapLogic>().updateImage();
                },
              ),
              InputChip(
                label: Text('3 этаж'),
                onPressed: () {
                  context.read<CabinetsMapLogic>().setFloor(3);
                  context.read<CabinetsMapLogic>().updateImage();
                },
              ),
              InputChip(
                label: Text('4 этаж'),
                onPressed: () {
                  context.read<CabinetsMapLogic>().setFloor(4);
                  context.read<CabinetsMapLogic>().updateImage();
                },
              ),
            ],
          ),
        ));
  }
}
