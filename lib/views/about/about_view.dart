import 'package:flutter/material.dart';
import 'package:transport/views/layout_template/layout_template.dart';

import '../../widgets/centered_view/centered_view.dart';

class AboutView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text('О КОМПАНИИ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(
                        text: "Мы ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      TextSpan(text: '- компания по грузоперевозкам, специализирующаяся на организации и обеспечении надежной и эффективной транспортировки грузов.'
                          ' С 2017 года мы успешно развиваем свой бизнес, стремясь удовлетворить потребности наших клиентов и превзойти их ожидания.',),
                    ]
                )
            ),
            SizedBox(height: 10,),
            Text('Наша компания была основана с целью предоставления надежных и эффективных решений в области транспортировки грузов.'
                ' Мы понимаем, что грузоперевозки играют важную роль в современной экономике, обеспечивая перевозку товаров и материалов от производителей до потребителей.'),
            SizedBox(height: 10,),
            Text('Что делает нас особенными?',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            SizedBox(height: 5,),
            Text('Наше внимание к деталям и стремление к высокому уровню обслуживания.'
                ' Мы заботимся о каждом клиенте и гарантируем, что их грузы будут доставлены вовремя и безопасно.'
                ' Мы осознаем, что каждая поставка имеет свои уникальные требования и особенности, и поэтому мы предлагаем индивидуальные решения, адаптированные под потребности каждого клиента.'),
            SizedBox(height: 10,),
            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(
                        text: "Наша команда ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      TextSpan(text: 'состоит из опытных специалистов в области логистики и транспортировки,'
                          ' которые всегда готовы предложить экспертную консультацию и помощь в выборе наиболее '
                          'подходящего решения для ваших грузоперевозок. Мы работаем с широким спектром клиентов,'
                          ' включая частных лиц и предприятия разных отраслей, и стремимся удовлетворить их потребности в грузоперевозках на самом высоком уровне',),
                    ]
                )
            ),
            SizedBox(height: 10,),
            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(
                        text: "Наша цель ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      TextSpan(text: '- обеспечить качественные и надежные грузоперевозки, которые помогут вам развивать свой бизнес и удовлетворять потребности ваших клиентов.'
                          ' Мы готовы стать вашим надежным партнером в области транспортировки грузов',),
                    ]
                )
            ),

            SizedBox(height: 15,),

          ],
        )
    );
  }
}
