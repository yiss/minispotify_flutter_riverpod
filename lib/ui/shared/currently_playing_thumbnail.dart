import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:minispotify/state/providers.dart';

class CurrentlyPlayingThumbnail extends ConsumerWidget {
  final double height;
  final double width;

  const CurrentlyPlayingThumbnail({Key key, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentlyPlaying = watch(currentlyPlayingProvider);
    return currentlyPlaying.when(
        data: (audioTrackModel) => Image.network(
              audioTrackModel.thumbnail,
              fit: BoxFit.cover,
              height: height,
              width: width,
            ),
        loading: () => Container(),
        error: (_, __) => Container());
  }
}
