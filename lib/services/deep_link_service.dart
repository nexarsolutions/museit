import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'spotify_auth_service.dart';

class DeepLinkService extends GetxService {
  late final AppLinks _appLinks;
  // ---------- Singleton ----------
  DeepLinkService._internal();

  static final DeepLinkService _instance = DeepLinkService._internal();

  factory DeepLinkService() {
    _instance.initDeepLinkListener();
    return _instance;
  }

  Future<void> initDeepLinkListener() async {
    _appLinks = AppLinks();

    // Handle initial link (if the app was killed)
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) _handleIncomingLink(initialLink);

    // Handle stream (when app is running or in background)
    _appLinks.uriLinkStream.listen((uri) {
      _handleIncomingLink(uri);
    });
  }

  void _handleIncomingLink(Uri uri) {
    if (uri.scheme == 'com.museit' && uri.host == 'spotify-callback') {
      print("🎯 Received redirect: $uri");
      SpotifyAuthService().handleRedirect(uri);
    }
  }

}
