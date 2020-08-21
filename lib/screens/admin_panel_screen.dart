import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/screens/admin/new_category_screen.dart';
import 'package:gordos_pero_felizes/widgets/simple_text_button.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';

class AdminPanelScreen extends StatefulWidget {
  static final screenId = 'adminPanelScreen';

  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: k_appPadding,
          child: Column(
            children: [
              TitleWidget(
                leftIcon: Icons.arrow_back,
                onPressedLeftIcon: () => Navigator.pop(context),
                mainText: 'Portal para Administradores',
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SimpleTextButton(
                text: 'Agregar Categoría Nueva',
                onTapCallBack: () =>
                    Navigator.pushNamed(context, NewCategoryScreen.screenId),
              ),
              SimpleTextButton(
                text: 'Agregar Negocio Nuevo',
              ),
              SimpleTextButton(
                text: 'Editar Negocio',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
