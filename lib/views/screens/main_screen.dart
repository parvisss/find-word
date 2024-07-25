import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_83_dars_find_the_word/controllers/word_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find The Word Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final WordController wordController = Get.put(WordController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Find The Word"),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  "https://png.pngtree.com/thumb_back/fw800/background/20230705/pngtree-colorful-abstract-image_5938470.jpg",
                ),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Obx(
                  () {
                    return Text(
                      "Find the word: ${wordController.targetWord.value}",
                      style: const TextStyle(fontSize: 24),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Obx(
                  () {
                    final currentWord = wordController.targetWord.value;
                    return Flexible(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 60,
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 6.0,
                        ),
                        itemCount: currentWord.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: double.infinity,
                            child: Container(
                              transformAlignment: Alignment.center,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              alignment: Alignment.center,
                              child: Obx(
                                () {
                                  if (index <
                                      wordController.currentWord.value.length) {
                                    return Text(
                                      wordController.currentWord.value[index],
                                      style: const TextStyle(fontSize: 20),
                                    );
                                  } else {
                                    return const Text("");
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                Obx(
                  () {
                    final randomLetters = wordController.getRandomLetters();
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 50,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: randomLetters.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String letter = randomLetters[index];
                        return GestureDetector(
                          onTap: () {
                            wordController.addLetter(letter);
                          },
                          child: Center(
                            child: Container(
                              transformAlignment: Alignment.center,
                              alignment: Alignment.center,
                              color: Colors.blue,
                              child: Text(
                                letter,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FilledButton(
                      onPressed: () {
                        if (wordController.checkWord()) {
                          Get.snackbar(
                              "Congratulations!", "You found the word!",
                              snackPosition: SnackPosition.BOTTOM);
                          wordController.clearWord();
                          wordController.generateTargetWord();
                        } else {
                          Get.snackbar("Try Again", "Word not found.",
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      child: const Text("Check Word"),
                    ),
                    IconButton(
                        onPressed: () {
                          wordController.deleteLetter();
                        },
                        icon: const Icon(Icons.backspace))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
