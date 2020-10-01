import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/widgets/parent_widget.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';

class ContactScreen extends StatefulWidget {
  static final screenId = 'contactScreen';

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final Email email = Email(
    subject: 'Contacto de GPF App - Negocio',
    recipients: ['gordospfelices@gmail.com'],
    isHTML: false,
  );

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      bodyChild: Container(
        padding: k_appPadding,
        child: Column(
          children: [
            TitleWidget(
              leftIcon: Icons.arrow_back,
              onPressedLeftIcon: () => Navigator.pop(context),
              mainText:
                  'Gracias por expresar interes en usar nuestra applicación.',
              textStyle: k_16wStyle,
              secondaryText:
                  'Porfavor complete este formulario con su informacion y nos pondremos en contacto con'
                  ' usted en cuanto antes possible!',
            ),

            RedRoundedButton(
              buttonText: 'Enviar correo electronico',
              onTapFunction: () async => await FlutterEmailSender.send(email),
            ),

            /// The following widget is the form -> will not be used at the moment
            /*SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RedRoundedTextField(
                        hint: 'Nombre', textEditingController: null),
                    RedRoundedTextField(
                      hint: 'Nombre de negocio',
                      textEditingController: null,
                    ),
                    RedRoundedTextField(
                      hint: 'Correo Electronico',
                      textEditingController: null,
                    ),
                    RedRoundedTextField(
                      hint: 'Información extra...',
                      textEditingController: null,
                      isMultiLine: true,
                    ),
                    RedRoundedButton(
                      buttonText: 'Enviar',
                      onTapFunction: () {},
                    )
                  ],
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
