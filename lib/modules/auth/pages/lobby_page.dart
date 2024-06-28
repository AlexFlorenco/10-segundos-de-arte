import 'package:artes/components/app_back_button.dart';
import 'package:artes/components/app_snackbar.dart';
import 'package:artes/components/app_text_button.dart';
import 'package:artes/components/drawable_body.dart';
import 'package:artes/components/gap.dart';
import 'package:artes/components/user_image_circle.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:artes/data/user_data.dart';
import 'package:artes/modules/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key});

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  @override
  void initState() {
    super.initState();
    _showSnackbar(
      Row(
        children: [
          UserImageCircle(
            photoUrl: PlayersDetails.instance.player1!.photoUrl,
            size: 26,
          ),
          Gap.w(10),
          Expanded(
            child: Text(
              'Logado como ${PlayersDetails.instance.player1!.displayName}',
              textAlign: TextAlign.start,
              style: const TextStyle()
                  .snackbar
                  .copyWith(overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
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
                'INGRESSE EM UMA SESSÃO OU CRIE UMA NOVA',
                textAlign: TextAlign.center,
                style: const TextStyle().headline,
              ),
              Gap.h(48),
              AppTextButton.light(
                label: 'CRIAR SESSÃO',
                onPressed: () => Navigator.pushNamed(context, '/createSession'),
              ),
              Gap.h(16),
              AppTextButton.dark(
                label: 'INGRESSAR',
                onPressed: () => Navigator.pushNamed(context, '/joinSession'),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text('Deslogar', style: const TextStyle().logout),
                      Gap.w(10),
                      const Icon(Icons.exit_to_app)
                    ],
                  ),
                ),
                onTap: () {
                  AuthController.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  _showSnackbar(Widget content) {
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackbar(
            content: content,
          ).launch,
        );
      },
    );
  }
}
