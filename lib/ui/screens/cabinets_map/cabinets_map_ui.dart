import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/interactive_widget.dart';
import '../../widgets/loading_indicator.dart';
import 'cabinets_map_logic.dart';

@immutable
class CabinetsMap extends StatelessWidget {
  const CabinetsMap({
    Key? key,
    required this.onScaleUpdated,
  }) : super(key: key);
  final Function(double) onScaleUpdated;

  @override
  Widget build(BuildContext context) {
    return InteractiveWidget(
      child: CachedNetworkImage(
        imageUrl: context.watch<CabinetsMapLogic>().nowImageUrl,
        useOldImageOnUrlChange: true,
        // disable animations between old and new image
        fadeInDuration: const Duration(seconds: 0),
        fadeOutDuration: const Duration(seconds: 0),
        progressIndicatorBuilder: (context, _, __) {
          return const LoadingIndicator();
        },
        errorWidget: (context, url, error) => Text(
          "Ошибка загрузки:\n$error",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        imageBuilder: (context, image) {
          return Image(
            image: image,
          );
        },
      ),
      onInteractionUpdate: (scale) => onScaleUpdated(scale),
    );
  }
}

@immutable
class FloorChips extends StatelessWidget {
  // if make FloorChips const, then change animations won't work
  // ignore: prefer_const_constructors_in_immutables
  FloorChips({Key? key}) : super(key: key);

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
                selectedColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                onPressed: () {
                  context.read<CabinetsMapLogic>().setFloor(1);
                  context.read<CabinetsMapLogic>().updateImage();
                },
              ),
              InputChip(
                label: const Text('2 этаж'),
                selected: context.read<CabinetsMapLogic>().selectedFloor == 2,
                selectedColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                onPressed: () {
                  context.read<CabinetsMapLogic>().setFloor(2);
                  context.read<CabinetsMapLogic>().updateImage();
                },
              ),
              InputChip(
                label: const Text('3 этаж'),
                selected: context.read<CabinetsMapLogic>().selectedFloor == 3,
                selectedColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                onPressed: () {
                  context.read<CabinetsMapLogic>().setFloor(3);
                  context.read<CabinetsMapLogic>().updateImage();
                },
              ),
              InputChip(
                label: const Text('4 этаж'),
                selected: context.read<CabinetsMapLogic>().selectedFloor == 4,
                selectedColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3),
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
