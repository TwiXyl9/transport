import 'package:flutter/material.dart';

import '../contacts/contact_button.dart';
import '../order/order_button.dart';

class LayoutAdditionalPanel extends StatelessWidget {
  const LayoutAdditionalPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 23),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
          image: AssetImage('lib/assets/images/hrodno2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Грузоперевозки\nпо городу Гродно',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OrderButton(context),
                SizedBox(width: 10,),
                ContactButton()
              ],
            ),

          ],
        ),
      ),
    );
  }
}
