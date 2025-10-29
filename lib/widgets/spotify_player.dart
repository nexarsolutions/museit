import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpotifyPlayer extends StatefulWidget {
  final String trackUri;
  const SpotifyPlayer({super.key, required this.trackUri});

  @override
  State<SpotifyPlayer> createState() => _SpotifyPlayerState();
}

class _SpotifyPlayerState extends State<SpotifyPlayer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final html = '''
    <html>
      <body style="margin:0;padding:0;overflow:hidden;">
        <iframe src="https://open.spotify.com/embed/track/${widget.trackUri.split(':').last}"
          width="100%" height="380" frameborder="0"
          allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture">
        </iframe>
      </body>
    </html>
    ''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(html);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spotify Player")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
