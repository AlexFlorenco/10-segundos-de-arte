import 'package:artes/components/app_back_button.dart';
import 'package:artes/components/app_form_field.dart';
import 'package:artes/components/app_snackbar.dart';
import 'package:artes/components/app_text_button.dart';
import 'package:artes/components/drawable_body.dart';
import 'package:artes/components/gap.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:artes/modules/session_manager/controller/session_manager_controller.dart';
import 'package:flutter/material.dart';

class JoinSessionPage extends StatefulWidget {
  const JoinSessionPage({super.key});

  @override
  State<JoinSessionPage> createState() => _JoinSessionPageState();
}

class _JoinSessionPageState extends State<JoinSessionPage> {
  late final SessionManagerController controller;
  late final TextEditingController inputController;

  @override
  void initState() {
    super.initState();
    controller = SessionManagerController();
    inputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return DrawableBody(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          const AppBackButton(),
          const Spacer(),
          Column(
            children: [
              Text(
                'INGRESSE EM UMA SESSÃO',
                textAlign: TextAlign.center,
                style: const TextStyle().headline,
              ),
              Gap.h(48),
              Text(
                textAlign: TextAlign.center,
                'Código da sessão:',
                style: const TextStyle().label,
              ),
              Gap.h(20),
              AppFormField(
                controller: inputController,
                icon: Icons.login_rounded,
                hint: '012345',
              ),
              Gap.h(20),
              AppTextButton(
                label: 'INGRESSAR',
                isDark: true,
                onPressed: () async {
                  bool response = await controller.joinSession(inputController.text);
                  if (!mounted) return;
                  if (response)  {
                    Navigator.pushNamed(context, '/match');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      AppSnackbar(
                        content: (Text('Sessão não encontrada!',
                            style: const TextStyle().snackbar)),
                      ).launch,
                    );
                  }
                },
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
