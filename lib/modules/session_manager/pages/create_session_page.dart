import 'package:artes/components/app_back_button.dart';
import 'package:artes/components/drawable_body.dart';
import 'package:artes/components/gap.dart';
import 'package:artes/core/theme/app_colors.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:artes/modules/session_manager/controller/session_manager_controller.dart';
import 'package:flutter/material.dart';

class CreateSessionPage extends StatefulWidget {
  const CreateSessionPage({super.key});

  @override
  State<CreateSessionPage> createState() => _CreateSessionPageState();
}

class _CreateSessionPageState extends State<CreateSessionPage> {
  late final SessionManagerController sessionManagerController;
  late final String sessionCode;

  @override
  void initState() {
    super.initState();
    sessionManagerController = SessionManagerController();
    sessionCode = sessionManagerController.createSession(context);
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
                'AGUARDANDO JOGADOR...',
                textAlign: TextAlign.center,
                style: const TextStyle().headline,
              ),
              Gap.h(48),
              Text(
                textAlign: TextAlign.center,
                'CÓDIGO DA SESSÃO:',
                style: const TextStyle().label,
              ),
              Text(
                sessionCode,
                textAlign: TextAlign.center,
                style: const TextStyle().display,
              ),
              Gap.h(20),
              const LinearProgressIndicator(
                backgroundColor: AppColors.darkGrey,
                color: AppColors.black,
              ),
            ],
          ),
          const Spacer()
        ],
      ),
    );
  }
}
