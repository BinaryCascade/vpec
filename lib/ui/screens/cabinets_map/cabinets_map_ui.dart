import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../widgets/loading_indicator.dart';
import 'cabinets_map_logic.dart';

class ImageMap extends StatelessWidget {
  final PhotoViewController? photoController;
  final String imageUrl;

  const ImageMap({Key? key, this.photoController, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PhotoView.customChild(
        minScale: PhotoViewComputedScale.contained * 0.8,
        backgroundDecoration: const BoxDecoration(color: Colors.transparent),
        controller: photoController,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (_, __) => const LoadingIndicator(),
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
  const FloorChips({Key? key}) : super(key: key);

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
                label: const Text('1 этаж'),
                selected: context.read<CabinetsMapLogic>().selectedFloor == 1,
                selectedColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                onPressed: () {
                  context.read<CabinetsMapLogic>().setFloor(1);
                  context.read<CabinetsMapLogic>().updateImage();
                },
              ),
              InputChip(
                label: const Text('2 этаж'),
                selected: context.read<CabinetsMapLogic>().selectedFloor == 2,
                selectedColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                onPressed: () {
                  context.read<CabinetsMapLogic>().setFloor(2);
                  context.read<CabinetsMapLogic>().updateImage();
                },
              ),
              InputChip(
                label: const Text('3 этаж'),
                selected: context.read<CabinetsMapLogic>().selectedFloor == 3,
                selectedColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                onPressed: () {
                  context.read<CabinetsMapLogic>().setFloor(3);
                  context.read<CabinetsMapLogic>().updateImage();
                },
              ),
              InputChip(
                label: const Text('4 этаж'),
                selected: context.read<CabinetsMapLogic>().selectedFloor == 4,
                selectedColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
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
