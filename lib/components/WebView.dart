import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final _url;
  WebViewContainer(this._url);

  @override
  _WebViewContainerState createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  WebViewController? controller;

 bool back = false;

  @override void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller= WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget._url));
    });
  }
  @override
  Widget build(BuildContext context)  {
    return PopScope(
      canPop: back,
      onPopInvoked: (didPop) async {
        // onWillPop: () async {
        //   if(await _webViewController.canGoBack()){
        //     _webViewController.goBack();
        //     return false;
        //   }
        //   return true;
        // },

        if(await controller!.canGoBack()){
          controller!.goBack();
        }else{
          setState(() {
            back = true;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Question Bank'),
        ),
        body: WebViewWidget(controller: controller!, ),
      ),
    );
  }
}