import 'package:just_audio/just_audio.dart';

class PreviewPlayer {
  final _player = AudioPlayer();

  Future<void> playPreview(String url) async {
    await _player.setUrl(url);
    _player.play();
  }

  void stop() => _player.stop();
}
