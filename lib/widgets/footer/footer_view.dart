import 'package:flutter/material.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/widgets/contacts/social_media_view.dart';

import '../navigation_bar/navbar_item.dart';

class FooterView extends StatelessWidget {
  final Color textColor = Colors.white60;
  const FooterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[900]
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: 8.0,
        runSpacing: 10.0,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('lib/assets/images/delivery.png', color: Colors.white,),
              Column(
                children: [
                  Text("2023 © AirTrans", style: TextStyle(color: textColor),),
                  Text("Все права защищены", style: TextStyle(color: textColor),),
                ],
              ),

            ],
          ),
          Column(
            children: [
              _textHeader("Сервисы"),
              _footerNavItem(NavBarItem("Главная", homeRoute, color: textColor)),
              _footerNavItem(NavBarItem("Автопарк", carsRoute, color: textColor)),
              _footerNavItem(NavBarItem("Услуги", servicesRoute, color: textColor)),
            ],
          ),
          Column(
            children: [
              _textHeader("Компания"),
              _footerNavItem(NavBarItem("О Нас", aboutRoute, color: textColor)),
              _footerNavItem(NavBarItem("Контакты", contactsRoute, color: textColor)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _textHeader("Связаться с нами"),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.phone, color: textColor),
                  ),
                  Text('+375 (29) 28-08-724', style: TextStyle(color: textColor),)
                ],
              ),
              SocialMediaView(color: textColor)
            ],
          ),
        ],
      ),
    );
  }
  Widget _textHeader(String text) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16
        )
      ),
    );
  }
  Widget _footerNavItem(child) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: child
    );
  }
}
