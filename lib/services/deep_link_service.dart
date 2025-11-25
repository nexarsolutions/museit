import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'spotify_auth_service.dart';

class DeepLinkService extends GetxService {
  late final AppLinks _appLinks;

  Future<DeepLinkService> init() async {
    _appLinks = AppLinks();

    // If app opened via link when closed
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) _handleIncomingLink(initialLink);

    // Listen for incoming links
    _appLinks.uriLinkStream.listen(_handleIncomingLink);
    return this;
  }

  void _handleIncomingLink(Uri uri) {
    print('🎯 DeepLink received: $uri');
    if (uri.scheme == 'com.museit' && uri.host == 'spotify-callback') {
      print('🎯 DeepLink received: $uri');
      SpotifyAuthService().handleRedirect(uri);
    }
    // if (uri.scheme == 'com.museit' && uri.host == 'paypal-callback') {
    //   Get.back();
    // }
    // if (uri.scheme == 'com.museit' && uri.host == 'paypalFail-callback') {
    //   Get.back();
    // }
    // if (uri.scheme == 'com.museit' && uri.host == 'donate-callback') {
    //   Get.back();
    // }
    // if (uri.scheme == 'com.museit' && uri.host == 'donateFail-callback') {
    //   Get.back();
    // }
  }
}
