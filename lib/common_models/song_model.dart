class SongModel {
  final String imagePath;
  final String songName;
  final String length;
  final String? link;

  SongModel(
      {required this.imagePath,
      required this.songName,
      required this.length,
      this.link});
}
