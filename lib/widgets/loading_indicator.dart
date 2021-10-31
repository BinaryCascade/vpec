import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    this.delayedAppears = true,
    this.appearsDuration = const Duration(milliseconds: 200),
  }) : super(key: key);

  /// `true` by default.
  ///
  /// When [true] [LoadingIndicator] will appear after [appearsDuration] time.
  /// By default appear time is `Duration(milliseconds: 200)`
  final bool delayedAppears;

  /// After this time [LoadingIndicator] will appear.
  /// By default this value is `Duration(milliseconds: 200)`
  final Duration appearsDuration;

  @override
  Widget build(BuildContext context) {
    if (delayedAppears) return appearsIndicator;
    return usualIndicator;
  }

  Widget get usualIndicator {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget get appearsIndicator {
    return FutureBuilder<bool>(
      initialData: false,
      future: awaitMoment(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data!) return usualIndicator;
        return const SizedBox();
      },
    );
  }

  Future<bool> awaitMoment() async {
    await Future.delayed(appearsDuration);
    return true;
  }
}
