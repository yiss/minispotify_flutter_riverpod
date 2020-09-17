import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:minispotify/state/providers.dart';
import 'package:minispotify/ui/player_page.dart';
import 'package:minispotify/ui/shared/currently_playing_thumbnail.dart';
import 'package:minispotify/ui/shared/currently_playing_title.dart';
import 'package:minispotify/ui/shared/play_pause_button.dart';
import 'package:minispotify/ui/shared/player_slider.dart';

class MiniPlayerWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currenlyPlaying = watch(currentlyPlayingProvider);
    return currenlyPlaying.when(
        data: (audioTrack) {
          if (audioTrack.isEmpty)
            return Container();
          else
            return AnimatedContainer(
              duration: Duration(seconds: 1),
              child: SizedBox(
                height: 61,
                child: Column(
                  children: [
                    PlayerSlider(
                      isMini: true,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 8,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlayerPage()));
                            },
                            child: Row(
                              children: [
                                Flexible(
                                    child: CurrentlyPlayingThumbnail(
                                  height: 60,
                                  width: 60,
                                )),
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: CurrentlyPlayingText(
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: PlayPauseButton(
                                  height: 20,
                                  width: 20,
                                  pauseIcon: Icons.pause,
                                  playIcon: Icons.play_arrow,
                                ),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
        },
        loading: () => Container(),
        error: (_, __) => Container());
  }
}
