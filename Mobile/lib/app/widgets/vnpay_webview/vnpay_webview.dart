import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../common/configs/configurations.dart';
// #enddocregion platform_imports

class VnPayWebView extends StatefulWidget {
  final String paymentLink;
  final EdgeInsets padding;
  final Function(String)? onReturnUrl;

  const VnPayWebView({
    Key? key,
    required this.paymentLink,
    this.padding = EdgeInsets.zero,
    this.onReturnUrl,
  }) : super(key: key);

  @override
  VnPayWebViewState createState() => VnPayWebViewState();
}

class VnPayWebViewState extends State<VnPayWebView> {
  bool loaded = false;

  ValueNotifier<double> height = ValueNotifier(1.sh);
  bool isInitialLoaded = false;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    controller = WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            if (!isInitialLoaded) {
              setState(() {
                isInitialLoaded = true;
                Get.find<CommonController>().stopLoading();
              });
            }

            final uri = Uri.parse(url);

            debugPrint('Page finished loading: $url');
            // uri
            if (uri.path == Configurations.returnEndpoint) {
              debugPrint('On return URL: $url');
              widget.onReturnUrl?.call(url);
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
            Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
                      ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentLink));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<CommonController>().startLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: height,
      builder: (BuildContext context, double height, Widget? child) {
        return Container(
          padding: widget.padding,
          width: 1.sw,
          height: height != 0 ? height : 1.sh,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildWebView(context),
              if (height == 0) const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWebView(BuildContext context) {
    return Opacity(
      opacity: isInitialLoaded ? 1 : 0,
      child: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
