import 'dart:typed_data';

import 'package:artes/components/gap.dart';
import 'package:artes/components/timer_widget.dart';
import 'package:artes/core/theme/app_colors.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:artes/modules/in_game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<TextEditingController> _controllers;
  bool isKeyboardOpen = false;
  late Future<List<dynamic>> future;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _controllers = List.generate(3, (index) => TextEditingController());
    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        setState(() {});
      }
    });
    future = _getDraws();
  }

  Future<List<Uint8List>> _getDraws() async =>
      await GameController().getDraws();

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Row(
          children: [
            Text('Tempo Restante: ', style: const TextStyle().label),
            TimerWidget(
              duration: 30,
              size: 28,
              onTimerEnd: () {
                for (var controller in _controllers) {
                  GameController().saveResponse(controller.text);
                }
                GameController().setResponsesToDb();
                Navigator.of(context).pushNamed('/timesOver');
              },
            ),
          ],
        ),
        automaticallyImplyLeading: false,
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
      body: TabBarView(
        controller: _tabController,
        children: List<Widget>.generate(3, (index) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                FutureBuilder<List>(
                  future: future,
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Erro: ${snapshot.error}');
                    } else {
                      return NeuCard(
                        cardWidth: double.infinity,
                        cardHeight: 500,
                        cardColor: AppColors.white,
                        child: Image.memory(snapshot.data![index]),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    'Descubra o que é...',
                    style: const TextStyle().title,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
      bottomSheet: Container(
        color: AppColors.white,
        child: Padding(
          padding: EdgeInsets.only(
            right: 16,
            left: 16,
            bottom: isKeyboardOpen == false ? 30 : 0,
          ),
          child: Row(
            children: [
              Expanded(
                child: NeuSearchBar(
                  searchController: _controllers[_tabController.index],
                  leadingIcon: const Icon(Icons.chat),
                  searchBarColor: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  hintText: 'Insira seu palpite',
                ),
              ),
              Gap.w(16),
              NeuIconButton(
                borderRadius: BorderRadius.circular(50),
                enableAnimation: true,
                icon: const Icon(Icons.send),
                buttonColor: AppColors.white,
                buttonWidth: 50,
                buttonHeight: 50,
                onPressed: () {
                  if (_tabController.index < _tabController.length - 1) {
                    _tabController.animateTo(_tabController.index + 1);
                  } else {
                    _tabController.animateTo(0);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
