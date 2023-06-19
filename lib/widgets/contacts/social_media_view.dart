import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaView extends StatelessWidget {
  Color color;
  SocialMediaView({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _socialButton("tg://t.me/TwiXyl9", Icon(Icons.telegram, color: color)),
        _socialButton("https://instagram.com/ulik_julik02?igshid=MmIzYWVlNDQ5Yg==", Icon(FontAwesomeIcons.instagram, color: color)),
        _socialButton("https://www.facebook.com/profile.php?id=100010204966384", Icon(FontAwesomeIcons.facebook, color: color)),
        _socialButton("https://vk.com/idgrasha", Image.asset('lib/assets/images/vk_logo_50.png', color: color)),
      ],
    );
  }
  Widget _socialButton(String path, icon) {
    return IconButton(
        onPressed: () async {
          var url = Uri.parse(path);
          if (!await launchUrl(url)) {
            throw Exception('Could not launch $url');
          }
        },
        icon: icon
    );
  }
}
