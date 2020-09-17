import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minispotify/state/providers.dart';

class PlayerSlider extends ConsumerWidget {
  final bool isMini;

  PlayerSlider({this.isMini});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final totalDuration = watch(totalDurationProvider).when(
        data: (duration) => duration,
        loading: () => 0.0,
        error: (_, __) => 0.0);
    final currentPosition = watch(currentPositionProvider).when(
        data: (position) => position,
        loading: () => 0.0,
        error: (_, __) => 0.0);

    if (isMini) {
      return SizedBox(
        height: 1,
        child: SliderTheme(
          child: Slider(
            value: currentPosition,
            max: totalDuration,
            onChanged: null,
          ),
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.orange,
            inactiveTrackColor: Colors.red.withOpacity(0.3),
            trackShape: SpotifyMiniPlayerTrackShape(),
            trackHeight: 2,
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 0,
            ),
          ),
        ),
      );
    } else {
      return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.white.withOpacity(0.3),
          thumbColor: Colors.white,
          overlayColor: Colors.white.withOpacity(0.3),
          trackHeight: 2,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
        ),
        child: Slider(
          value: currentPosition,
          max: totalDuration,
          onChanged: (newPosition) {
            context
                .read(audioPlayerProvider)
                .seek(Duration(seconds: newPosition.toInt()));
          },
        ),
      );

      // SizedBox(
      //   height: 1,
      //   child: SliderTheme(
      //     child: Slider(
      //       value: currentPosition,
      //       max: totalDuration,
      //       onChanged: (newPosition) {
      //         context
      //             .read(audioPlayerProvider)
      //             .seek(Duration(seconds: newPosition.toInt()));
      //       },
      //     ),
      //     data: SliderTheme.of(context).copyWith(
      //       activeTrackColor: Colors.white,
      //       inactiveTrackColor: Colors.white.withOpacity(0.3),
      //       trackShape: SpotifyMiniPlayerTrackShape(),
      //       trackHeight: 1,
      //       thumbShape: RoundSliderThumbShape(
      //         enabledThumbRadius: 0,
      //       ),
      //     ),
      //   ),
      // );
    }
  }
}

class SpotifyMiniPlayerTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
