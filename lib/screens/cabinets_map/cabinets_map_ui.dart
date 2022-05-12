import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/loading_indicator.dart';
import '../../widgets/interactive_widget.dart';
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
      onInteractionUpdate: onScaleUpdated,
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
            ChoiceChip(
              backgroundColor: Theme.of(context).primaryColor,
              label: const Text('1 этаж'),
              selected: context.watch<CabinetsMapLogic>().selectedFloor == 1,
              labelStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: context.watch<CabinetsMapLogic>().selectedFloor == 1
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onBackground,
              ),
              selectedColor: Theme.of(context).colorScheme.secondary,
              onSelected: (_) =>
                  context.read<CabinetsMapLogic>().setNewFloor(1),
            ),
            ChoiceChip(
              backgroundColor: Theme.of(context).primaryColor,
              label: const Text('2 этаж'),
              selected: context.watch<CabinetsMapLogic>().selectedFloor == 2,
              labelStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: context.watch<CabinetsMapLogic>().selectedFloor == 2
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onBackground,
              ),
              selectedColor: Theme.of(context).colorScheme.secondary,
              onSelected: (_) =>
                  context.read<CabinetsMapLogic>().setNewFloor(2),
            ),
            ChoiceChip(
              backgroundColor: Theme.of(context).primaryColor,
              label: const Text('3 этаж'),
              selected: context.watch<CabinetsMapLogic>().selectedFloor == 3,
              labelStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: context.watch<CabinetsMapLogic>().selectedFloor == 3
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onBackground,
              ),
              selectedColor: Theme.of(context).colorScheme.secondary,
              onSelected: (_) =>
                  context.read<CabinetsMapLogic>().setNewFloor(3),
            ),
            ChoiceChip(
              backgroundColor: Theme.of(context).primaryColor,
              label: const Text('4 этаж'),
              selected: context.watch<CabinetsMapLogic>().selectedFloor == 4,
              labelStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: context.watch<CabinetsMapLogic>().selectedFloor == 4
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onBackground,
              ),
              selectedColor: Theme.of(context).colorScheme.secondary,
              onSelected: (_) =>
                  context.read<CabinetsMapLogic>().setNewFloor(4),
            ),
          ],
        ),
      ),
    );
  }
}
