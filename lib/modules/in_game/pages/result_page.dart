import 'package:artes/components/app_text_button.dart';
import 'package:artes/components/gap.dart';
import 'package:artes/core/theme/app_colors.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:artes/modules/in_game/controller/game_controller.dart';
import 'package:artes/services/game_service.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showingFirstResult = true;
  late List<String> _remotePlayerWords;
  late List<String> _localPlayerResponses;

  late List<String> _localPlayerWords;
  late List<dynamic> _remotePlayerResponses;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _remotePlayerWords = GameService.instance.remotePlayerWords
        .map((e) => e.toLowerCase().trim())
        .toList();
    _localPlayerResponses = GameService.instance.localPlayerResponses
        .map((e) => e.toLowerCase().trim())
        .toList();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await GameController().getRemotePlayerResponses();
      _localPlayerWords = GameService.instance.localPlayerWords.map((e) {
        return e.toLowerCase().trim();
      }).toList();
      _remotePlayerResponses =
          GameService.instance.remotePlayerResponses.map((e) {
        return e.toLowerCase().trim();
      }).toList();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: showingFirstResult
            ? Text('Seu Resultado', style: const TextStyle().label)
            : Text('Resultado do Oponente', style: const TextStyle().label),
        bottom: TabBar(
          indicatorColor: AppColors.black,
          unselectedLabelColor: AppColors.darkGrey,
          labelColor: AppColors.black,
          dividerColor: Colors.transparent,
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.looks_one)),
            Tab(icon: Icon(Icons.looks_two)),
            Tab(icon: Icon(Icons.looks_3)),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List<Widget>.generate(3, (index) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        showingFirstResult
                            ? NeuCard(
                                cardBorderColor: _remotePlayerWords[index]
                                            .toLowerCase()
                                            .trim() ==
                                        _localPlayerResponses[index]
                                            .toLowerCase()
                                            .trim()
                                    ? Colors.green[400]!
                                    : Colors.red[400]!,
                                shadowColor: _remotePlayerWords[index]
                                            .toLowerCase()
                                            .trim() ==
                                        _localPlayerResponses[index]
                                            .toLowerCase()
                                            .trim()
                                    ? Colors.green[400]!
                                    : Colors.red[400]!,
                                cardWidth: double.infinity,
                                cardHeight: 480,
                                cardColor: Colors.white,
                                child: Image.memory(GameService
                                    .instance.remotePlayerDraws[index]),
                              )
                            : NeuCard(
                                cardBorderColor: _localPlayerWords[index]
                                            .toLowerCase()
                                            .trim() ==
                                        _remotePlayerResponses[index]
                                            .toLowerCase()
                                            .trim()
                                    ? Colors.green[400]!
                                    : Colors.red[400]!,
                                shadowColor: _localPlayerWords[index]
                                            .toLowerCase()
                                            .trim() ==
                                        _remotePlayerResponses[index]
                                            .toLowerCase()
                                            .trim()
                                    ? Colors.green[400]!
                                    : Colors.red[400]!,
                                cardWidth: double.infinity,
                                cardHeight: 480,
                                cardColor: Colors.white,
                                child: Image.memory(GameService
                                    .instance.localPlayerDraws[index]),
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: showingFirstResult
                              ? Column(
                                  children: [
                                    Text(
                                      'Este desenho era um(a) ${GameService.instance.remotePlayerWords[index]}',
                                      style: const TextStyle().body,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Você respondeu: ${_localPlayerResponses[index]}',
                                      style: const TextStyle().body,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Text(
                                      'Você desenhou um(a) ${GameService.instance.localPlayerWords[index]}',
                                      style: const TextStyle().body,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Seu oponente respondeu: ${_remotePlayerResponses[index]}',
                                      style: const TextStyle().body,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppTextButton(
                  label:
                      showingFirstResult ? 'VER OPONENTE' : 'VER SEU RESULTADO',
                  onPressed: () async {
                    setState(() {
                      showingFirstResult = !showingFirstResult;
                    });
                  }),
            ),
            Gap.h(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppTextButton(
                label: 'PROSSEGUIR',
                isDark: true,
                onPressed: () {
                  Navigator.pushNamed(context, '/points');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
