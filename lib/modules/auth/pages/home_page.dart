import 'dart:developer';

import 'package:artes/components/app_icon_button.dart';
import 'package:artes/components/app_snackbar.dart';
import 'package:artes/components/app_text_button.dart';
import 'package:artes/components/drawable_body.dart';
import 'package:artes/components/gap.dart';
import 'package:artes/core/theme/app_colors.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:artes/modules/auth/controller/auth_controller.dart';
import 'package:artes/modules/auth/pages/how_it_works_page.dart';
import 'package:artes/services/local_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _isLogged;

  @override
  void initState() {
    super.initState();
    _isLogged = LocalService.loadUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return DrawableBody(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          const Spacer(),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'ShantellSans',
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
              children: [
                TextSpan(text: '10', style: TextStyle(fontSize: 60)),
                TextSpan(text: 'segundos', style: TextStyle(fontSize: 40)),
                TextSpan(text: '\n'),
                TextSpan(text: 'de ', style: TextStyle(fontSize: 30)),
                TextSpan(
                    text: 'Arte', style: TextStyle(height: 0.8, fontSize: 60)),
              ],
            ),
          ),
          Gap.h(48),
          AppTextButton.light(
            label: 'JOGAR',
            onPressed: () async {
              if (_isLogged) {
                Navigator.pushNamed(context, '/lobby');
              } else {
                _isLogged = await AuthController.login();
                _isLogged
                    ? Navigator.pushNamed(context, '/lobby')
                    : _showSnackbar(Text('Login não efetuado!',
                        style: const TextStyle().snackbar));
              }
            },
          ),
          Gap.h(16),
          AppTextButton.light(
            label: 'MODO OFFLINE',
            onPressed: () async {
              final fcmToken = await FirebaseMessaging.instance.getToken();
              log(fcmToken.toString());
            },
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppIconButton(
                icon: Icons.question_mark_sharp,
                onPressed: _showHowItWorks,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _showHowItWorks() {
    showDialog(
      context: context,
      builder: (context) => const Scaffold(
        backgroundColor: Colors.transparent,
        body: HowItWorksPage(),
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
