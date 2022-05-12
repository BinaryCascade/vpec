import 'package:flutter/material.dart';

class InteractiveWidget extends StatefulWidget {
  const InteractiveWidget({
    Key? key,
    required this.child,
    this.onInteractionUpdate,
  }) : super(key: key);

  final Widget child;
  final Function(double)? onInteractionUpdate;

  @override
  State<InteractiveWidget> createState() => _InteractiveWidgetState();
}

class _InteractiveWidgetState extends State<InteractiveWidget>
    with TickerProviderStateMixin {
  final transformationController = TransformationController();
  late AnimationController _zoomAnimationController;
  late AnimationController _zoomOutAnimationController;

  bool _zoomed = false;
  final Offset _dragPosition = const Offset(0.0, 0.0);

  void transformListener() {
    final scale = transformationController.value.row0.r;

    if (scale > 1 && !_zoomed) {
      setState(() => _zoomed = true);

      _zoomOutAnimationController.reset();
    } else if (scale <= 1 && _zoomed) {
      setState(() => _zoomed = false);

      _zoomAnimationController.reset();
    }
  }

  @override
  void initState() {
    transformationController.addListener(transformListener);
    _zoomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _zoomOutAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    transformationController.removeListener(transformListener);
    super.dispose();
  }

  void animateZoom({
    required Matrix4 end,
    required AnimationController animationController,
  }) {
    final mapAnimation = Matrix4Tween(
      begin: transformationController.value,
      end: end,
    ).animate(animationController);

    void animationListener() {
      transformationController.value = mapAnimation.value;

      if (transformationController.value == end) {
        mapAnimation.removeListener(animationListener);
      }
    }

    mapAnimation.addListener(animationListener);

    animationController.forward();
  }

  void doubleTapDownHandler(TapDownDetails details) {
    if (_zoomed) {
      final defaultMatrix = Matrix4.diagonal3Values(1, 1, 1);

      animateZoom(
        animationController: _zoomOutAnimationController,
        end: defaultMatrix,
      );
    } else {
      final x = -details.localPosition.dx;
      final y = -details.localPosition.dy;
      const scaleMultiplier = 2.0;

      final zoomedMatrix = Matrix4(
        // a0 a1 a2 a3
        scaleMultiplier,
        0.0,
        0.0,
        0,
        // a0 a1 a2 a3
        0.0,
        scaleMultiplier,
        0.0,
        0,
        // a0 a1 a2 a3
        0.0,
        0.0,
        1.0,
        0.0,
        // a0 a1 a2 a3
        x,
        y,
        0.0,
        1.0,
      );

      animateZoom(
        animationController: _zoomAnimationController,
        end: zoomedMatrix,
      );
    }
  }

  /// Required for `onDoubleTapDown` to work
  void onDoubleTap() {} //ignore: no-empty-block

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned(
            left: _dragPosition.dx,
            top: _dragPosition.dy,
            bottom: -_dragPosition.dy,
            right: -_dragPosition.dx,
            child: GestureDetector(
              onDoubleTapDown: doubleTapDownHandler,
              onDoubleTap: onDoubleTap,
              child: InteractiveViewer(
                onInteractionUpdate: (details) {
                  if (widget.onInteractionUpdate != null) {
                    double correctScaleValue =
                        transformationController.value.getMaxScaleOnAxis();
                    widget.onInteractionUpdate!(correctScaleValue);
                  }
                },
                minScale: 0.8,
                maxScale: 8.0,
                transformationController: transformationController,
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
