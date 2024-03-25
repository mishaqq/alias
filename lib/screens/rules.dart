import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_model_provider.dart';

class RulesPage extends ConsumerWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 112, 150, 236),
              Color.fromARGB(255, 52, 104, 192)
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: h * 0.09,
            left: w * 0.075,
            right: w * 0.075,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 248, 237, 255),
                  border: Border.all(width: h * 0.0024),
                  borderRadius: BorderRadius.all(
                    Radius.circular(h * 0.018),
                  ),
                ),
                width: w * 0.85,
                height: h * 0.85,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: h * 0.015,
                    right: h * 0.015,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: h * 0.015,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        """1. Команди грають по черзі. Мінімум два гравця в кожній.

2. Один гравець має пояснювати слова для своєї команди. Інші члени команди вгадують.

3. Ви не маєте права використовувати будь-яку частину слова, коли ви пояснюєте, а також слова з одним коренем. Наприклад слово “автобус” не можна пояснити як “автомобільний транспортний засіб”. Ви можете сказати “маршрутний транспортний засіб”.

Ви не можете пояснити слово “банкір” як “людина, яка працює в банку”, тому що слова “банк” та “банкір” мають спільний корінь.

Слова не можна пояснювати іноземними мовами, якщо про це гравці не домовилися перед початком гри.

4. Кількість вгаданих слів відповідає кількості пунктів. Зроблені помилки і незрозумілі слова забирають пункти.

5. Якщо ввімкнене “Останнє слово для всіх”, то слово на момент закінчення часу в раунді може вгадувати будь-яка команда.

6. Команда перемагає коли набирає достатню кількість пунктів для перемоги (визначається в налаштуваннях).
""",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: h * 0.018,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
