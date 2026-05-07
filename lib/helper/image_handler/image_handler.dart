
import 'package:gau_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:gau_app/utils/app_const/app_const.dart';

class ImageHandler {
  static String imagesHandle(String? url, {bool isProfile = false}) {
    final trimmedUrl = url?.trim() ?? '';
    if (trimmedUrl.isEmpty) {
      if (isProfile) {
        return AppConstants.unknown;
      }
      return AppConstants.unknown;
    }

    if (trimmedUrl.startsWith('http://') || trimmedUrl.startsWith('https://')) {
      return trimmedUrl;
    }

    // Backend can return host/path without scheme, e.g. cloudfront URLs.
    final looksLikeHostWithoutScheme = RegExp(r'^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$')
        .hasMatch(trimmedUrl);
    if (looksLikeHostWithoutScheme) {
      return 'https://$trimmedUrl';
    }

    return '${ApiUrl.imageUrl}$trimmedUrl';
    //  return ApiUrl.imageUrl + url;
  }
}