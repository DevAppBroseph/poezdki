import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const KScaffoldScreen(
      isLeading: true,
      title: 'Политика конфиденциально..',
      body: WebView(
        backgroundColor: Colors.white,
        initialUrl: 'https://pages.flycricket.io/poezdka/privacy.html',
      ),
    );
  }
}
