import 'package:artes/components/app_back_button.dart';
import 'package:artes/components/app_icon_button.dart';
import 'package:artes/components/app_snackbar.dart';
import 'package:artes/components/drawable_body.dart';
import 'package:artes/components/gap.dart';
import 'package:artes/components/user_image_circle.dart';
import 'package:artes/core/theme/app_colors.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:artes/models/user_model.dart';
import 'package:artes/modules/session_manager/controller/session_manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class CreateSessionPage extends StatefulWidget {
  const CreateSessionPage({super.key});

  @override
  State<CreateSessionPage> createState() => _CreateSessionPageState();
}

class _CreateSessionPageState extends State<CreateSessionPage> {
  late final SessionManagerController controller;
  late final String? sessionCode;

  @override
  void initState() {
    super.initState();
    controller = SessionManagerController();
    sessionCode = controller.createSession();
    if (sessionCode != null) _waitForSecondPlayer();
  }

  void _waitForSecondPlayer() async {
    UserModel? secondPlayer =
        await controller.waitForSecondPlayer(sessionCode!);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        AppSnackbar(
          duration: secondPlayer != null
              ? const Duration(seconds: 2)
              : const Duration(seconds: 60),
          content: Row(
            children: [
              secondPlayer != null
                  ? UserImageCircle(
                      photoUrl: secondPlayer.photoUrl,
                      size: 26,
                    )
                  : const SizedBox.shrink(),
              secondPlayer != null ? Gap.w(10) : const SizedBox.shrink(),
              Expanded(
                child: Text(
                  secondPlayer != null
                      ? '${secondPlayer.displayName.split(' ')[0]} entrou na sessão!'
                      : 'Erro ao entrar na sessão!',
                  textAlign: TextAlign.start,
                  style: const TextStyle()
                      .snackbar
                      .copyWith(overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
        ).launch,
      );
      if (secondPlayer != null) {
        Future.delayed(const Duration(milliseconds: 1250), () {
          Navigator.of(context).pushNamed('/match');
        });
      }
    }
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
                  sessionCode ?? 'Erro',
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
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppIconButton(
                  icon: Icons.share,
                  onPressed: () {
                    Share.share(
                        'Bó jogá 10 segundos de arte!\nCódigo da minha sessão: $sessionCode');
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
