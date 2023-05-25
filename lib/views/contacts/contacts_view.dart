import 'package:flutter/material.dart';
import 'package:transport/views/layout_template/layout_template.dart';
import 'package:transport/widgets/centered_view/centered_view.dart';

class ContactsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text('КОНТАКТЫ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
            Text('ИП Айрапетов с 2017 года развивает свой бизнес в области грузоперевозок.'
                ' За это время было профессионально оказано большое количество услуг.'
                ' Наша организация обслуживает не только частных лиц, но и коммерческие организации, розничные магазины,'
                ' производственные предприятия и другие бизнесы, требующие перевозки грузов.'),
            SizedBox(height: 15,),
            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(
                        text: "Электронная почта : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      TextSpan(text: "grant199494@mail.ru",),
                    ]
                )
            ),
            SizedBox(height: 15,),
            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(
                        text: "Телефон : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      TextSpan(text: "+375 (29) 28-08-724",),
                    ]
                )
            ),
            SizedBox(height: 15,),
            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(
                        text: "УНП : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      TextSpan(text: "591922986",),
                    ]
                )
            ),
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
        )
    );

  }
}
