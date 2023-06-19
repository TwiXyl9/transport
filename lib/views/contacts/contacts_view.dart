import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transport/views/layout_template/layout_template.dart';
import 'package:transport/widgets/centered_view/centered_view.dart';
import 'package:transport/widgets/contacts/social_media_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text('КОНТАКТЫ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text('ИП Айрапетов с 2017 года развивает свой бизнес в области грузоперевозок.'
                  ' За это время было профессионально оказано большое количество услуг.'
                  ' Наша организация обслуживает не только частных лиц, но и коммерческие организации, розничные магазины,'
                  ' производственные предприятия и другие бизнесы, требующие перевозки грузов.',),
              SizedBox(height: 15,),
              Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),
              SizedBox(height: 15,),
              Container(
                width: double.maxFinite,
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  spacing: 8.0,
                  runSpacing: 10.0,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoBlock("Название", "ИП Айрапетов Г. Ю."),
                        SizedBox(height: 15,),
                        _infoBlock("УНП", "591922986"),
                        SizedBox(height: 15,),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _infoBlock("Электронная почта", "grant199494@mail.ru"),
                        SizedBox( height: 15,),
                        _infoBlock("Телефон", "+375 (29) 28-08-724"),
                      ],
                    ),
                  ],
                ),
              ),
              SocialMediaView(color: Colors.black),
              SizedBox(height: 15,),
              Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),
              SizedBox(height: 15,),
              Text('На что вы можете расчитывать связавшись с нами?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text("1. Профессиональное обслуживание",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 7,),
              Text("Наша команда состоит из опытных и квалифицированных специалистов, готовых предоставить вам полезные и точные сведения."),
              SizedBox(height: 7,),
              Text("2. Подробные консультации",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 7,),
              Text("Мы готовы предоставить вам всю необходимую информацию о наших услугах, процессе работы, стоимости и других деталях, чтобы помочь вам принять взвешенное решение."),
              SizedBox(height: 7,),
              Text("3. Персонализированный подход",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 7,),
              Text("Мы понимаем, что каждый клиент уникален, поэтому мы готовы адаптировать наши решения под ваши потребности и требования."),
              SizedBox(height: 7,),
              Text("4. Своевременную обратную связь",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 7,),
              Text("Мы стремимся обеспечить быструю и эффективную коммуникацию с нашими клиентами, чтобы вы могли быть уверены, что ваш вопрос получит необходимое внимание.Не стесняйтесь связаться с нами через указанную контактную информацию. Мы готовы ответить на ваши вопросы и обеспечить вас качественным обслуживанием. "),
              SizedBox(height: 7,),
              Text("5. Ответы на вопросы",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              Text( "Вы можете задать любой вопрос, который у вас возник, и мы с радостью предоставим вам исчерпывающую информацию и решения."),
              SizedBox(height: 7,),
            ],
          ),
        )
    );

  }
  Widget _infoBlock(String blocName, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$blocName : ",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Color(0xFF72716E)
          ),
        ),
        SizedBox(height: 5,),
        Text(
            content,
            style: TextStyle(
            fontSize: 16,
              color: Color(0xFFCF4F4C)
          ),
            overflow: TextOverflow.ellipsis
        ),
      ]
    );
  }
}
