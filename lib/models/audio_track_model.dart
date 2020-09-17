class AudioTrackModel {
  final artistName;
  final trackName;
  final audioUrl;
  final thumbnail;

  AudioTrackModel(
      {this.artistName, this.trackName, this.audioUrl, this.thumbnail});

  bool get isEmpty =>
      this.artistName == null &&
      this.trackName == null &&
      this.audioUrl == null &&
      this.thumbnail == null;
}
