import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minispotify/state/providers.dart';
import 'package:minispotify/ui/shared/currently_playing_thumbnail.dart';
import 'package:minispotify/ui/shared/currently_playing_title.dart';
import 'package:minispotify/ui/shared/play_pause_button.dart';
import 'package:minispotify/ui/shared/player_slider.dart';

import 'package:minispotify/extensions.dart';

class PlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'My Awesome Playlist',
          style: GoogleFonts.barlow(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 32,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFe63946), Colors.black.withOpacity(0.6)],
                  stops: [0.0, 0.4],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.repeated)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 60.0,
                  ),
                  child: CurrentlyPlayingThumbnail(
                    height: MediaQuery.of(context).size.width - 60,
                    width: MediaQuery.of(context).size.width - 60,
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: CurrentlyPlayingText(
                    fontSize: 14,
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: PlayerControlWidget())
            ],
          )),
    );
  }
}

class PlayerControlWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioPlayer = context.read(audioPlayerProvider);
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Consumer(
              builder: (context, watch, child) {
                final totalDuration = watch(currentPositionProvider);
                return totalDuration.when(
                    data: (value) =>
                        Text(Duration(seconds: value.toInt()).format()),
                    loading: () => Container(),
                    error: (_, __) => Container());
              },
            ),
            Flexible(
                flex: 2,
                child: PlayerSlider(
                  isMini: false,
                )),
            Consumer(
              builder: (context, watch, child) {
                final totalDuration = watch(totalDurationProvider);
                return totalDuration.when(
                    data: (value) =>
                        Text(Duration(seconds: value.toInt()).format()),
                    loading: () => Container(),
                    error: (_, __) => Container());
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
              width: 90,
              child: IconButton(
                icon: Icon(
                  Icons.skip_previous,
                  size: 40,
                ),
                onPressed: () {
                  audioPlayer.previous();
                },
              ),
            ),
            SizedBox(
              height: 90,
              width: 90,
              child: PlayPauseButton(
                height: 90,
                width: 90,
                iconSize: 70,
                pauseIcon: Icons.pause_circle_filled,
                playIcon: Icons.play_circle_filled,
              ),
            ),
            SizedBox(
              height: 90,
              width: 90,
              child: IconButton(
                icon: Icon(
                  Icons.skip_next,
                  size: 40,
                ),
                onPressed: () {
                  audioPlayer.next();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
