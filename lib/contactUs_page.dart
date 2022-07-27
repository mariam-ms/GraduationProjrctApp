import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: "https://docs.google.com/forms/d/e/1FAIpQLSdAfu5sHBVlzR2VrdIbtGz6niXnIf_jHH-PFvnsSpKkyFltMw/viewform",
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate:( NavigationRequest request ){
            if (
            request.url.contains("https://docs.google.com/forms/d/e/1FAIpQLSdAfu5sHBVlzR2VrdIbtGz6niXnIf_jHH-PFvnsSpKkyFltMw/viewform")
            ) {
              return NavigationDecision.navigate;
            }
            return( NavigationDecision.prevent);


          }
      ),
    );
  }
}
