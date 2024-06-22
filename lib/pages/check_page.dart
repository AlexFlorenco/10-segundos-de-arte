import 'package:artes/models/words_model.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Resultado',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          indicatorColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
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
                NeuCard(
                  cardBorderColor:
                      WordsModel.instance.words[index].toLowerCase() ==
                              WordsModel.instance.responses[index].toLowerCase()
                          ? Colors.green[400]!
                          : Colors.red[400]!,
                  shadowColor: WordsModel.instance.words[index].toLowerCase() ==
                          WordsModel.instance.responses[index].toLowerCase()
                      ? Colors.green[400]!
                      : Colors.red[400]!,
                  cardWidth: double.infinity,
                  cardHeight: 500,
                  cardColor: Colors.white,
                  child: Image.memory(WordsModel.instance.images[index]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      Text(
                        'Este desenho era um(a) ${WordsModel.instance.words[index]}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Você respondeu: ${WordsModel.instance.responses[index]}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
