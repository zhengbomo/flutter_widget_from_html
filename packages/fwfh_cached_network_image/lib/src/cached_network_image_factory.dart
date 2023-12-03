import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

/// A mixin that can render IMG with `cached_network_image` plugin.
mixin CachedNetworkImageFactory on WidgetFactory {
  /// Uses a custom cache manager.

  @override
  Widget? buildImageWidget(BuildMetadata meta, ImageSource src) {
    final url = src.url;
    if (!url.startsWith(RegExp('https?://'))) {
      return super.buildImageWidget(meta, src);
    }

    return FastCachedImage(
      url: url,
      fit: BoxFit.contain,
      fadeInDuration: const Duration(milliseconds: 250),
      errorBuilder: (context, exception, stacktrace) {
        if (kReleaseMode) {
          return widget0;
        } else {
          return Text(stacktrace.toString());
        }
      },
      loadingBuilder: (context, progress) =>
          onLoadingBuilder(
            context,
            meta,
            progress.totalBytes != null && progress.totalBytes! > 0
                ? progress.downloadedBytes / progress.totalBytes!
                : null,
            src,
          ) ??
          widget0,
    );
  }
}
