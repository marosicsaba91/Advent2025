import 'package:advent/clue_bell.dart';
import 'package:advent/clue_elements.dart';
import 'package:flutter/material.dart';

class Task {
  String icon;
  List<Widget> clues;
  String keyToSolve;

  Task({required this.icon, required this.clues, required this.keyToSolve});
}

class TaskManager {
  static Task? getTask(String taskId) => switch (taskId) {
    "🌏" => Task(
      // Task 1:  Zászlók és fővárosok
      icon: taskId, //  Földrajzi nyomok
      clues: [
        ClueImage("Flags1.png"),
        ClueImage("Flags2.png"),
        ClueImage("Flags3.png"),
        ClueImage("Flags4.png"),
        ClueColumn([
          ClueText(
            "Nem egyszerű. Kell hozzá némi ész,\n"
            "hogy a részekből legyen négy egész.\n"
            "A fővárosnál jelölj! Nem máshol, de pont ott!\n"
            "Emlékez, van úgy hogy …",
          ),
          ClueImage("Indiana.png"),
        ]),
        ClueText("Bár nem az első ki, rávetette szemét, de ő az kitől kapta ünnepi nevét?"),
      ],
      keyToSolve: "William Mynors",
    ),

    // Task 2:  Napkeleti bölcsek
    "⭐" => Task(
      icon: taskId,
      clues: [
        ClueImage("StarClue-ThreeWiseMan.png"),
        ClueTimeLock("Star-Sirius.png", "U", 12, 30, color: Color.fromARGB(255, 255, 162, 23)),
        ClueTimeLock("Star-Mars.png", "I", 12, 30, color: Color.fromARGB(255, 48, 23, 16)),
        ClueTimeLock("Star-Pluto.png", "E", 12, 20, color: Color.fromARGB(255, 71, 109, 153)),
        ClueTimeLock("Star-Saturn.png", "R", 12, 20, color: Color.fromARGB(255, 117, 30, 30)),
        ClueTimeLock("Star-AlphaCentauri.png", "C", 12, 20),
        ClueTimeLock("Star-Alnilam.png", "L", 12, 15,  color: Color.fromARGB(255, 62, 93, 107)),
        ClueTimeLock("Star-Andromeda.png", "F", 12, 20,  color: Color.fromARGB(255, 62, 63, 95)),
        ClueText("Mit szemléltek ha leszáll az est? Mi állt össze, mely égitest?"),
      ],
      keyToSolve: "Vénusz",
    ),

    // Task 3:  Harangok
    "🔔" => Task(
      icon: taskId,
      clues: [
        ClueBell("Bell6.png", "Bell 6-F#.mp3"),
        ClueBell("Bell4.png", "Bell 4-E.mp3"),
        ClueBell("Bell9.png", "Bell 9-D-.mp3"),
        ClueBell("Bell7.png", "Bell 7-B.mp3"),
        ClueBell("Bell8.png", "Bell 8-G.mp3"),
        ClueBell("Bell3.png", "Bell 3-D.mp3"),
        ClueBell("Bell5.png", "Bell 5-A.mp3"),
        ClueText("5 - 6 - 5 - 6 - 3 - 5 - 7 - 3 - 8 - 6 - 5 - 9 - 6 - 4"),
        ClueText("Ki a szerző? Ki lehetne más? Kicsit úgy fest, mint a Mikulás."),
      ],
      keyToSolve: "John Williams",
    ),

    // Task 4:   Utolsó vacsora matek
    "🍞" => Task(
      icon: taskId,
      clues: [
        ClueImage("Apostols 1.png"),
        ClueImage("Apostols 2.png"),
        ClueImage("Supper.png"),
        ClueImage("Apostols 3.png"),
        ClueImage("Leonardo.png"),
        ClueImage("Apostols 4.png"),
        ClueText("A kiszámolt megoldást alább betűzd, de ne számokat használj hanem betűzd!"),
      ],
      keyToSolve: "Huszonhét",
    ),

    // ---------------------------------------------------------------------------------------
    
    // Task 5:  Képek a városból
    "🎀" => Task(
      icon: taskId,
      clues: [
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
      ],
      keyToSolve: "TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO",
    ),

    // Task 6:  Évszám matek
    "🕯️" => Task(
      icon: taskId,
      clues: [
        ClueImage("HistorySecondTemple.png"),
        ClueImage("HistoryMohács.png"),
        ClueImage("HistoryMuhammad.png"),
        ClueImage("History1984.png"),
        ClueImage("HistoryCharlamene.png"),
        ClueText("2A - B - 3C + D + 3E = ???"),
        ClueText("Zengnek a harangok, készül a lakoma. Kinek van ma a legjobb karácsonya?"),
      ],
      keyToSolve: "Hódító Vilmos",
    ),

    // Task 7:  Karácsonyi filmes halmazelmélet
    "🎅" => Task(
      icon: taskId,
      clues: [
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
      ],
      keyToSolve: "TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO",
    ), 

    // Task 8:  Billentyűk a zongorán
    "🎺" => Task(
      icon: taskId,
      clues: [
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
      ],
      keyToSolve: "TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO",
    ), 

    // ---------------------------------------------------------------------------------------
    
    // Task 9:  Logikai karácsonyfa
    "🎄" => Task(
      icon: taskId,
      clues: [
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
      ],
      keyToSolve: "TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO",
    ), 
    
    // Task 10:  Karácsonyi színező
    "❄️" => Task(
      icon: taskId,
      clues: [
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
      ],
      keyToSolve: "TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO",
    ),
        
    // Task 11:  Karácsonyi süti: Vegyjelek
    "🍪" => Task(
      icon: taskId,
      clues: [
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
      ],
      keyToSolve: "TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO",
    ), 
        
    // Task 12:  Városliget térkép és koordinátáták
    "⛄" => Task(
      icon: taskId,
      clues: [
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
      ],
      keyToSolve: "TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO - TODO",
    ),

    // ---------------------------------------------------------------------------------------

    // Cryptex Task
    "🎁" => Task(
      icon: taskId,
      clues: [
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
        ClueText("TODO - TODO - TODO - TODO - TODO"),
      ],
      keyToSolve: "NINCS",
    ),

    _ => null,
  };
}
