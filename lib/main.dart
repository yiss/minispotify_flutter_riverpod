import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minispotify/ui/home_page.dart';

void main() {
  runApp(MusicPlayerApp());
}

class MusicPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
          title: 'Music Player',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.transparent,
            brightness: Brightness.dark,
            textTheme: GoogleFonts.barlowTextTheme(ThemeData.dark().textTheme),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage()),
    );
  }
}

// class CurrentlyPlayingWidget extends ConsumerWidget {
//   const CurrentlyPlayingWidget({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     // final currentlyPlaying = watch(currentlyPlayingProvider).state;
//     if (!currentlyPlaying.isEmpty) {
//       return Visibility(
//         visible: !currentlyPlaying.isEmpty,
//         child: Container(
//           height: 50,
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Flexible(
//                 flex: 1,
//                 child: Image.network(currentlyPlaying.thumbnail),
//               ),
//               Flexible(
//                 flex: 3,
//                 child: Text(currentlyPlaying.name),
//               ),
//               Flexible(
//                 flex: 1,
//                 child: StreamBuilder(
//                   stream: context.read(audioPlayerProvider).isPlaying,
//                   builder: (context, snapshot) {
//                     return IconButton(
//                       icon: Icon(snapshot.data
//                           ? Icons.play_circle_outline
//                           : Icons.pause_circle_outline),
//                       onPressed: () async {
//                         if (snapshot.data) {
//                           await context.read(audioPlayerProvider).pause();
//                         } else {
//                           await context.read(audioPlayerProvider).play();
//                         }
//                       },
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }
// }
